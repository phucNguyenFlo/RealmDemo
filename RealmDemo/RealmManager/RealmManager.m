//
//  RealmManager.m
//  RealmDemo
//
//  Created by Phuc Nguyen on 10/1/18.
//  Copyright © 2018 Phuc Nguyen. All rights reserved.
//

#import "RealmManager.h"
#import "DemoModel.h"
#import "BookmarkModel.h"
#import "CommonDefine.h"
#import "EmailMessageModel.h"

@interface RealmManager()

@property (strong, nonatomic) NSString *defaultRealmPath;

@end

@implementation RealmManager

+ (instancetype)sharedInstance {
    static RealmManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RealmManager alloc] init];
        
        // Get default realm path from App group
        NSUserDefaults *userDefault = [[NSUserDefaults alloc] initWithSuiteName:APP_GROUP_NAME];
        sharedInstance.defaultRealmPath = [userDefault objectForKey:DEFAULT_REALM_PATH];
    });
    
    return sharedInstance;
}

- (void)saveRealmURLPathIntoAppGroup {
    NSUserDefaults *userDefault = [[NSUserDefaults alloc] initWithSuiteName:APP_GROUP_NAME];
    
    NSString *defaultRealmPath = [userDefault objectForKey:DEFAULT_REALM_PATH];
    if (defaultRealmPath == nil) {
        RLMRealm *defaultRealm = [RLMRealm defaultRealm];
        NSString *defaultRealmPath = defaultRealm.configuration.fileURL.absoluteString;
        
        [userDefault setObject:defaultRealmPath forKey:DEFAULT_REALM_PATH];
        [userDefault synchronize];
    }
}

- (NSURL *)getRealmPathOfData:(NSString *)dataName {
    if (dataName.length > 0) {
        if (self.defaultRealmPath != nil || self.defaultRealmPath.length > 0) {
            NSMutableArray *defaultPathArray = [[self.defaultRealmPath componentsSeparatedByString:@"/"] mutableCopy];
            [defaultPathArray removeLastObject];
            
            NSString *folderPath = [defaultPathArray componentsJoinedByString:@"/"];
            
            NSString *dataPath = [NSString stringWithFormat:@"%@/%@.realm", folderPath, dataName];
            NSURL *dataURL = [NSURL URLWithString:dataPath];
            
            return dataURL;
        }
    }
    
    return nil;
}

- (RLMRealm *)getRealmOfData:(AbstractModel *)data {
    NSURL *dataRealmURL = [self getRealmPathOfData:[data getDBName]];
    RLMRealm *dataRealm = [RLMRealm realmWithURL:dataRealmURL];

    return dataRealm;
}

- (RLMResults *)getAllDemoFromDefaultRealm {
    BookmarkModel *bookmark = [[BookmarkModel alloc] init];
    RLMRealm *bookmarkRealm = [self getRealmOfData:bookmark];
    
    NSLog(@"Henry 1");
    
    [bookmarkRealm beginWriteTransaction];
    
    
    
//    [bookmarkRealm deleteAllObjects];
    for (int i = 0; i < 5000; i++) {
        // Insert
//        BookmarkModel *bookmark1 = [[BookmarkModel alloc] init];
//        [bookmarkRealm addObject:bookmark1];
        
        // Update
        BookmarkModel *bm = [BookmarkModel objectsInRealm:bookmarkRealm where:@"title CONTAINS 'Bookmark'"].firstObject;
        bm.urlString = [[NSUUID UUID] UUIDString];
        bm.title = @"Book";
        
        // Delete
//        [bookmarkRealm deleteAllObjects];
    }
    
    
    
    
    [bookmarkRealm commitWriteTransaction];
    
    
    NSLog(@"Henry 2");
    
    return nil;
}

- (void)resolveCompactOfData:(AbstractModel *)data {
    RLMRealm *dataRealm = [self getRealmOfData:data];
    
    NSString *realmPath = dataRealm.configuration.fileURL.absoluteString;
    NSMutableArray *realmPathArray = [[realmPath componentsSeparatedByString:@"/"] mutableCopy];
    [realmPathArray removeLastObject];
    
    NSString *folderPath = [realmPathArray componentsJoinedByString:@"/"];
    
    NSString *backupRealmPath = [NSString stringWithFormat:@"%@/%@_backup.realm", folderPath, [data getDBName]];
    NSURL *backupURL = [NSURL URLWithString:backupRealmPath];
    
    NSError *transactionError;
    [dataRealm transactionWithBlock:^{
        NSError *error;
        [dataRealm writeCopyToURL:backupURL encryptionKey:nil error:&error];
    } error:&transactionError];
    
}

- (BOOL)verifyResultWithError:(NSError *)error {
    if (error == nil) {
        return YES;
    } else {
        NSLog(@"Error: %@", error);
        return NO;
    }
}

#pragma mark - Get / Select
- (RLMResults *)getAllDataOfData:(AbstractModel *)data {
    RLMRealm *dataRealm = [self getRealmOfData:data];
    
    return [EmailMessageModel allObjectsInRealm:dataRealm];
}

- (RLMResults *)selectObjectOfData:(AbstractModel *)data predicate:(NSString *)predicate {
    RLMRealm *realm = [self getRealmOfData:data];
    
    return [[data class] objectsInRealm:realm where:predicate];
}

#pragma mark - Insert
- (BOOL)insertData:(AbstractModel *)data {
    RLMRealm *dataRealm = [self getRealmOfData:data];
    
    NSError *error = nil;
    [dataRealm transactionWithBlock:^{
        // Increase Primary key.
        [dataRealm addObject:data];
    } error:&error];
    
    return [self verifyResultWithError:error];
}

#pragma mark - Update


#pragma mark - Delete
- (BOOL)deleteAllObjectData:(AbstractModel *)data {
    RLMRealm *realm = [self getRealmOfData:data];
    
    NSError *error = nil;
    [realm transactionWithBlock:^{
        [realm deleteAllObjects];
    } error:&error];
    
    return [self verifyResultWithError:error];
}





@end
