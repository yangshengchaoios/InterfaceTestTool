//
//  UrlConstants.h
//  YSCKit
//
//  Created by  YangShengchao on 14-2-13.
//  Copyright (c) 2014年  YangShengchao. All rights reserved.
//  FORMATED!
//

#ifndef YSCKit_UrlConstants_h
#define YSCKit_UrlConstants_h

/**
 *  定义各种正式和测试的接口地址
 */
#pragma mark - Config Values
//UMeng参数值优先级 > 本地参数值
#define kResPathAppBaseUrl        [[AppConfigManager sharedInstance] valueOfAppConfig:@"kResPathAppBaseUrl"]
#define kResPathAppResUrl         [[AppConfigManager sharedInstance] valueOfAppConfig:@"kResPathAppResUrl"]
#define kCheckNewVersionUrl       [[AppConfigManager sharedInstance] valueOfAppConfig:@"kCheckNewVersionUrl"] //版本更新地址(独立于接口直接访问的url)
#define kCheckNewVersionType      [[AppConfigManager sharedInstance] valueOfAppConfig:@"kCheckNewVersionType"]//0-不更新 1-通过接口更新 2-通过UMeng在线配置更新
#define kAlipayNotifyUrl          [[AppConfigManager sharedInstance] valueOfAppConfig:@"kAlipayNotifyUrl"]
#define kLogManageType            [[AppConfigManager sharedInstance] valueOfAppConfig:@"kLogManageType"]      //0-不记录日志 1-要记录日志
#define kCheckOnlineByHour        [[AppConfigManager sharedInstance] valueOfAppConfig:@"kCheckOnlineByHour"]
#define kHaoYunTaoWapUrl          [[AppConfigManager sharedInstance] valueOfAppConfig:@"kHaoYunTaoWapUrl"]    //好云淘的wap网址
//UMeng在线参数值
#define kNewVersionModel          [[AppConfigManager sharedInstance] valueOfUMengConfig:@"kNewVersionModel"]  //UMeng在线配置的软件升级参数
#define kPaymentModelList         [[AppConfigManager sharedInstance] valueOfUMengConfig:@"kPaymentModelList"] //UMeng在线配置的支付方式列表
//本地配置文件参数值
#define kAppChannel               [[AppConfigManager sharedInstance] valueOfLocalConfig:@"kAppChannel"]       //当前发布的渠道
#define kAppId                    [[AppConfigManager sharedInstance] valueOfLocalConfig:@"kAppId"]            //当前app的唯一编号
#define kUMAppKey                 [[AppConfigManager sharedInstance] valueOfLocalConfig:@"kUMAppKey"]         //UMeng key(正式环境和测试环境都是同一个key)
#define kBaiduMapKey              [[AppConfigManager sharedInstance] valueOfLocalConfig:@"kBaiduMapKey"]      //百度地图的key

/**
 *  接口地址
 */
#pragma mark - 接口访问地址

//登录注册相关接口
#define kResPathAppQuickRegister                @"UserRegister.htm"
#define kResPathAppLogin                        @"UserLogin.htm"
#define kResPathAppOpenUserLogin                @"OpenUserLogin.htm" /*开放平台用户登录*/
#define kResPathAppChangePassword               @"ChangePassword.htm" //修改密码
#define kResPathAppResetPassword                @"ResetPassword.htm" //找回密码
#define kResPathAppSendCaptcha                  @"SendCaptcha.htm" //发送（手机短信/邮箱）验证码
#define kResPathAppUpdateNewVersion             @"GetAppVersion.htm" // 更新版本
#define kResPathAppUploadAvatar                 @"UploadAvatar.htm" // 上传头像图片
#define kResPathAppUploadNormalImage            @"UploadNormalImage.htm" //上传图片的通用方法
#define kResPathAppExternalLogin                @"OpenUserLogin.htm"

//首页
#define kResPathAppIndexBanner                  @"IndexBanner.htm" //首页banner
#define kResPathAppGetServerTime                @"getSystemCurrentTime.htm"
#define kRespathAppIndexProducts                @"IndexProducts.htm"
#define kResPathAppOnlineGames                  @"OnlineGames.htm"
#define kResPathAppTopSearchKey                 @"TopSearchKey.htm"

