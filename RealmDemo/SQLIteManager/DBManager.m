//
//  DBManager.m
//  RealmDemo
//
//  Created by Phuc Nguyen on 10/4/18.
//  Copyright © 2018 Phuc Nguyen. All rights reserved.
//

#import "DBManager.h"
#import "CommonDefine.h"

#import <sqlite3/sqlite3.h>
#import <FMDB/FMDB.h>

@interface DBManager()


@property (strong, nonatomic) FMDatabase *db;
@property (strong, nonatomic) FMDatabaseQueue *dbQueue;

@end

@implementation DBManager

+ (id)sharedInstance {
    static DBManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DBManager alloc] init];
        
        [sharedInstance copySQLFileIfNeed];
    });
    
    if (sharedInstance.db == nil) {
        // Get default realm path from App group
        NSUserDefaults *userDefault = [[NSUserDefaults alloc] initWithSuiteName:APP_GROUP_NAME];
        NSString *sqlPath = [userDefault objectForKey:DEMO_SQL_PATH];
        NSURL *sqlURL = [NSURL fileURLWithPath:sqlPath];
        
        sharedInstance.db = [FMDatabase databaseWithURL:sqlURL];
        
        sharedInstance.dbQueue = [[FMDatabaseQueue alloc] initWithURL:sqlURL];
    }
    
    return sharedInstance;
}

- (void)copySQLFileIfNeed {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *folderPath = [paths objectAtIndex:0];
    
    // Keep the database filename.
    NSString *DBFileName = DEMO_SQL_PATH;
    
    // Copy the database file into the documents directory if necessary.
    NSString *destinationPath = [folderPath stringByAppendingPathComponent:DBFileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:destinationPath] == NO) {
        // The database file does not exist in the documents directory, so copy it from the main bundle now.
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"DemoDB" ofType:@"db"];
        
        NSError *error;
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destinationPath error:&error];
        
        if (error == nil) {
            NSUserDefaults *userDefault = [[NSUserDefaults alloc] initWithSuiteName:APP_GROUP_NAME];
            [userDefault setObject:destinationPath forKey:DEMO_SQL_PATH];
        }
    }
}

- (void)insertDemoData:(AbstractModel *)data {
    NSDictionary *dataDict = [data getDictionary];
    
    // Get key value
    NSArray *keyArray = [dataDict allKeys];
    NSMutableArray *valueArray = [[NSMutableArray alloc] init];
    NSString *keyString = [keyArray componentsJoinedByString:@","];
    
    // Get input, insert value.
    NSMutableArray *inputArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < keyArray.count; i++) {
        [inputArray addObject:@"?"];
        
        NSString *key = keyArray[i];
        [valueArray addObject:dataDict[key]];
    }
    NSString *inputString = [inputArray componentsJoinedByString:@","];
    
    // Create SQL
    NSString *tableName = [data getDBName];
    NSString *query = [NSString stringWithFormat:@"INSERT INTO %@ (%@) VALUES (%@)", tableName, keyString, inputString];
    
    
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        BOOL success = [db executeUpdate:query withArgumentsInArray:valueArray];
        if (!success) {
            NSLog(@"error = %@", [db lastErrorMessage]);
        }
    }];
}

- (NSArray *)getAllDemoData:(AbstractModel *)data {
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    NSString *tableName = [data getDBName];
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM %@", tableName];
    
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        FMResultSet *result = [db executeQuery:query];
        while ([result next]) {
            NSDictionary *dict = [result resultDictionary];
            
            AbstractModel *dataItem = [[[data class] alloc] init];
            [dataItem updateByDictionary:dict];
            
            [dataArray addObject:dataItem];
        }
        
        [result close];
    }];
    
    [self.dbQueue close];
    
    return dataArray;
}

- (NSMutableArray *)selectDemoData:(AbstractModel *)data withPredicate:(NSString *)predicate {
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    NSString *tableName = [data getDBName];
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@", tableName, predicate];
    
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        FMResultSet *result = [db executeQuery:query];
        while ([result next]) {
            NSDictionary *dict = [result resultDictionary];
            
            AbstractModel *dataItem = [[[data class] alloc] init];
            [dataItem updateByDictionary:dict];
            
            [dataArray addObject:dataItem];
        }
        
        [result close];
    }];
    
    [self.dbQueue close];
    
    return dataArray;
}

- (BOOL)deleteDemoData:(AbstractModel *)data {
    __block BOOL isDeleteSuccess = NO;
    
    NSString *tableName = [data getDBName];
    NSString *query = [NSString stringWithFormat:@"DELETE FROM %@", tableName];
    
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        isDeleteSuccess = [db executeUpdate:query];
    }];
    
    [self.dbQueue close];
    
    return isDeleteSuccess;
}


@end
