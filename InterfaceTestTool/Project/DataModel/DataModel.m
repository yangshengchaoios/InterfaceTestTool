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
//用户
@implementation SimpleUserModel             @end
@implementation UserModel                   @end
@implementation ContactModel
- (id)initWithAvatar:(NSString *)avatar name:(NSString *)name position:(NSString *)position {
    self = [super init];
    if (self) {
        self.avatarUrl = avatar;
        self.realName = name;
        self.position = position;
    }
    return self;
}
@end
@implementation BusinessCardModel           @end
@implementation BannerModel                 @end
//商品
@implementation ProductCategoryModel        @end
@implementation SimpleProductModel          @end
@implementation ProductModel
+ (NSDictionary *)jsonToModelMapping {
    return @{@"lastEvaluateInfo" : @"lastEvaluate",
             @"store" : @"simpleShop"};
}
- (ProductSkuModel *)buildProductSkuModel {
    if ([self.productSkus count] == 0) {
        return nil;
    }
    
    ProductSkuModel *productSkuModel = [ProductSkuModel new];
    productSkuModel.productSkus = [NSMutableArray array];
    //按skuId升序排列
    NSArray *tempArray = [self.productSkus sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        ProductSku1Model *sku1 = (ProductSku1Model *)obj1;
        ProductSku1Model *sku2 = (ProductSku1Model *)obj2;
        if (sku1.skuId.integerValue < sku2.skuId.integerValue) {
            return NSOrderedAscending;
        }
        return NSOrderedDescending;
    }];
    //规格的二维数组
    NSString *lastSkuId = @"";
    for (ProductSku1Model *productSku1 in tempArray) {
        ValueModel *valueModel = [ValueModel new];
        valueModel.valueId = productSku1.valueId;
        valueModel.valueName = productSku1.valueName;
        if ( ! [lastSkuId isEqualToString:productSku1.skuId]) {
            lastSkuId = productSku1.skuId;
            SkuModel *skuModel = [SkuModel new];
            skuModel.skuId = productSku1.skuId;
            skuModel.skuName = productSku1.skuName;
            NSMutableArray *tempSkuValues = [NSMutableArray array];
            [tempSkuValues addObject:valueModel];
            skuModel.skuValues = tempSkuValues;
            
            NSMutableArray *tempSkus = (NSMutableArray *)productSkuModel.productSkus;
            [tempSkus addObject:skuModel];
        }
        else {
            SkuModel *skuModel = (SkuModel *)[productSkuModel.productSkus lastObject];
            NSMutableArray *tempSkuValues = (NSMutableArray *)skuModel.skuValues;
            [tempSkuValues addObject:valueModel];
        }
    }
    //规格值的关系
    productSkuModel.productSkuRelations = self.productSkuRelations;
    
    //每种规格的规格值都按valueId升序排列
    for (SkuModel *skuModel in productSkuModel.productSkus) {
        NSArray *tempArray = [skuModel.skuValues sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            ValueModel *value1 = (ValueModel *)obj1;
            ValueModel *value2 = (ValueModel *)obj2;
            if (value1.valueId.integerValue < value2.valueId.integerValue) {
                return NSOrderedAscending;
            }
            return NSOrderedDescending;
        }];
        skuModel.skuValues = tempArray;
    }
    
    return productSkuModel;
}
@end
@implementation SimpleShopModel             @end
@implementation ProductSku1Model
+ (NSDictionary *)jsonToModelMapping {
    return @{@"value" : @"valueName",
             @"imgeUrl" : @"imageUrl",
             @"productSpecName" : @"skuName",
             @"specNameId" : @"skuId"};
}
@end
@implementation LastEvaluateModel
+ (NSDictionary *)jsonToModelMapping {
    return @{@"evaluateUserName" : @"nickName",
             @"userPhotoUrl" : @"avatarUrl"};
}
@end
@implementation ProductSkuModel
- (void)selectSkuId:(NSString *)skuId andValueId:(NSString *)valueId {
    //0. 加入已经选择的规格字典
    if ([NSString isNotEmpty:skuId] && [NSString isNotEmpty:valueId]) {
        if (nil == self.selectedSkusDictionary) {
            self.selectedSkusDictionary = [NSMutableDictionary dictionary];
        }
        if ([self.selectedSkusDictionary[skuId] isEqualToString:valueId]) {
            [self.selectedSkusDictionary removeObjectForKey:skuId];//移除已经选中的规格
        }
        else {
            self.selectedSkusDictionary[skuId] = valueId;
        }
    }
    
    //1. 查找选中规格的关系对象
    self.selectedSkuRelation = nil;
    for (ProductSkuRelationModel *skuRelation in self.productSkuRelations) {
        NSArray *tempValueIdArray = [NSString splitString:skuRelation.productSkuId byRegex:@"_"];
        if ([tempValueIdArray count] != [self.selectedSkusDictionary.allValues count]) {
            break;
        }
        if ([NSArray isEquals:self.selectedSkusDictionary.allValues withArray:tempValueIdArray]) {
            self.selectedSkuRelation = skuRelation;
        }
        //TODO:显示价格范围
    }
    
    //2. 所有与已经选择了的valueId有关联的规格值数组
    NSMutableArray *allRelatedValueIds = [NSMutableArray array];
    for (SkuModel *skuModel in self.productSkus) {
        for (ValueModel *valueModel in skuModel.skuValues) {
            if ( ! [allRelatedValueIds containsObject:valueModel.valueId]) {
                [allRelatedValueIds addObject:valueModel.valueId];
            }
        }
    }
    for (NSString *selectedSkuId in self.selectedSkusDictionary.allKeys) {
        NSString *selectedValueId = self.selectedSkusDictionary[selectedSkuId];
        //查找当前选择规格值相关的所有规格值
        NSMutableArray *tempArray = [NSMutableArray array];
        for (ProductSkuRelationModel *skuRelation in self.productSkuRelations) {
            NSArray *tempArray1 = [NSString splitString:skuRelation.productSkuId byRegex:@"_"];
            if ([tempArray1 containsObject:selectedValueId]) {
                [tempArray addObjectsFromArray:tempArray1];//有重复的selectedValueId
            }
        }
        
        //将已经选中规格的名称下所有的规格值都加入后取交集
        for (SkuModel *skuModel in self.productSkus) {
            for (ValueModel *valueModel in skuModel.skuValues) {
                if ([skuModel.skuId isEqual:selectedSkuId] && (! [tempArray containsObject:valueModel.valueId])) {
                    [tempArray addObject:valueModel.valueId];
                }
            }
        }
        
        //查找数组的交集
        NSArray *tempArray2 = [NSArray commonArrayBetween:allRelatedValueIds withArray:tempArray];//去掉所有重复的值
        [allRelatedValueIds removeAllObjects];
        [allRelatedValueIds addObjectsFromArray:tempArray2];
    }
    
    //3. 更新规格显示的UI
    self.selectedSkuValue = @"";
    for (SkuModel *skuModel in self.productSkus) {
        for (ValueModel *valueModel in skuModel.skuValues) {
            valueModel.valueLabel.userInteractionEnabled = YES;
            valueModel.isSelected = [self.selectedSkusDictionary.allValues containsObject:valueModel.valueId];
            if (valueModel.isSelected) {
                self.selectedSkuValue = [NSString stringWithFormat:@"%@ %@", self.selectedSkuValue, valueModel.valueName];
            }
            else {
                valueModel.isEnable = [allRelatedValueIds containsObject:valueModel.valueId];
            }
        }
    }
}
@end
@implementation ValueModel
- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    if (isSelected) {
        self.valueLabel.backgroundColor = RGB(150, 150, 150);
        self.valueLabel.textColor = [UIColor whiteColor];
    }
    else {
        self.valueLabel.backgroundColor = [UIColor clearColor];
        self.valueLabel.textColor = RGB(111, 111, 111);
    }
}
- (void)setIsEnable:(BOOL)isEnable {
    _isEnable = isEnable;
    self.valueLabel.userInteractionEnabled = isEnable;
    self.valueLabel.textColor = RGB(111, 111, 111);
    if (isEnable) {
        self.valueLabel.backgroundColor = [UIColor clearColor];
    }
    else {
        self.valueLabel.backgroundColor = RGB(200, 200, 200);
    }
}
@end
@implementation SkuModel                    @end
@implementation AttributeModel              @end
@implementation ProductSkuRelationModel
+ (NSDictionary *)jsonToModelMapping {
    return @{@"id" : @"productSkuId",
             @"price" : @"salePrice",
             @"count" : @"stockNumber"};
}
@end
@implementation ProductCommentModel         @end
@implementation ShoppingCartReturnModel     @end
//订单
@implementation AccountModel                @end
@implementation SimpleProductOrderModel     @end
@implementation ProductOrderModel           @end
@implementation OrderProductModel
- (CGFloat)amount {
    CGFloat temp = 0;
    if (self.isSelected) {
        temp += self.number * self.realPrice.floatValue;
    }
    return temp;
}
@end
@implementation InvoiceModel                @end
@implementation OrderExpressFareModel       @end
@implementation UserIntegralModel
+ (NSDictionary *)jsonToModelMapping {
    return @{@"priceDeduction" : @"integralMoney"};
}
@end
@implementation SubmitProductOrderModel     @end
@implementation SubmitProductOrderReturnModel
+ (NSDictionary *)jsonToModelMapping {
    return @{@"orderTotalPrice" : @"paymentMoney"};
}
@end
@implementation ShoppingCartModel
+ (NSDictionary *)jsonToModelMapping {
    return @{@"orderProduct" : @"shoppingCartProducts"};
}
- (NSString *)orderDescription {
    NSMutableString *orderBody = [NSMutableString stringWithString:@"购买商品："];
    [orderBody appendFormat:@"[店铺-%@]", self.shopName];
    if ([self.shoppingCartProducts count] > 0) {
        OrderProductModel *orderProductModel = self.shoppingCartProducts[0];
        [orderBody appendFormat:@"[商品-%@等]", orderProductModel.simpleProduct.productName];
    }
    return orderBody;
}
- (void)updateProductsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    for (OrderProductModel *orderProduct in self.shoppingCartProducts) {
        orderProduct.isSelected = isSelected;
    }
}
- (void)checkIfAllSelected {
    BOOL isSelectedAllProducts = YES;
    for (OrderProductModel *tempProduct in self.shoppingCartProducts) {
        if (isSelectedAllProducts && NO == tempProduct.isSelected) {
            isSelectedAllProducts = NO;
            break;
        }
    }
    _isSelected = isSelectedAllProducts;
}
@end
@implementation OtherPhoneModel
+ (NSDictionary *)jsonToModelMapping {
    return @{@"phoneno" : @"mobileNumber",
             @"totalPrice" : @"amount",
             @"lastPrice" : @"payMoney",
             @"status" : @"orderStatus"};
}
@end
@implementation RechargeInfoModel  @end
//经销商
@implementation BusinessProductModel        @end
@implementation BusinessCartProductModel    @end
@implementation SubmitBusinessOrderModel    @end
@implementation SimpleBusinessOrderModel    @end
@implementation BusinessOrderModel          @end
//个人中心
@implementation AddressModel
+ (NSString *)addressString:(NSString *)provinceId city:(NSString *)cityId section:(NSString *)sectionId {
    AddressModel *addressModel = [AddressModel new];
    addressModel.provinceId = provinceId;
    addressModel.cityId = cityId;
    addressModel.sectionId = sectionId;
    return addressModel.addressString;
}
- (NSString *)addressString {
    if ([NSString isNotEmpty:_addressString]) {
        return _addressString;
    }
    FMDatabase *db = [FMDatabase databaseWithPath:RegionDbPath];
    if ([db open]) {
        NSMutableString *sql = [NSMutableString stringWithFormat:@"SELECT p.province, c.city, s.section FROM province p, city c, section s "];
        [sql appendFormat:@"WHERE p.pid=c.pid AND c.cid=s.cid AND p.pid=%@ AND c.cid=%@ AND s.sid=%@", self.provinceId, self.cityId, self.sectionId];
        FMResultSet *resultSet = [db executeQuery:sql];
        if ([resultSet next]) {
            _addressString = [NSString stringWithFormat:@"%@ %@ %@",
                              Trim([resultSet stringForColumn:@"province"]),
                              Trim([resultSet stringForColumn:@"city"]),
                              Trim([resultSet stringForColumn:@"section"])];
        }
        return _addressString;
    }
    [db close];
    
    return nil;
}
@end
@implementation CouponModel                 @end
@implementation LogisticsTrackModel         @end
@implementation CollectionProductModel
+ (NSDictionary *)jsonToModelMapping {
    return @{@"id" : @"collectionId"};
}
@end
@implementation BrowseHistoryModel          @end
@implementation ImageModel                  @end
@implementation GameModel
+ (NSDictionary *)jsonToModelMapping {
    return @{@"gameInfoId" : @"gameId",
             @"name" : @"gameName",
             @"iconImagePath" : @"gameIcon",
             @"versionNum" : @"gameVersion",
             @"voicePath" : @"gameVoiceDownloadUrl",
             @"description" : @"gameDescription"};
}
@end
@implementation PaymentModel                @end
@implementation CommonItemModel
+ (CommonItemModel *)buildNewItem:(NSString *)icon title:(NSString *)title viewController:(NSString *)viewController {
    CommonItemModel *item = [CommonItemModel new];
    item.icon = icon;
    item.title = title;
    item.viewController = viewController;
    return item;
}
@end
