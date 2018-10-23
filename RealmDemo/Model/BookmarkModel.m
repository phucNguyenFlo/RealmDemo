//
//  BookmarkModel.m
//  RealmDemo
//
//  Created by Phuc Nguyen on 10/3/18.
//  Copyright © 2018 Phuc Nguyen. All rights reserved.
//

#import "BookmarkModel.h"

@implementation BookmarkModel

- (instancetype)init {
    self = [super initStandard];
    if (self) {
        self.urlString = [self randomString];
    }
    return self;
}

- (instancetype)initWithUrlString:(NSString *)urlString {
    self = [self init];
    if (self) {
        self.urlString = urlString;
    }
    
    return self;
}

- (NSString *)getDBName {
    return @"Bookmark";
}

- (NSMutableDictionary *)getDictionary {
    NSMutableDictionary *dict = [super getDictionary];
    
    dict[@"urlString"] = self.urlString;
    
    return dict;
}

- (void)updateByDictionary:(NSDictionary *)dict {
    [super updateByDictionary:dict];
    
    self.urlString = dict[@"urlString"];
}

@end
