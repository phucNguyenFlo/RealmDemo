//
//  EmailMessageModel.m
//  RealmDemo
//
//  Created by Phuc Nguyen on 10/3/18.
//  Copyright © 2018 Phuc Nguyen. All rights reserved.
//

#import "EmailMessageModel.h"

@implementation EmailMessageModel

- (instancetype)init {
    self = [super initStandard];
    if (self) {
        self.subject = [self randomString];
        self.body = [self randomString];
    }
    return self;
}

- (instancetype)initWithSubject:(NSString *)subject body:(NSString *)body  {
    self = [self init];
    if (self) {
        self.subject = subject;
        self.body = body;
    }
    
    return self;
}

- (NSString *)getDBName {
    return @"EmailMessage";
}

- (NSMutableDictionary *)getDictionary {
    NSMutableDictionary *dict = [super getDictionary];
    
    dict[@"subject"] = self.subject;
    dict[@"body"] = self.body;
    
    return dict;
}

- (void)updateByDictionary:(NSDictionary *)dict {
    [super updateByDictionary:dict];
    
    self.subject = dict[@"subject"];
    self.body = dict[@"body"];
}

@end
