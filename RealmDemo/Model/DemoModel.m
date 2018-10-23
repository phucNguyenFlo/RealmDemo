//
//  DemoModel.m
//  RealmDemo
//
//  Created by Phuc Nguyen on 9/28/18.
//  Copyright © 2018 Phuc Nguyen. All rights reserved.
//

#import "DemoModel.h"
#include <stdlib.h>

@implementation DemoModel

- (void)updateDataWithName:(NSString *)name address:(NSString *)address bio:(NSString *)bio {
    self.name = name;
    self.address = address;
    self.bio = bio;
}

- (instancetype)initRandom {
    self = [super init];
    if (self) {
//        self.name = [self randomString];
//        self.address = [self randomString];
//        self.bio = [self randomString];
    }
    
    return self;
}



@end
