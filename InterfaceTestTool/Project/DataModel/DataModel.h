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
//用户
@protocol SimpleUserModel           @end
@protocol UserModel                 @end
@protocol ContactModel              @end
@protocol BusinessCardModel         @end
@protocol BannerModel               @end
//商品
@protocol ProductCategoryModel      @end
@protocol SimpleProductModel        @end
@protocol ProductModel              @end
@protocol SimpleShopModel           @end
@protocol ProductSku1Model          @end
@protocol LastEvaluateModel         @end
@protocol ProductSkuModel           @end
@protocol ValueModel                @end
@protocol SkuModel                  @end
@protocol AttributeModel            @end
@protocol ProductSkuRelationModel   @end
@protocol ProductCommentModel       @end
@protocol ShoppingCartReturnModel   @end
//订单
@protocol AccountModel              @end
@protocol SimpleProductOrderModel   @end
@protocol ProductOrderModel         @end
@protocol OrderProductModel         @end
@protocol InvoiceModel              @end
@protocol OrderExpressFareModel     @end
@protocol UserIntegralModel         @end
@protocol SubmitProductOrderModel   @end
@protocol SubmitProductOrderReturnModel @end
@protocol ShoppingCartModel         @end
@protocol OtherPhoneModel           @end
@protocol RechargeInfoModel         @end
//经销商
@protocol BusinessProductModel      @end
@protocol BusinessCartProductModel  @end
@protocol SubmitBusinessOrderModel  @end
@protocol SimpleBusinessOrderModel  @end
@protocol BusinessOrderModel        @end
//个人中心
@protocol AddressModel              @end
@protocol CouponModel               @end
@protocol LogisticsTrackModel       @end
@protocol CollectionProductModel    @end
@protocol BrowseHistoryModel        @end
@protocol ImageModel                @end
@protocol GameModel                 @end
@protocol CommonItemModel           @end
//payment
@protocol PaymentModel              @end


#pragma mark - 公共model需要用到的class声明

/**
 *  要使用的model在本类里
 */
@class BaseDataModel, SimpleUserModel, BusinessCardModel,


ProductCategoryModel, SimpleProductModel, ProductModel, SimpleShopModel, AttributeModel, SkuModel, SimpleProductOrderModel,
OrderProductModel, ProductSkuRelationModel, ProductSkuModel, ProductSku1Model, AddressModel, OrderModel, LastEvaluateModel,
LogisticsTrackModel, InvoiceModel, BusinessCartProductModel, SimpleSpecialSaleModel;




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

//联系人模型
@interface ContactModel : BaseDataModel

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

- (id)initWithAvatar:(NSString *)avatar name:(NSString *)name position:(NSString *)position;

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
@property (nonatomic, strong) NSNumber *balance;            //钱包余额
@property (nonatomic, strong) BusinessCardModel *businessCard;//个人名片
@property (nonatomic, strong) NSString *token;

@property (nonatomic, assign) NSInteger shoppingCartProductCount;//购物车里的商品数量

@end

//个人名片
@interface BusinessCardModel : BaseDataModel

@property (nonatomic, strong) NSString *cardImage;          //用户名片的图片
@property (nonatomic, strong) NSString *cardBarCode;        //用户的二维码唯一url地址
@property (nonatomic, strong) NSString *companyLogo;        //用户所在公司的logo图片url地址
@property (nonatomic, strong) NSString *companyName;        //公司名称
@property (nonatomic, strong) NSString *companyWebSite;     //公司官网地址

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


//-------------------------------------------------------------------------------------------
//
//  商品相关
//
//-------------------------------------------------------------------------------------------
//按商品类别分
@interface ProductCategoryModel : BaseDataModel

@property (nonatomic, strong) NSString *categoryId;
@property (nonatomic, strong) NSString *categoryIcon;   //分类icon的完整url地址
@property (nonatomic, strong) NSString *categoryTitle;
@property (nonatomic, strong) NSString *categorySubTitle;
@property (nonatomic, strong) NSArray<ProductCategoryModel> *subCategories;

