//
//  AbstractModel.m
//  RealmDemo
//
//  Created by Phuc Nguyen on 10/3/18.
//  Copyright © 2018 Phuc Nguyen. All rights reserved.
//

#import "AbstractModel.h"

@implementation AbstractModel

- (instancetype)initStandard {
    self = [super init];
    if (self) {
        self.primaryKey = 1;
        self.syncID = [[NSUUID UUID] UUIDString];
        self.title = [self randomString];
    }
    return self;
}

- (NSString *)getDBName {
    return self.title;
}

- (NSString *)randomString {
    NSString *htmlString = @" Lorem ipsum dolor sit amet, consectetur adipiscing elit. In fringilla vehicula feugiat. Suspendisse potenti. Morbi mollis nunc luctus libero condimentum, et egestas velit placerat. Nullam placerat fermentum sollicitudin. Nam feugiat nulla sed enim pellentesque, ut mollis leo tristique. Nullam et tristique ligula. Cras orci felis, vestibulum ac accumsan et, elementum quis risus. Quisque tempus sed diam eu dictum. Nulla tortor est, suscipit vitae interdum congue, rhoncus ac nibh. Vivamus et auctor nunc. Nam ac facilisis nisl.";
    NSArray *htmlArray = [htmlString componentsSeparatedByString:@" "];
    NSInteger maxLength = 10;
    
    NSInteger location = (NSInteger) arc4random_uniform((uint32_t)(htmlArray.count - maxLength - 1));
    NSInteger length = (NSInteger) (maxLength % (arc4random_uniform((uint32_t)maxLength) + 1)) + 1;
    NSRange stringRange = NSMakeRange(location, length);
    NSString *resultString = [[htmlArray subarrayWithRange:stringRange] componentsJoinedByString:@" "];
    
    return resultString;
}

- (NSDate *)randomDate {
    NSDate *now = [NSDate date];
    NSTimeInterval timeInterval = arc4random_uniform([now timeIntervalSince1970]);
    
    NSDate *randomDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    return randomDate;
}

- (NSMutableDictionary *)getDictionary {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
//    dict[@"primaryKey"] = @(self.primaryKey);
    dict[@"syncID"] = self.syncID;
    dict[@"title"] = self.title;
    
    return dict;
}

- (void)updateByDictionary:(NSDictionary *)dict {
    self.primaryKey = [dict[@"primaryKey"] integerValue];
    self.syncID = dict[@"syncID"];
    self.title = dict[@"title"];
}

@end
