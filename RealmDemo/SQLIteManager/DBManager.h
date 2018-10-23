//
//  DBManager.h
//  RealmDemo
//
//  Created by Phuc Nguyen on 10/4/18.
//  Copyright © 2018 Phuc Nguyen. All rights reserved.
//

#import "AbstractModel.h"

@interface DBManager : NSObject

+ (id)sharedInstance;

- (void)insertDemoData:(AbstractModel *)data;

- (NSArray *)getAllDemoData:(AbstractModel *)data;
- (NSMutableArray *)selectDemoData:(AbstractModel *)data withPredicate:(NSString *)predicate;

- (BOOL)deleteDemoData:(AbstractModel *)data;

@end
