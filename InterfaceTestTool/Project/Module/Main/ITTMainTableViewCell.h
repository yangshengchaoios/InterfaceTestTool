//
//  ITTMainTableViewCell.h
//  InterfaceTestTool
//
//  Created by yangshengchao on 15/5/25.
//  Copyright (c) 2015年 Builder. All rights reserved.
//

@interface ITTMainTableViewCell : BaseTableViewCell

@property (nonatomic, weak) IBOutlet UILabel *interfacePathLabel;       //接口地址
@property (nonatomic, weak) IBOutlet UILabel *interfaceNameLabel;       //接口名称
@property (nonatomic, weak) IBOutlet UILabel *totalCaseNumberLabel;     //总的测试用例
@property (nonatomic, weak) IBOutlet UILabel *successCaseNumberLabel;   //完全通过的测试用例
@property (nonatomic, weak) IBOutlet UILabel *partialCaseNumberLabel;   //部分通过的测试用例
@property (nonatomic, weak) IBOutlet UILabel *errorCaseNumberLabel;     //没有通过的测试用例
@property (nonatomic, weak) IBOutlet UILabel *interfaceRequestTypeLabel;//post get
@property (nonatomic, weak) IBOutlet UISwitch *statusSwitch;

@end
