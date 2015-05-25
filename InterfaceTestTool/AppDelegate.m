//
//  AppDelegate.m
//  InterfaceTestTool
//
//  Created by ZhongDaYunKe on 15/4/27.
//  Copyright (c) 2015年 Yshch. All rights reserved.
//

#import "AppDelegate.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#include <math.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if (NO == [FileUtils isExistsAtPath:DBRealPath]) {
        [self initDB];
    }
    NSLog(@"DBRealPath = %@, autoscale=%f", DBRealPath, AUTOLAYOUT_SCALE);

    [self initAppDefaultUI:@"bg_navigationbar"];
    [[ITTManager sharedInstance] refreshInterfaceGroups];
    
    //设置程序启动入口界面
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];
    self.window.rootViewController = [self rootViewController];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)testAPI {
    [AFNManager requestByUrl:@"http://61.139.124.138:8089/api_punish/public_search_wfxx.php"
                     withAPI:nil
                andDictParam:@{@"hpzl" : @"02",
                               @"hpzm" : @"AZ09R0",
                               @"clsbm" : @"G92193"}
            customModelClass:ClassOfObject(TestListModel)
                 requestType:RequestTypeGET
            requestSuccessed:^(id responseObject) {
                TestListModel *listModel = (TestListModel *)responseObject;
                NSLog(@"response = %@", listModel.list);
            }
              requestFailure:^(NSInteger errorCode, NSString *errorMessage) {
                  NSLog(@"errorCode=%ld, errorMsg=%@", (long)errorCode, errorMessage);
              }];
}

/**
 *  初始化App默认样式
 */
- (void)initAppDefaultUI:(NSString *)navibarImageName {
    //修改状态栏字体颜色（前提是要设置[View controller-based status bar appearance]为NO）
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    //改变Navibar的颜色和背景图片
    //	[[UINavigationBar appearance] setBarTintColor:kDefaultNaviBarColor];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:navibarImageName]
                                       forBarMetrics:UIBarMetricsDefault];
    //控制返回箭头按钮的颜色
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    
    //设置Title为白色,Title大小为18
    [[UINavigationBar appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor blackColor],
                                                            NSFontAttributeName : [UIFont boldSystemFontOfSize:22] }];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackTranslucent];
}

#pragma mark - 业务逻辑相关代码

- (void)initDB {
    // 删除数据库文件
    [FileUtils deleteFileOrDirectory:DBRealPath];
    //接口分组管理
    NSString *tablesql_interface_group = @"CREATE TABLE IF NOT EXISTS interface_group (\
    groupId INTEGER PRIMARY KEY AUTOINCREMENT,\
    groupName Text DEFAULT NULL,\
    sequenceId Integer DEFAULT 0)";
    [CommonUtils SqliteUpdate:tablesql_interface_group];
    //接口定义
    NSString *tablesql_Interface = @"CREATE TABLE IF NOT EXISTS interface (\
    interfaceId INTEGER PRIMARY KEY AUTOINCREMENT,\
    groupId Integer DEFAULT 0,\
    interfaceName Text DEFAULT NULL,\
    interfacePrefixUrl Text DEFAULT NULL,\
    interfacePath Text DEFAULT NULL,\
    interfaceRemark Text DEFAULT NULL,\
    interfaceRequestType Integer DEFAULT 0,\
    interfaceStatus Integer DEFAULT 0,\
    sequenceId Integer DEFAULT 0,\
    totalCaseNumber Integer DEFAULT 0,\
    successCaseNumber Integer DEFAULT 0,\
    partialCaseNumber Integer DEFAULT 0,\
    errorCaseNumber Integer DEFAULT 0)";
    [CommonUtils SqliteUpdate:tablesql_Interface];
    //测试用例
    NSString *tablesql_TestCase = @"CREATE TABLE IF NOT EXISTS test_case (\
    caseId INTEGER PRIMARY KEY AUTOINCREMENT,\
    interfaceId Integer DEFAULT 0,\
    caseInput Text DEFAULT NULL,\
    caseOutput Text DEFAULT NULL,\
    caseOutputStd Text DEFAULT NULL,\
    caseOutputType Integer DEFAULT 0,\
    caseOutputModel Varchar(100) DEFAULT NULL,\
    sequenceId Integer DEFAULT 0,\
    caseStatus Integer DEFAULT 0,\
    spendTime Integer DEFAULT 0)";
    [CommonUtils SqliteUpdate:tablesql_TestCase];
}

/**
 *  初始化RootViewController
 *
 *  @return
 */
- (UIViewController *)rootViewController {
    return [[UINavigationController alloc] initWithRootViewController:[UIResponder createBaseViewController:@"ITTMainViewController"]];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