@end

//简单商品模型
@interface SimpleProductModel : BaseDataModel

@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *productName;        //商品名称
@property (nonatomic, strong) NSString *productImage;       //主图
@property (nonatomic, strong) NSNumber *marketPrice;        //市场价格
@property (nonatomic, strong) NSNumber *salePrice;          //销售价格

//UI布局需要
@property (nonatomic, assign) BOOL isSelected;

@end

//商品模型（详情）
@interface ProductModel : BaseDataModel

@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *productName;        //商品名称
@property (nonatomic, strong) NSString *productImage;       //主图
@property (nonatomic, strong) NSNumber *marketPrice;        //市场价格
@property (nonatomic, strong) NSNumber *salePrice;          //销售价格
@property (nonatomic, strong) NSString *priceRange;         //价格区间 100-200
@property (nonatomic, strong) NSString *productInfo;        //商品名称副标题
@property (nonatomic, strong) NSString *productDescription;
@property (nonatomic, assign) BOOL isCollected;
@property (nonatomic, strong) NSString *collectedId;
@property (nonatomic, assign) BOOL isStoreCollected;
@property (nonatomic, strong) NSString *collectedStoreId;
@property (nonatomic, strong) NSArray<ImageModel> *productImages;
@property (nonatomic, strong) NSArray<AttributeModel> *productAttributes;
@property (nonatomic, strong) NSArray<ProductSku1Model> *productSkus;//TODO:需要重新组装成二维数组
@property (nonatomic, strong) NSArray<ProductSkuRelationModel> *productSkuRelations;//TODO:需要重新组装成二维数组
@property (nonatomic, strong) NSString *evaluateScore;      //商品综合评价
@property (nonatomic, strong) LastEvaluateModel *lastEvaluate;   //最后一个评价信息=lastEvaluateInfo
@property (nonatomic, strong) SimpleShopModel *simpleShop;  //商品所属店铺=store
@property (nonatomic, assign) NSInteger saleNum;            //销售总量
@property (nonatomic, assign) NSInteger evaluateNum;        //评价总数
@property (nonatomic, assign) NSInteger groupLimitNum;      //团购限购数量
@property (nonatomic, strong) SimpleProductModel *deliveryProduct;//买就送的商品
@property (nonatomic, strong) NSString *shareProductUrl;

//UI布局需要
@property (nonatomic, assign) BOOL isSelected;

- (ProductSkuModel *)buildProductSkuModel;

@end

//店铺简单模型
@interface SimpleShopModel : BaseDataModel

@property (nonatomic, strong) NSString *shopId;
@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, strong) NSString *shopIcon;               //店铺icon完整url路径
@property (nonatomic, strong) NSString *shopDescription;        //店铺描述
@property (nonatomic, assign) BOOL isStoreCollected;
@property (nonatomic, assign) BOOL isHaoYunTao;                 //是否是官方账号

@end

//修改后的商品规格数组
@interface ProductSku1Model : BaseDataModel

@property (nonatomic, strong) NSString *valueId;
@property (nonatomic, strong) NSString *valueName;//=value
@property (nonatomic, assign) BOOL isImage;     //NOTE:暂时不用
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *skuName;//=productSpecName
@property (nonatomic, strong) NSString *skuId;//=specNameId

@end

//最后一个评价模型
@interface LastEvaluateModel : BaseDataModel

@property (nonatomic, strong) NSString *nickName;//评价用户名=evaluateUserName
@property (nonatomic, strong) NSString *evaluateTime;//用户评论时间
@property (nonatomic, strong) NSString *evaluateProductSpec;//用户购买商品属性
@property (nonatomic, strong) NSString *evaluateInfo;//用户评论信息
@property (nonatomic, strong) NSString *avatarUrl;//用户头像地址=userPhotoUrl
@property (nonatomic, strong) NSString *evaluateScore; // 评分

@property (nonatomic, assign) BOOL isEndEditing;

@end

//商品规格描述
@interface ProductSkuModel : BaseDataModel

