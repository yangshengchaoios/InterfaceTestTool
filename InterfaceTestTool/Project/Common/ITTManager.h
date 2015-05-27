//
//  ITTManager.h
//  InterfaceTestTool
//
//  Created by yangshengchao on 15/5/25.
//  Copyright (c) 2015年 Builder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ITTManager : NSObject

@property (nonatomic, strong) NSMutableArray *interfaceGroupArray;

+ (instancetype)sharedInstance;
- (void)refreshInterfaceGroups;
- (void)refreshInterfaces;

@end
