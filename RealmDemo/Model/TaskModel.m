//
//  TaskModel.m
//  RealmDemo
//
//  Created by Phuc Nguyen on 10/3/18.
//  Copyright © 2018 Phuc Nguyen. All rights reserved.
//

#import "TaskModel.h"

@implementation TaskModel

- (instancetype)init {
    self = [super initStandard];
    if (self) {
        self.content = [self randomString];
    }
    return self;
}

- (instancetype)initWithContent:(NSString *)content {
    self = [self init];
    if (self) {
        self.content = content;
    }
    
    return self;
}

- (NSString *)getDBName {
    return @"Task";
}

- (NSMutableDictionary *)getDictionary {
    NSMutableDictionary *dict = [super getDictionary];
    
    dict[@"content"] = self.content;
    
    return dict;
}

- (void)updateByDictionary:(NSDictionary *)dict {
    [super updateByDictionary:dict];
    
    self.content = dict[@"content"];
}

@end
