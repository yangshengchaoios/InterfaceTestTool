//
//  ITTDetailViewController.m
//  InterfaceTestTool
//
//  Created by yangshengchao on 15/5/25.
//  Copyright (c) 2015年 Builder. All rights reserved.
//

#import "ITTDetailViewController.h"
#import "ITTDetailTableViewCell.h"

@interface ITTDetailViewController () <UITableViewDataSource, UITableViewDelegate>

//interface
@property (nonatomic, weak) IBOutlet UISwitch *statusSwitch;    //是否开启测试
@property (nonatomic, weak) IBOutlet UITextField *interfaceNameTextField;
@property (nonatomic, weak) IBOutlet UITextField *interfacePathTextField;
@property (nonatomic, weak) IBOutlet UITextField *interfacePrefixTextField;
@property (nonatomic, weak) IBOutlet UITextField *sequenceIdTextField;
@property (nonatomic, weak) IBOutlet UITextField *interfaceRemarkTextField;
@property (nonatomic, weak) IBOutlet UIButton *saveInterfaceButton;

//test case
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UITextView *caseOutputTextView;
@property (nonatomic, weak) IBOutlet UITextView *caseInputTextView;
@property (nonatomic, weak) IBOutlet UISegmentedControl *caseOutputTypeSegment;
@property (nonatomic, weak) IBOutlet UITextField *caseOutputModelTextField;
@property (nonatomic, weak) IBOutlet UITextView *caseOutputStdTextView;
@property (nonatomic, weak) IBOutlet UIButton *saveTestCaseButton;
@property (nonatomic, weak) IBOutlet UIButton *runTestCaseButton;

@property (nonatomic, weak) InterfaceModel *interfaceModel;
@property (nonatomic, copy) NSString *interfaceType;//add edit
@property (nonatomic, strong) NSString *testCaseType;//add edit
@end

@implementation ITTDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interfaceType = self.params[kParamType];
    self.interfaceModel = self.params[kParamModel];

    [self.tableView registerNib:[ITTDetailTableViewCell NibNameOfCell] forCellReuseIdentifier:kCellIdentifier];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.01)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.01)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:[self edgeInsetsOfCellSeperator]];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:[self edgeInsetsOfCellSeperator]];
    }
}

#pragma mark - 按钮事件
//保存接口信息
- (IBAction)saveInterfaceButtonClicked:(id)sender {
    if ([kParamAdd isEqualToString:self.interfaceType]) {
        //TODO:添加新的接口
    }
    else {
        //TODO:保存接口信息
    }
}
//保存测试用例
- (IBAction)saveTestCaseButtonClicked:(id)sender {
    if ([kParamAdd isEqualToString:self.interfaceType]) {
        //TODO:添加新的测试用例
    }
    else {
        //TODO:保存测试用例信息
    }
}
//启动测试
- (IBAction)runTestCaseButtonClicked:(id)sender {
    //TODO:启动测试
}

- (UIEdgeInsets)edgeInsetsOfCellSeperator {
    return UIEdgeInsetsZero;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.interfaceModel.testCaseArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ITTDetailTableViewCell HeightOfCell];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ITTDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    [cell layoutDataModel:self.interfaceModel.testCaseArray[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.testCaseType = @"edit";
    TestCaseModel *testCase = self.interfaceModel.testCaseArray[indexPath.row];
    self.caseOutputTextView.text = testCase.caseOutput;
    self.caseInputTextView.text = testCase.caseInput;
    self.caseOutputTypeSegment.selectedSegmentIndex = testCase.caseOutputType;
    self.caseOutputModelTextField.text = testCase.caseOutputModel;
    self.caseOutputStdTextView.text = testCase.caseOutputStd;
}

@end
