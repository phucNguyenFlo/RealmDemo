//
//  DemoBackgroundView.m
//  RealmDemo
//
//  Created by Phuc Nguyen on 10/5/18.
//  Copyright © 2018 Phuc Nguyen. All rights reserved.
//

#import "DemoBackgroundView.h"

@implementation DemoBackgroundView

- (void)drawRect:(NSRect)dirtyRect {
    [[NSColor colorWithWhite:0.1 alpha:0.05] setFill];
    NSRectFill(dirtyRect);
    [super drawRect:dirtyRect];
}

@end
