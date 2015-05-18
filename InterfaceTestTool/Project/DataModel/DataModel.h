//
//  DataModel.h
//  YSCKit
//
//  Created by  YangShengchao on 14-4-29.
//  Copyright (c) 2014年 yangshengchao. All rights reserved.
//

#import "BaseModel.h"

#pragma mark - 数组映射关系

@protocol NewVersionModel           @end
@protocol SimpleUserModel           @end
@protocol UserModel                 @end
@protocol BannerModel               @end
@protocol ImageModel                @end
@protocol TestModel                 @end
@protocol TestListModel             @end
@protocol CommonItemModel           @end


#pragma mark - 公共model需要用到的class声明

/**
 *  要使用的model在本类里
 */
@class SimpleUserModel, ImageModel, TestModel;




#pragma mark - 公共model定义

//新版本描述模型
@interface NewVersionModel : BaseDataModel

@property (nonatomic, strong) NSString *versionCode;        //1.4.17
@property (nonatomic, strong) NSString *versionDescription; //新版本描述
@property (nonatomic, assign) BOOL isForced;                //是否强制升级
@property (nonatomic, strong) NSString *downloadUrl;        //plist文件的url地址 or appstore's url

@end

//-------------------------------------------------------------------------------------------
//
//  用户相关
//
//-------------------------------------------------------------------------------------------

//简单用户模型
@interface SimpleUserModel : BaseDataModel

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *avatarUrl;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, assign) GenderType gender;

@end

//基本用户信息
@interface UserModel : BaseDataModel

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *avatarUrl;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, assign) GenderType gender;

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *postCode;
@property (nonatomic, strong) NSString *occupation;         //职业
@property (nonatomic, strong) NSString *position;
@property (nonatomic, strong) NSString *jobNumber;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *mobileNumber;

@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, assign) OpenType openType;
@property (nonatomic, assign) UserType userType;
@property (nonatomic, strong) NSString *userLevel;          //用户等级
@property (nonatomic, assign) NSInteger currentIntegral;    //当前积分
@property (nonatomic, strong) NSString *token;

@end


//-------------------------------------------------------------------------------------------
//
//  首页相关
//
//-------------------------------------------------------------------------------------------
//Banner模型
@interface BannerModel : BaseDataModel

@property (nonatomic, assign) BannerType bannerType;
@property (nonatomic, strong) NSString *bannerImage;
@property (nonatomic, strong) NSString *uniqueId;               //根据type确定该唯一编号是什么类型（资讯、帖子、活动等）

@end


//图片通用模型
@interface ImageModel : BaseDataModel

@property (nonatomic, strong) NSString *imageUrl;

@end


@interface TestModel : BaseDataModel
@property (nonatomic, strong) NSString *xh;
@property (nonatomic, strong) NSString *wfsj;
@property (nonatomic, strong) NSString *wfdz;
@property (nonatomic, strong) NSString *wfxw;
@property (nonatomic, strong) NSString *fkje;
@property (nonatomic, strong) NSString *jf;
@end
@interface TestListModel : BaseDataModel
@property (nonatomic, strong) NSArray<TestModel> *list;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *msg;
@end



#pragma mark - 公共小功能
@interface CommonItemModel : BaseDataModel

@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *viewController;
+ (CommonItemModel *)buildNewItem:(NSString *)icon title:(NSString *)title viewController:(NSString *)viewController;

@end


