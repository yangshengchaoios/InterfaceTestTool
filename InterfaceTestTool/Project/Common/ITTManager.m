//
//  ITTManager.m
//  InterfaceTestTool
//
//  Created by yangshengchao on 15/5/25.
//  Copyright (c) 2015年 Builder. All rights reserved.
//

#import "ITTManager.h"

@implementation ITTManager

+ (instancetype)sharedInstance {
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^ {
        return [[self alloc] init];
    })
}

- (void)refreshInterfaceGroups {
    if (nil == self.interfaceGroupArray) {
        self.interfaceGroupArray = [NSMutableArray array];
    }
    else {
        [self.interfaceGroupArray removeAllObjects];
    }
    [self.interfaceGroupArray addObjectsFromArray:[InterfaceGroupModel FetchGroups]];
}

- (void)refreshInterfaces {
    for (InterfaceGroupModel *group in self.interfaceGroupArray) {
        [group initInterfaceArray];
    }
}

@end