@property (nonatomic, strong) NSArray<SkuModel> *productSkus;
@property (nonatomic, strong) NSArray<ProductSkuRelationModel> *productSkuRelations;

//业务逻辑相关
@property (nonatomic, weak) ProductSkuRelationModel *selectedSkuRelation;   //选中的规格关系对象
@property (nonatomic, strong) NSString *selectedSkuValue;                   //已经选中的规格值描述
@property (nonatomic, strong) NSMutableDictionary *selectedSkusDictionary;  //已经选中的规格名称和值的键值对

- (void)selectSkuId:(NSString *)skuId andValueId:(NSString *)valueId;

@end

//规格值模型
@interface ValueModel : BaseDataModel

@property (nonatomic, strong) NSString *valueId;
@property (nonatomic, strong) NSString *valueName;  //白色
@property (nonatomic, assign) BOOL isImage;         //0-不显示图片 1-显示图片
@property (nonatomic, strong) NSString *image;      //图片url

//UI布局需要
@property (nonatomic, weak) UILabel *valueLabel;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) BOOL isEnable;

@end

//规格模型
@interface SkuModel : BaseDataModel

@property (nonatomic, strong) NSString *skuId;
@property (nonatomic, strong) NSString *skuName;
@property (nonatomic, strong) NSArray<ValueModel> *skuValues;

@end

//属性模型(与价格无关)
@interface AttributeModel : BaseDataModel

@property (nonatomic, strong) NSString *attributeId;
@property (nonatomic, strong) NSString *attributeName;
@property (nonatomic, strong) NSArray<ValueModel> *attributeValues;

@end

//属性值之间的关系（主要是排列组合和多价格、库存问题）
@interface ProductSkuRelationModel : BaseDataModel

@property (nonatomic, strong) NSString *productSkuId;       //规格值数组，如32,34,4  =id
@property (nonatomic, strong) NSNumber *marketPrice;        //市场价格(未启用)
@property (nonatomic, strong) NSNumber *salePrice;          //销售价格=price
@property (nonatomic, assign) NSInteger stockNumber;        //库存数量=cout
@property (nonatomic, assign) NSInteger soldNumber;         //销量(未启用)

@end

//商品评论模型
@interface ProductCommentModel : BaseDataModel

@property (nonatomic, strong) NSString *commentId;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) SimpleUserModel *commentUser;
@property (nonatomic, strong) NSString *productSkuValue;
@property (nonatomic, strong) NSString *commentContent;
@property (nonatomic, strong) NSString *commentImages;

@end

//添加购物车成功后返回的数据模型
@interface ShoppingCartReturnModel : BaseDataModel

@property (nonatomic, strong) NSString *shoppingCartProductId;   //购物车里的商品数量
@property (nonatomic, assign) NSInteger shoppingCartProductCount;//购物车真实数量

@end

//-------------------------------------------------------------------------------------------
//
//  订单相关
//
//-------------------------------------------------------------------------------------------
/**
 * 支付模型
 */
@interface PaymentModel : BaseDataModel

@property (nonatomic, strong) NSString *paymentCode;    //支付代码
@property (nonatomic, strong) NSString *paymentName;    //支付名称
@property (nonatomic, strong) NSString *paymentIcon;    //支付的icon(兼容字段)
@property (nonatomic, assign) BOOL isActive;            //是否有效
@property (nonatomic, assign) BOOL isSelected;          //是否选中
@property (nonatomic, strong) NSString *paymentRemarks; //如果有备注信息，则在点击的时候弹出框提示一下

@end
//账单模型
@interface AccountModel : BaseDataModel

@property (nonatomic, strong) NSString *accountId;      //自增ID，用于查询，支付等操作传递的参数
@property (nonatomic, strong) NSString *createTime;     //创建时间
@property (nonatomic, strong) NSString *accountNum;     // 只做显示使用
@property (nonatomic, strong) NSNumber *totalPrice;
@property (nonatomic, strong) NSString *productNum;
@property (nonatomic, strong) PaymentModel *paymentModel;
@property (nonatomic, strong) NSArray<SimpleProductOrderModel> *productOrders;   //子订单列表

