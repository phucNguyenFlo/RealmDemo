//
//  RealmManager.h
//  RealmDemo
//
//  Created by Phuc Nguyen on 10/1/18.
//  Copyright © 2018 Phuc Nguyen. All rights reserved.
//

#import <Realm/Realm.h>
#import <Foundation/Foundation.h>

#import "AbstractModel.h"

@interface RealmManager : NSObject

+ (instancetype)sharedInstance;
- (void)saveRealmURLPathIntoAppGroup;

- (void)resolveCompactOfData:(AbstractModel *)data;

- (RLMRealm *)getRealmOfData:(AbstractModel *)data;

#pragma mark - Get
- (RLMResults *)getAllDataOfData:(AbstractModel *)data;
- (RLMResults *)selectObjectOfData:(AbstractModel *)data predicate:(NSString *)predicate;

#pragma mark - Insert
- (BOOL)insertData:(AbstractModel *)data;

#pragma mark - Update


#pragma mark - Delete
- (BOOL)deleteAllObjectData:(AbstractModel *)data;




@end
