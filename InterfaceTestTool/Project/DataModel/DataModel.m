//
//  DataModel.m
//  YSCKit
//
//  Created by  YangShengchao on 14-4-29.
//  Copyright (c) 2014年 yangshengchao. All rights reserved.
//

#import "DataModel.h"
#import <FMDB/FMDB.h>

@implementation NewVersionModel             @end
@implementation SimpleUserModel             @end
@implementation UserModel                   @end
@implementation BannerModel                 @end
@implementation ImageModel                  @end
@implementation TestModel                   @end
@implementation TestListModel               @end
@implementation CommonItemModel
+ (CommonItemModel *)buildNewItem:(NSString *)icon title:(NSString *)title viewController:(NSString *)viewController {
    CommonItemModel *item = [CommonItemModel new];
    item.icon = icon;
    item.title = title;
    item.viewController = viewController;
    return item;
}
@end
