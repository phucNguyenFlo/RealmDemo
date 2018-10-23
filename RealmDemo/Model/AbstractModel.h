//
//  AbstractModel.h
//  RealmDemo
//
//  Created by Phuc Nguyen on 10/3/18.
//  Copyright © 2018 Phuc Nguyen. All rights reserved.
//

#import "RLMObject.h"

@interface AbstractModel : RLMObject

@property NSInteger primaryKey;
@property NSString *syncID;
@property NSString *title;


- (instancetype)initStandard;

- (NSString *)getDBName;

- (NSString *)randomString;
- (NSDate *)randomDate;

#pragma mark - SQL
- (void)generaInsertQuery;
- (NSMutableDictionary *)getDictionary;
- (void)generaInsertQuery;
- (void)updateByDictionary:(NSDictionary *)dict;


@end


RLM_ARRAY_TYPE(AbstractModel)
