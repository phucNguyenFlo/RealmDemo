//
//  DemoModel.h
//  RealmDemo
//
//  Created by Phuc Nguyen on 9/28/18.
//  Copyright © 2018 Phuc Nguyen. All rights reserved.
//

#import "RLMObject.h"
#import <Realm/Realm.h>

@interface DemoModel : RLMObject
@property NSString * name;
@property NSString *address;
@property NSString *bio;

- (instancetype)initRandom;
- (void)updateDataWithName:(NSString *)name address:(NSString *)address bio:(NSString *)bio;

@end

RLM_ARRAY_TYPE(DemoModel)