@end

//实物子订单简单模型
@interface SimpleProductOrderModel : BaseDataModel

@property (nonatomic, strong) NSString *orderId;        //订单id
@property (nonatomic, strong) NSString *orderNum;       // 订单编号
@property (nonatomic, strong) NSString *accountId;      // 该子订单对应的账单ID
@property (nonatomic, strong) NSString *accountNum;     // 该子订单对应的账单编号
@property (nonatomic, strong) NSString *shopName;       //店铺名称
@property (nonatomic, strong) NSString *createTime;     //创建时间
@property (nonatomic, assign) OrderStatusType orderStatus;    //订单状态
@property (nonatomic, strong) NSString *expressNo;      //快递单号
@property (nonatomic, strong) NSString *expressName;    //快递公司名称
@property (nonatomic, strong) NSArray<OrderProductModel> *orderProducts;

//支付订单要用
@property (nonatomic, strong) NSString *orderDescription;


@end

//子订单模型
@interface ProductOrderModel : BaseDataModel

@property (nonatomic, strong) NSString *orderId;        //订单id
@property (nonatomic, strong) NSString *orderNum;       // 订单编号
@property (nonatomic, strong) NSString *shopName;       //店铺名称
@property (nonatomic, strong) NSString *createTime;     //创建时间
@property (nonatomic, assign) OrderStatusType orderStatus;    //订单状态
@property (nonatomic, strong) NSString *expressNo;      //快递单号
@property (nonatomic, strong) NSString *expressName;    //快递公司名称
@property (nonatomic, strong) NSArray<OrderProductModel> *orderProducts;

@property (nonatomic, strong) LogisticsTrackModel *latestLogistics;
@property (nonatomic, strong) AddressModel *address;
@property (nonatomic, strong) InvoiceModel *invoice;
@property (nonatomic, strong) NSNumber *fare;           //运费
@property (nonatomic, strong) NSNumber *integralMoney;  //积分抵现
@property (nonatomic, strong) NSNumber *couponMoney;    //优惠码抵现
@property (nonatomic, strong) NSNumber *totalAmount;    //实际支付金额

@end

//订单列表里的商品
//该模型也用于传递model到结算中心
@interface OrderProductModel : BaseDataModel

@property (nonatomic, strong) NSString *orderProductId;
@property (nonatomic, strong) NSString *skuValue;
@property (nonatomic, strong) NSNumber *realPrice;
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, strong) SimpleProductModel *simpleProduct;
@property (nonatomic, strong) LastEvaluateModel *evaluateModel;
@property (nonatomic, strong) SimpleProductModel *deliveryProduct;

//UI
@property (nonatomic, assign) CGFloat amount;
@property (nonatomic, assign) BOOL isSelected;      //当前商品是否处于选中状态
@property (nonatomic, assign) BOOL isExpanded;      //是否处于展开状态
@property (nonatomic, assign) NSInteger rateNumber; //评价的分数
@property (nonatomic, strong) NSString *commentContent; // 评论的内容

@end

//发票模型
@interface InvoiceModel : BaseDataModel

@property (nonatomic, assign) InvoiceType invoiceType;          //1-普通发票 2-增值税发票
@property (nonatomic, assign) InvoiceObjectType invoiceObject;  //1-个人 2-单位
@property (nonatomic, strong) NSString *invoiceTitle;           //发票抬头
@property (nonatomic, assign) InvoiceContentType invoiceContent;//1-耗材 2-办公用品 3-商品明细

// 增值发票额外参数
@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, strong) NSString *companyAddress;
@property (nonatomic, strong) NSString *companyPhone;
@property (nonatomic, strong) NSString *companyTax;
@property (nonatomic, strong) NSString *bankAccount;
@property (nonatomic, strong) NSString *bankName;

@end

//根据订单返回邮费模型
@interface OrderExpressFareModel : BaseDataModel

@property (nonatomic, strong) NSString *shopId;                 //店铺id
@property (nonatomic, strong) NSNumber *expressFare;            //邮费

