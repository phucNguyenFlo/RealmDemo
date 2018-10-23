//
//  main.m
//  RealmDemoCommandLine
//
//  Created by Phuc Nguyen on 10/1/18.
//  Copyright © 2018 Phuc Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RealmManager.h"
#import "DemoModel.h"
#import "BookmarkModel.h"


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        [[RealmManager sharedInstance] deleteAllObjectData:[[BookmarkModel alloc] init]];
        
        for (NSInteger i = 0; i < 100; i++) {
            [[RealmManager sharedInstance] insertData:[[BookmarkModel alloc] init]];
        }
    }
    return 0;
}
