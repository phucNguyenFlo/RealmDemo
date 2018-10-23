//
//  FileModel.m
//  RealmDemo
//
//  Created by Phuc Nguyen on 10/3/18.
//  Copyright © 2018 Phuc Nguyen. All rights reserved.
//

#import "FileModel.h"

@implementation FileModel

- (instancetype)init {
    self = [super initStandard];
    if (self) {
        self.filePath = [self randomString];
    }
    return self;
}

- (instancetype)initWithFilePath:(NSString *)filePath {
    self = [self init];
    if (self) {
        self.filePath = filePath;
    }
    
    return self;
}

- (NSString *)getDBName {
    return @"File";
}

- (NSMutableDictionary *)getDictionary {
    NSMutableDictionary *dict = [super getDictionary];
    
    dict[@"filePath"] = self.filePath;
    
    return dict;
}

- (void)updateByDictionary:(NSDictionary *)dict {
    [super updateByDictionary:dict];
    
    self.filePath = dict[@"filePath"];
}

@end