//商品
#define kResPathAppSearchProduct                @"SearchProduct.htm"
#define kResPathAppSearchByBarcode              @"SearchByBarcode.htm"
#define kResPathAppProductSecurity              @"ProductSecurity.htm"
#define kResPathAppProductCategory              @"ProductCategory.htm"
#define kResPathAppCategoryProducts             @"CategoryProducts.htm"
#define kResPathAppProductDetail                @"ProductDetail.htm"
#define kResPathAppProductCommentList           @"ProductCommentList.htm"
#define kResPathAppAddToShoppingCart            @"AddToShoppingCart.htm"
#define kResPathAppAddProductToCollection       @"AddToCollection.htm"
#define kResPathAppSubmitOrder                  @"SubmitOrder.htm"
#define kResPathAppOrderTransFee                @"OrderTransFee.htm"
#define kResPathAppDeductionIntegral            @"DeductionIntegral.htm"
#define kResPathAppAddShopToCollection          @"AddShopToCollection.htm"

//购物车
#define kResPathAppShoppingCartOfProducts       @"ShoppingCartOfProducts.htm"
#define kResPathAppDeleteProductFromShoppingCart @"DeleteProductFromShoppingCart.htm"
#define kResPathAppUpdateNumberInShoppingCart   @"UpdateNumberInShoppingCart.htm"
#define kResPathAppUpdateSkuInShoppingCart      @"UpdateSkuInShoppingCart.htm"
#define kResPathAppProductSkus                  @"ProductSkus.htm"

//员工专区


//经销商专区



//个人中心
#define kResPathAppUserInfo                     @"UserInfo.htm"
#define kResPathAppUpdateUserInfo               @"UpdateUserInfo.htm"
#define kResPathAppMyAccountList                @"MyAccountList.htm"
#define kResPathAppRemindDelivery               @"RemindDelivery.htm"
#define kResPathAppDeleteOrder                  @"DeleteOrder.htm"
#define kResPathAppCancelOrder                  @"CancelOrder.htm"
#define kResPathAppLogisticsTrack               @"LogisticsTrack.htm"
#define kResPathAppConfirmReceipt               @"ConfirmReceipt.htm"
#define kResPathAppSubmitProductComment         @"SubmitProductComment.htm"
#define kResPathAppCheckOrderDetail             @"CheckOrderDetail.htm"
#define kResPathAppMyVirtualOrders              @"MyVirtualOrders.htm"
#define kResPathAppGetMyProductCollections      @"GetMyProductCollections.htm"
#define kResPathAppGetMyShopCollections         @"GetMyShopCollections.htm"
#define kResPathAppDeleteFromMyCollection       @"DeleteFromMyCollection.htm"
#define kResPathAppMyBrowseHistory              @"MyBrowseHistory.htm"
#define kResPathAppDeleteMyBrowseHistory        @"DeleteMyBrowseHistory.htm"
#define kResPathAppMyCoupons                    @"MyCoupons.htm"
#define kResPathAppUseCoupon                    @"UseCoupon.htm"
#define kResPathAppConsumeDetail                @"ConsumeDetail.htm"
#define kResPathAppMyAddresses                  @"MyAddresses.htm"
#define kResPathAppMyOneAddress                 @"MyOneAddress.htm"
#define kResPathAppUpdateMyAddress              @"UpdateMyAddress.htm"
#define kResPathAppAddNewAddress                @"AddNewAddress.htm"
#define kResPathAppDeleteAddress                @"DeleteAddress.htm"
#define kResPathAppSetDefaultAddress            @"SetDefaultAddress.htm"
#define kResPathAppMyDefaultAddress             @"MyDefaultAddress.htm"
#define kResPathAppProductForBarCode            @"ProductForBarCode.htm"


/**
 *  定义网络POST提交、GET提交、页面间传递的参数
 */
#pragma mark - Param Name of POST & GET

#define kParamSecretKey                     @"ajsiwe2^%436486&%$#?><D.S,JKDFH><{})09"  //定义参数‘signature’加密的秘钥
#define kParamVersionValue                  @"1.0"            //设置默认接口版本号
#define kParamFromValue                     @"ios"            //设置接口访问来源:ios、android、wap

