//
//  AppDelegate.m
//  InterfaceTestTool
//
//  Created by ZhongDaYunKe on 15/4/27.
//  Copyright (c) 2015年 Yshch. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self testAPI];
    NSLog(@"oid=%@", [AppConfigManager sharedInstance].udid);
#pragma mark --初始化数据库
    if (![FileUtils isExistsAtPath:DBRealPath]) {
        [self initDB];
    }
    NSLog(@"DBRealPath = %@", DBRealPath);

    [self initAppDefaultUI:@"bg_navigationbar"];
    
    //设置程序启动入口界面
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];
    self.window.rootViewController = [self rootViewController];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)testAPI {
    [AFNManager requestByUrl:@"http://61.139.124.138:8089//api_punish/public_search_wfxx.php"
                andDictParam:@{@"hpzl" : @"02",
                               @"hpzm" : @"AZ09R0",
                               @"clsbm" : @"G92193"}
                 requestType:RequestTypeGET
            requestSuccessed:^(id responseObject) {
                NSLog(@"response = %@", responseObject);
            }
              requestFailure:^(NSInteger errorCode, NSString *errorMessage) {
                  NSLog(@"errorCode=%ld, errorMsg=%@", errorCode, errorMessage);
              }];
}

/**
 *  初始化App默认样式
 */
- (void)initAppDefaultUI:(NSString *)navibarImageName {
    //将状态栏字体改为白色（前提是要设置[View controller-based status bar appearance]为NO）
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
    
    NSString *tablesql_SearchKeyword = @"CREATE TABLE IF NOT EXISTS SearchKeyword (\
    keyword Varchar(100)  PRIMARY KEY DEFAULT NULL,\
    startTime Varchar(100) DEFAULT NULL)";
    [CommonUtils SqliteUpdate:tablesql_SearchKeyword];
    
    NSString *tablesql_ProductModel = @"CREATE TABLE IF NOT EXISTS ProductModel (\
    productId Varchar(100) PRIMARY KEY DEFAULT NULL,\
    productModel Text DEFAULT NULL,\
    userId Varchar(100) DEFAULT NULL,\
    startTime Varchar(100) DEFAULT NULL)";
    [CommonUtils SqliteUpdate:tablesql_ProductModel];
}

/**
 *  初始化RootViewController
 *
 *  @return
 */
- (UIViewController *)rootViewController {
    return [UIResponder createBaseViewController:@"ITTMainViewController"];
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