@end

//返回用户积分模型
@interface UserIntegralModel : BaseDataModel

@property (nonatomic, assign) NSInteger integral;
@property (nonatomic, strong) NSNumber *integralMoney;

@end

//提交实物订单模型
@interface SubmitProductOrderModel : BaseDataModel

@property (nonatomic, strong) AddressModel *address;
@property (nonatomic, strong) InvoiceModel *invoice;
@property (nonatomic, strong) NSArray<OrderProductModel> *orderProducts;
@property (nonatomic, assign) OrderFromType orderFromType;      //1-来自购物车 2-来自商品详情立即购买
@property (nonatomic, strong) NSString *remark;                 //备注信息
@property (nonatomic, strong) NSNumber *integralMoney;          //积分抵现
@property (nonatomic, strong) NSNumber *couponMoney;            //优惠码抵现
@property (nonatomic, strong) NSString *paymentTypeId;          //支付方式的编码
@property (nonatomic, strong) NSNumber *amount;                 //订单金额

@end

//实物订单提交成功后返回的数据模型
@interface SubmitProductOrderReturnModel : BaseDataModel

@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSNumber *paymentMoney;           //实际支付费用

@end

//购物车模型
@interface ShoppingCartModel : BaseDataModel

@property (nonatomic, strong) NSString *shopId;
@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, assign) NSInteger shopCount;  //总的件数
@property (nonatomic, strong) NSArray<OrderProductModel> *shoppingCartProducts;
@property (nonatomic, strong) NSNumber *totalPrice;   //总金额

//UI布局需要的属性
@property (nonatomic, assign) BOOL isSelected;      //当前店铺是否处于选中状态
@property (nonatomic, assign) BOOL isEdited;        //当前店铺是否处于编辑状态
@property (nonatomic, strong) NSString *orderDescription;

- (void)updateProductsSelected:(BOOL)isSelected;
- (void)checkIfAllSelected;

@end

//虚拟订单模型
@interface OtherPhoneModel : BaseDataModel

@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *orderNum;               // 订单编号（只用作显示）
@property (nonatomic, strong) NSString *accountId;              // 该子订单对应的账单ID(用于查询等操作传递的参数)
@property (nonatomic, strong) NSString *accountNum;             // 该子订单对应的账单编号(只做显示使用)
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *orderType;              //订单类型
@property (nonatomic, strong) NSString *mobileNumber;           //手机号
@property (nonatomic, strong) NSNumber *amount;                 //充值金额
@property (nonatomic, strong) NSString *orderStatus;            //订单状态
@property (nonatomic, strong) NSNumber *payMoney;               //应付款

@end

@interface RechargeInfoModel : BaseDataModel

@property (nonatomic, strong) NSString *type;    //手机号码类型(移动或联通)
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSNumber *realCount;  //折扣后的话费

@end


//-------------------------------------------------------------------------------------------
//
//  经销商
//
//-------------------------------------------------------------------------------------------
//查询返回的商品列表模型
@interface BusinessProductModel : BaseDataModel

@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) ProductSkuModel *productSku;

@end

//订货购物车里的商品信息
@interface BusinessCartProductModel : BaseDataModel

@property (nonatomic, strong) NSString *businessProductId;
@property (nonatomic, strong) BusinessProductModel *businessProduct;
@property (nonatomic, strong) NSString *skuValue;
@property (nonatomic, strong) NSNumber *salePrice;
@property (nonatomic, strong) NSNumber *number;             //订货数量
@property (nonatomic, strong) NSString *unit;               //单位名称 "箱"

@end

//提交订货单
@interface SubmitBusinessOrderModel : BaseDataModel

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *deliveryTime;
@property (nonatomic, strong) AddressModel *address;
@property (nonatomic, strong) InvoiceModel *invoice;
@property (nonatomic, strong) NSArray<BusinessCartProductModel> *orderProducts;
@property (nonatomic, strong) NSString *remark;

@end

//订货单列表模型
@interface SimpleBusinessOrderModel : BaseDataModel

