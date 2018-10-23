//
//  EventModel.m
//  RealmDemo
//
//  Created by Phuc Nguyen on 10/3/18.
//  Copyright © 2018 Phuc Nguyen. All rights reserved.
//

#import "EventModel.h"

@implementation EventModel

- (instancetype)init {
    self = [super initStandard];
    if (self) {
        self.timeStart = [self randomDate];
        self.timeEnd = [self.timeStart dateByAddingTimeInterval:86400];
    }
    
    return self;
}

- (instancetype)initWithTimeStart:(NSDate *)timeStart timeEnd:(NSDate *)timeEnd {
    self = [self init];
    if (self) {
        self.timeStart = timeStart;
        self.timeEnd = timeEnd;
    }
    
    return self;
}

- (NSString *)getDBName {
    return @"Event";
}

- (NSMutableDictionary *)getDictionary {
    NSMutableDictionary *dict = [super getDictionary];
    
    dict[@"timeStart"] = self.timeStart;
    dict[@"timeEnd"] = self.timeEnd;
    
    return dict;
}

- (void)updateByDictionary:(NSDictionary *)dict {
    [super updateByDictionary:dict];
    
    self.timeStart = dict[@"timeStart"];
    self.timeEnd = dict[@"timeEnd"];
}

@end