#define kParamTitle                         @"title"
#define kParamUrl                           @"url"
#define kParamEmail                         @"email"
#define kParamTelPhone                      @"telPhone"
#define kParamCellPhone                     @"cellPhone"
#define kParamMobilePhone                   @"mobilePhone"
#define kParamTrue                          @"true"
#define kParamFalse                         @"false"
#define kParamOpenId                        @"openId"
#define kParamOpenType                      @"openType"
#define kParamUserName                      @"userName"
#define kParamAvatarUrl                     @"avatarUrl"
#define KParamImageData                     @"imageData"
#define kParamCommentImages                 @"commentImages"
#define kParamToken                         @"token"
#define kParamSegmentSelectedIndex          @"segmentSelectedIndex"
#define kParamExpressNO                     @"expressNO"
#define kParamRate                          @"rate"
#define kParamReturnType                    @"returnType"
#define kParamComment                       @"comment"
#define kParamGender                        @"gender"                       //性别
#define kParamAddress                       @"address"                      //用户地址
#define kParamOccupation                    @"occupation"
#define kParamAddressId                     @"addressId"                    //地址Id
#define kParamUserFrom                      @"userFrom"                     //第三方用户来源
#define kParamPassword                      @"password"                     //密码
#define kParamCaptcha                       @"captcha"                      //验证码
#define kParamValue                         @"value"
#define kParamName                          @"name"
#define kParamUserId                        @"userId"                       //平台内部用户唯一编号
#define kParamNickName                      @"nickName"                     //昵称
#define kParamRealName                      @"realName"                     //真实姓名
#define kParamBirthday                      @"birthday"                     //生日的时间戳
#define kParamProvince                      @"province"                     //省份编号
#define kParamCity                          @"city"                         //城市编号
#define kParamCounty                        @"county"                       //县城编号
#define kParamQQ                            @"QQ"
#define kParamMSN                           @"MSN"
#define kParamNewPassword                   @"newPassword"                  //新密码
#define kParamOldPassword                   @"oldPassword"                  //旧密码
#define kParamOrderStatus                   @"orderStatus"                  //订单状态
#define kParamPageSize                      @"pageSize"
#define kParamKeywords                      @"keywords"
#define kParamPageIndex                     @"pageIndex"
#define kParamIndex                         @"index"
#define kParamLastId                        @"lastId"
#define kParamCollectionId                  @"collectionId"                 //我的收藏id
#define kParamCollectionIds                 @"ids"
#define kParamValueId                       @"valueId"
#define kParamProductId                     @"productId"
#define kParamGroupLimitNum                 @"groupLimitNum"
#define kParamProductSkuId                  @"productSkuId"
#define kParamBuyType                       @"buyType"
#define kParamProductNumber                 @"productNum"
#define kParamContent                       @"content"
#define kParamOrderId                       @"orderId"
#define kParamOptions                       @"options"
#define kParamOrderModel                    @"orderModel"
#define kParamProductModel                  @"productModel"
#define kParamOrderType                     @"orderType"
#define kParamProductName                   @"productName"
#define kParamBackType                      @"backType"
#define kParamFilterType                    @"filterType"
#define kParamSignature                     @"signature"
#define kParamVersion                       @"version"
#define kParamUdid                          @"udid"
#define kParamFrom                          @"from"
#define kParamAppId                         @"appId"
#define kParamSendType                      @"sendType"
#define kParamBrandId                       @"brandId"
#define kParamTopicId                       @"topicId"
#define kParamReplyId                       @"barId"
#define kParamCollectionType                @"collectionType"
#define kParamType                          @"type"
#define kParamModel                         @"model"
#define kParamQqOpenId                      @"qqOpenId"
#define kParamSinaOpenId                    @"sinaOpenId"
#define kParamUserTags                      @"userTags"
#define kParamHaveImg                       @"haveImg"
#define kParamMessageId                     @"messageId"
#define kParamMsgType                       @"msgType"
#define kParamFromUserId                    @"fromUserId"
#define kParamMessageModel                  @"messageModel"
#define kParamSimpleProductTopicModel       @"simpleProductTopicModel"
#define kParamSimpleTopicModel              @"simpleTopicModel"
#define kParamBarModel                      @"barModel"
#define kParamGoodsCartIds                  @"goodsCartIds"
#define kParamLocation                      @"location"
#define kParamReplyContent                  @"replyContent"
#define kParamReplyImages                   @"replyImages"
#define kParamSubisinvoice                  @"subisinvoice"
#define kParamSubinvoice                    @"subinvoice"
#define kParamCoupon                        @"coupon"
#define kParamCouponCode                    @"couponCode"
#define kParamIntegral                      @"integral"
#define kParamPaymentId                     @"paymentId"
#define kParamShopId                        @"shopId"
#define kParamShoppingCartProductId         @"shoppingCartProductId"
#define kParamShoppingCartArray             @"shoppingCartArray"
#define kParamNumber                        @"number"
#define kParamShopName                      @"shopName"
#define kParamSearchKey                     @"searchKey"
#define kParamSortType                      @"sortType"
#define kParamIsAsc                         @"isAsc"
#define kParamIsGroupBuy                    @"isGroupBuy"
#define kParamSimpleShopModel               @"simpleShopModel"
#define kParamSimpleProductModel            @"simpleProductModel"
#define kParamSpecialSaleId                 @"specialSaleId"
#define kParamSimpleSpecialSaleModel        @"simpleSpecialSaleModel"
#define kParamGroupId                       @"groupId"
#define kParamGroupName                     @"groupName"
#define kParamGroupBuyEndTime               @"groupBuyEndTime"
#define kParamSelectedSkuId                 @"selectedSkuId"
#define kParamUsed                          @"used"
#define kParamCategoryId                    @"categoryId"
#define kParamProductOrderList              @"productOrderList"
#define kParamOtherOrderList                @"otherOrderList"
#define kParamInvoiceType                   @"invoiceType"
#define kParamInvoiceObject                 @"invoiceObject"
#define kParamInvoiceTitle                  @"invoiceTitle"
#define kParamInvoiceContent                @"invoiceContent"
#define kParamSelectAddressBlock            @"selectAddressBlock"
#define kParamSelectInvoiceBlock            @"selectInvoiceBlock"
#define kParamSelectCouponBlock             @"selectCouponBlock"
#define kParamBackRefreshBlock              @"backRefreshBlock"
#define kParamSelectedAddressModel          @"selectedAddressModel"
#define kParamSelectedInvoiceModel          @"selectedInvoiceModel"
#define kParamSelectedCouponModel           @"selectedCouponModel"
#define kParamHotSaleProductRecommend       @"HotSaleProductRecommend"
#define kParamProductsOfShop                @"ProductsOfShop"
#define kParamMethod                        @"method"
#define kParamParams                        @"params"
#define kParamGameModel                     @"gameModel"
#define kParamBarCode                       @"barcode"
#define kParamTableViewCell                 @"tableViewCell"
#define kParamAdd                           @"add"
#define kParamEdit                          @"edit"
#define kParamEnableDownloadImage           @"EnableDownloadImage"
#define kParamUMengOnlineParams             @"online_params"
#define kParamUMengLastConfigTime           @"last_config_time"
#define kParamUMengLastCheckDate            @"UMengLastCheckDate"
#define kParamFeatureType                   @"featureType"
#define kParamPushedMessage                 @"pushedMessage"
#define kParamPushedType                    @"pushedType"
#define kParamPushedSubType                 @"pushedSubType"
#define kParamSelectedCount                 @"selectedCount"
#define kParamIsOn                          @"isON"
#define kParamSelectedIndex                 @"selectedIndex"
#define kParamNotificationName              @"notificationName"
#define kParamIsCollected                   @"isCollected"
#define kParamCompanyName                   @"companyName"
#define kParamCompanyAddress                @"companyAddress"
#define kParamCompanyPhone                  @"companyPhone"
#define kParamCompanyTax                    @"companyTax"
#define kParamBankAccount                   @"bankAccount"
#define kParamBankName                      @"bankName"
#define kParamCallBackBlock                 @"callBackBlock"
#define kParamEvaluatePojo                  @"evaluatePojo"
#define kParamOrderMainId                   @"orderMainId"

#pragma mark - 收货地址相关参数
#define kParamAddressModel                  @"addressModel"
#define kParamShipName                      @"shipName"
#define kParamProvinceId                    @"provinceId"
#define kParamCityId                        @"cityId"
#define kParamAreaId                        @"areaId"
#define kParamDetailAddress                 @"detailAddress"
#define kParamPostCode                      @"postCode"
#define kParamPhoneNumber                   @"phoneNumber"
#define kParamIsDefault                     @"isDefault"
#define kParamLongitude                     @"longitude"
#define kParamLatitude                      @"latitude"

#endif