@property (nonatomic, strong) NSString *businessOrderId;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *orderStatus;
@property (nonatomic, strong) NSNumber *payMoney;
@property (nonatomic, strong) NSArray<BusinessCartProductModel> *businessOrderProducts;

@end

//订货单详情模型
@interface BusinessOrderModel : BaseDataModel

@property (nonatomic, strong) NSString *deliveryTime;
@property (nonatomic, strong) AddressModel *address;
@property (nonatomic, strong) InvoiceModel *invoice;
@property (nonatomic, strong) NSString *remark;

@end

//-------------------------------------------------------------------------------------------
//
//  个人中心相关
//
//-------------------------------------------------------------------------------------------
//收货地址模型
@interface AddressModel : BaseDataModel

@property (nonatomic, strong) NSString *addressId;
@property (nonatomic, strong) NSString *shipName;
@property (nonatomic, strong) NSString *provinceId;
@property (nonatomic, strong) NSString *cityId;
@property (nonatomic, strong) NSString *sectionId;
@property (nonatomic, strong) NSString *street;        //详细街道信息，如xxx路xxx号
@property (nonatomic, strong) NSString *postCode;
@property (nonatomic, strong) NSString *phoneNumber;   //收货人电话号码
@property (nonatomic, strong) NSString *longitude;     //经度
@property (nonatomic, strong) NSString *latitude;      //纬度
@property (nonatomic, assign) BOOL isDefault;

@property (nonatomic, strong) NSString *addressString; //缓存sqlite查询出来的地址信息

/**
 *  根据三级地址的id查询对应的地址文字信息
 *
 *  @param provinceId
 *  @param cityId
 *  @param sectionId
 *
 *  @return
 */
+ (NSString *)addressString:(NSString *)provinceId city:(NSString *)cityId section:(NSString *)sectionId;

@end

//优惠码模型
@interface CouponModel : BaseDataModel

@property (nonatomic, strong) NSString *couponId;
@property (nonatomic, strong) NSString *couponName;         //85折
@property (nonatomic, strong) NSNumber *couponAmount;       //优惠金额
//@property (nonatomic, strong) NSString *couponRate;         //折扣比例 0.85
@property (nonatomic, strong) NSString *couponIcon;         //折扣icon完整url地址
@property (nonatomic, strong) NSString *couponDescription;  //优惠码描述
@property (nonatomic, strong) NSString *expires;            //过期时间戳
@property (nonatomic, assign) BOOL isUsed;                  //是否使用过了

//UI布局需要的属性
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, strong) NSString *couponCode;         //优惠码

@end

//物流跟踪信息
@interface LogisticsTrackModel : BaseDataModel

@property (nonatomic, strong) NSString *logTime;        //时间戳
@property (nonatomic, strong) NSString *logDescription; //物流信息描述

@end

//收藏的商品
@interface CollectionProductModel : BaseDataModel

@property (nonatomic, strong) NSString *collectionId;
@property (nonatomic, strong) SimpleProductModel *simpleProduct;

@end

//浏览记录模型
@interface BrowseHistoryModel : BaseDataModel

@property (nonatomic, strong) NSString *browseHistoryId;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) SimpleProductModel *simpleProduct;

@end

//图片通用模型
@interface ImageModel : BaseDataModel

@property (nonatomic, strong) NSString *imageUrl;

@end

//游戏模型
@interface GameModel : BaseDataModel

@property (nonatomic, strong) NSString *gameId;
@property (nonatomic, strong) NSString *gameName;
@property (nonatomic, strong) NSString *gameUrl;
@property (nonatomic, strong) NSString *gameIcon;
@property (nonatomic, strong) NSString *gameVersion;
@property (nonatomic, strong) NSString *gameVoiceDownloadUrl;
@property (nonatomic, strong) NSString *gameDescription;

@end

#pragma mark - 公共小功能
@interface CommonItemModel : BaseDataModel

@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *viewController;
+ (CommonItemModel *)buildNewItem:(NSString *)icon title:(NSString *)title viewController:(NSString *)viewController;

@end


