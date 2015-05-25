//
//  ITTModel.h
//  InterfaceTestTool
//
//  Created by yangshengchao on 15/5/25.
//  Copyright (c) 2015年 Builder. All rights reserved.
//

#import "BaseModel.h"

#pragma mark - 数组映射关系

@protocol InterfaceGroupModel           @end
@protocol InterfaceModel                @end
@protocol TestCaseModel                 @end

//在本类里要使用的model
@class InterfaceModel;

//接口分组(最多两级)
@interface InterfaceGroupModel : BaseDataModel
@property (nonatomic, assign) NSInteger groupId;
@property (nonatomic, strong) NSString *groupName;
@property (nonatomic, assign) NSInteger sequenceId;

@property (nonatomic, assign) NSInteger interfaceCount;     //该分组下的接口数量
@property (nonatomic, strong) NSMutableArray *interfaceArray;
+ (NSArray *)FetchGroups;
- (void)initInterfaceArray;
- (BOOL)addToDB;            //添加
- (BOOL)saveToDB;           //更新
- (BOOL)deleteFromDB;       //删除
@end

//接口对象
@interface InterfaceModel : BaseDataModel
@property (nonatomic, assign) NSInteger interfaceId;        //接口id
@property (nonatomic, assign) NSInteger groupId;            //分组id
@property (nonatomic, strong) NSString *interfaceName;      //接口名称
@property (nonatomic, strong) NSString *interfacePrefixUrl; //空-就为默认 非空-个性化定制
@property (nonatomic, strong) NSString *interfacePath;      //接口地址
@property (nonatomic, strong) NSString *interfaceRemark;    //备注说明
@property (nonatomic, assign) NSInteger interfaceRequestType;//0-get 1-post
@property (nonatomic, assign) NSInteger interfaceStatus;    //0-需要测试 1-不需要测试
@property (nonatomic, assign) NSInteger sequenceId;         //排序编号
@property (nonatomic, assign) NSInteger totalCaseNumber;    //总的测试用例个数
@property (nonatomic, assign) NSInteger successCaseNumber;  //完全通过测试的用例个数
@property (nonatomic, assign) NSInteger partialCaseNumber;  //部分通过测试的用例个数
@property (nonatomic, assign) NSInteger errorCaseNumber;    //没有通过测试的用例个数

@property (nonatomic, strong) NSMutableArray *testCaseArray;//接口对应的测试用例数组
- (void)initTestCaseArray;
- (BOOL)addToDB;            //添加
- (BOOL)saveToDB;           //更新
- (BOOL)deleteFromDB;       //删除
@end

//测试用例对象
@interface TestCaseModel : BaseDataModel
@property (nonatomic, assign) NSInteger caseId;             //测试用例id
@property (nonatomic, assign) NSInteger interfaceId;        //接口id
@property (nonatomic, strong) NSString *caseInput;          //{"key":"value"}
@property (nonatomic, strong) NSString *caseOutput;         //实际返回结果
@property (nonatomic, strong) NSString *caseOutputStd;      //标准返回结果
@property (nonatomic, assign) NSInteger caseOutputType;     //0-返回字典模型 1-返回数组模型 2-空
@property (nonatomic, strong) NSString *caseOutputModel;    //返回结果的模型名称
@property (nonatomic, assign) NSInteger sequenceId;         //排序编号
@property (nonatomic, assign) NSInteger caseStatus;         //0-未测试 1-测试中 2-网络不通 3-字段不完整 9-字段完整
@property (nonatomic, assign) NSInteger spendTime;          //花费的时间(毫秒)
@end

