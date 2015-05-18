//
//  Login.h
//  YSCKit
//
//  Created by  YangShengchao on 14-2-25.
//  Copyright (c) 2014年  YangShengchao. All rights reserved.
//

typedef void(^LoginSuccessed)(void);
typedef void(^LoginFailedWithError)(NSString *errorMessage);

@protocol LoginObserverDelegate;

@interface Login : NSObject

@property (nonatomic, strong) UserModel *user;                      //当前登录用户对象
@property (nonatomic, strong) NSString *token;                      //用户登录有效期控制
@property (nonatomic, assign) BOOL isUserChanged;                   //当前用户对象是否更新过（用于监控user对象的变化）
@property (nonatomic, strong) NSMutableArray *loginObservers;
@property (nonatomic, assign) NSInteger shoppingCartProductCount;   //购物车商品数量

+ (Login *)sharedInstance;
- (void)refreshUserInfo;

#pragma mark - 用户登录/重新登录/退出登录

- (BOOL)isLogged;                   //判断是否登录了
- (void)clearLoginData;
- (void)resetUser:(UserModel *)userModel;

// email+手机号登录
- (void)loginWithAccountName:(NSString *)userId
                 andPassword:(NSString *)password
                 andObserver:(id<LoginObserverDelegate>)observer;
- (void)loginWithSNSType:(ShareType)type andObserver:(id<LoginObserverDelegate>)observer;
- (void)logout;

#pragma mark - Login Observer CallBack

- (void)registerLoginObserver:(id<LoginObserverDelegate>)observer;
- (void)unregisterLoginObserver:(id)observer;

@end

@protocol LoginObserverDelegate <NSObject>

@required
- (void)loginSucceededWithUserId:(NSString *)theUserId session:(NSString *)theSession;
- (void)loginFailedWithError:(NSString *)errorMessage;
- (void)loggedOut;

@optional
- (void)doLogining;         //第三方登录成功后，正在登录本地系统
- (void)loginCancelled;
- (void)loggedOutWithUserId:(NSString *)theUserId;

@end