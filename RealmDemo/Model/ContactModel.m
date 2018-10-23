//
//  ContactModel.m
//  RealmDemo
//
//  Created by Phuc Nguyen on 10/3/18.
//  Copyright © 2018 Phuc Nguyen. All rights reserved.
//

#import "ContactModel.h"

@implementation ContactModel

- (instancetype)init {
    self = [super initStandard];
    if (self) {
        self.phoneNumber = [self randomString];
        self.email = [self randomString];
    }
    return self;
}

- (instancetype)initWithPhoneNumber:(NSString *)phoneNumber email:(NSString *)email {
    self = [self init];
    if (self) {
        self.phoneNumber = phoneNumber;
        self.email = email;
    }
    
    return self;
}

- (NSString *)getDBName {
    return @"Contact";
}

- (NSMutableDictionary *)getDictionary {
    NSMutableDictionary *dict = [super getDictionary];
    
    dict[@"phoneNumber"] = self.phoneNumber;
    dict[@"email"] = self.email;
    
    return dict;
}

- (void)updateByDictionary:(NSDictionary *)dict {
    [super updateByDictionary:dict];
    
    self.phoneNumber = dict[@"phoneNumber"];
    self.email = dict[@"email"];
}

@end
