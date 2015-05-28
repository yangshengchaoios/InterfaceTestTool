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
@property (nonatomic, weak) IBOutlet UISwitch *requestSwitch;    //是否为POST
@property (nonatomic, weak) IBOutlet UITextField *interfaceNameTextField;
@property (nonatomic, weak) IBOutlet UITextField *interfacePathTextField;
@property (nonatomic, weak) IBOutlet UITextField *interfacePrefixTextField;
@property (nonatomic, weak) IBOutlet UITextField *sequenceIdTextField;
@property (nonatomic, weak) IBOutlet UITextField *interfaceRemarkTextField;
@property (nonatomic, weak) IBOutlet UILabel *interfaceGroupLabel;

//test case
@property (nonatomic, weak) IBOutlet UILabel *testCaseTitleLabel;
@property (nonatomic, weak) IBOutlet UITableView *testCaseTableView;
@property (nonatomic, weak) IBOutlet UITextView *caseOutputTextView;
@property (nonatomic, weak) IBOutlet UITextView *caseInputTextView;
@property (nonatomic, weak) IBOutlet UISegmentedControl *caseOutputTypeSegment;
@property (nonatomic, weak) IBOutlet UITextField *caseOutputModelTextField;
@property (nonatomic, weak) IBOutlet UITextView *caseOutputStdTextView;

@property (nonatomic, strong) InterfaceModel *interfaceModel;
@property (nonatomic, copy) NSString *interfaceType;//add edit
@property (nonatomic, strong) InterfaceGroupModel *currentGroupModel;
@property (nonatomic, strong) TestCaseModel *currentTestCase;

@end

@implementation ITTDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTestCaseTableView];
    
    //初始化数据
    WeakSelfType blockSelf = self;
    self.interfaceModel = [InterfaceModel new];
    self.currentGroupModel = [InterfaceGroupModel new];
    if (self.params[kParamModel]) {
        self.interfaceType = kParamEdit;
        self.interfaceModel = self.params[kParamModel];
        self.currentGroupModel.groupId = self.interfaceModel.groupId;
        self.currentGroupModel.groupName = self.interfaceModel.groupName;
    }
    else {
        self.interfaceType = kParamAdd;
    }
    [self layoutInterface];
    [self refreshTestCases];
    
    //点击选择接口分组
    self.interfaceGroupLabel.userInteractionEnabled = YES;
    [self.interfaceGroupLabel bk_whenTapped:^{
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[kParamTitle] = @"选择接口分组";
        params[kParamGroupId] = @(blockSelf.currentGroupModel.groupId);
        params[kParamCallBackBlock] = ^(InterfaceGroupModel *groupModel) {
            blockSelf.currentGroupModel = groupModel;
            blockSelf.interfaceGroupLabel.text = blockSelf.currentGroupModel.groupName;
        };
        [blockSelf pushViewController:@"ITTGroupViewController" withParams:params];
    }];
}

- (void)refreshTestCases {
    [self.interfaceModel initTestCaseArray];
    [self.testCaseTableView reloadData];
    self.testCaseTitleLabel.text = [NSString stringWithFormat:@"测试用例(%ld)", [self.interfaceModel.testCaseArray count]];
    self.currentTestCase = nil;
    [self layoutTestCase];
}

//初始化测试用例的列表
- (void)initTestCaseTableView {
    [self.testCaseTableView registerNib:[ITTDetailTableViewCell NibNameOfCell] forCellReuseIdentifier:kCellIdentifier];
    self.testCaseTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.01)];
    self.testCaseTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.01)];
    self.testCaseTableView.delegate = self;
    self.testCaseTableView.dataSource = self;
    self.testCaseTableView.backgroundColor = [UIColor whiteColor];
    if ([self.testCaseTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.testCaseTableView setSeparatorInset:[self edgeInsetsOfCellSeperator]];
    }
    if ([self.testCaseTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.testCaseTableView setLayoutMargins:[self edgeInsetsOfCellSeperator]];
    }
}

//显示当前接口信息
- (void)layoutInterface {
    self.statusSwitch.on = self.interfaceModel.interfaceStatus;
    self.requestSwitch.on = self.interfaceModel.interfaceRequestType;
    self.interfaceNameTextField.text = Trim(self.interfaceModel.interfaceName);
    self.interfacePathTextField.text = Trim(self.interfaceModel.interfacePath);
    self.interfacePrefixTextField.text = Trim(self.interfaceModel.interfacePrefixUrl);
    self.sequenceIdTextField.text = [NSString stringWithFormat:@"%ld", self.interfaceModel.sequenceId];
    self.interfaceRemarkTextField.text = Trim(self.interfaceModel.interfaceRemark);
    self.interfaceGroupLabel.text = Trim(self.interfaceModel.groupName);
    self.interfaceGroupLabel.text = self.currentGroupModel.groupName;
}

//显示当前的测试用例
- (void)layoutTestCase {
    if (nil == self.currentTestCase) {
        self.caseInputTextView.text = nil;
        self.caseOutputTypeSegment.selectedSegmentIndex = 0;
        self.caseOutputModelTextField.text = nil;
        self.caseOutputStdTextView.text = nil;
        self.caseOutputTextView.text = nil;
    }
    else {
        self.caseInputTextView.text = self.currentTestCase.caseInput;
        self.caseOutputTypeSegment.selectedSegmentIndex = self.currentTestCase.caseOutputType;
        self.caseOutputModelTextField.text = Trim(self.currentTestCase.caseOutputModel);
        self.caseOutputStdTextView.text = Trim(self.currentTestCase.caseOutputStd);
        self.caseOutputTextView.text = Trim(self.currentTestCase.caseOutput);
    }
}


#pragma mark - 按钮事件
//保存接口信息
- (IBAction)saveInterfaceButtonClicked:(id)sender {
    //合法性校验
    CheckIfEmpty(Trim(self.interfaceNameTextField.text), @"接口名称不能为空")
    CheckIfEmpty(Trim(self.interfacePathTextField.text), @"接口地址不能为空")
    CheckIfEmpty(self.currentGroupModel.groupName, @"分组设置不能为空");
    
    //
    self.interfaceModel.interfaceStatus = self.statusSwitch.isOn;
    self.interfaceModel.interfaceRequestType = self.requestSwitch.isOn;
    self.interfaceModel.interfaceName = Trim(self.interfaceNameTextField.text);
    self.interfaceModel.interfacePath = Trim(self.interfacePathTextField.text);
    self.interfaceModel.interfacePrefixUrl = Trim(self.interfacePrefixTextField.text);
    self.interfaceModel.sequenceId = [self.sequenceIdTextField.text integerValue];
    self.interfaceModel.groupId = self.currentGroupModel.groupId;
    self.interfaceModel.groupName = self.currentGroupModel.groupName;
    self.interfaceModel.interfaceRemark = Trim(self.interfaceRemarkTextField.text);
    
    if ([kParamAdd isEqualToString:self.interfaceType]) {
        if ([self.interfaceModel addToDB]) {
            [self showResultThenHide:@"添加成功"];
        }
        else {
            [self showAlertVieWithMessage:@"添加失败！"];
        }
    }
    else {
        if ([self.interfaceModel saveToDB]) {
            [self showResultThenHide:@"修改成功"];
        }
        else {
            [self showAlertVieWithMessage:@"修改失败！"];
        }
    }
}

//添加测试用例
- (IBAction)addTestCaseButtonClicked:(id)sender {
    self.currentTestCase = nil;
    [self layoutTestCase];
}
//删除测试用例
- (IBAction)deleteTestCaseButtonClicked:(id)sender {
    if (nil == self.currentTestCase) {
        [self showResultThenHide:@"请先选择测试用例"];
        return;
    }
    WeakSelfType blockSelf = self;
    UIAlertView *alertView = [UIAlertView bk_alertViewWithTitle:@"确定要删除该用例！"];
    [alertView bk_addButtonWithTitle:@"删除" handler:^{
        [blockSelf showHUDLoading:@"正在删除"];
        if ([blockSelf.currentTestCase deleteFromDB]) {
            [blockSelf showResultThenHide:@"删除成功"];
            [blockSelf refreshTestCases];
        }
        else {
            [blockSelf showResultThenHide:@"删除失败"];
        }
    }];
    [alertView bk_setCancelButtonWithTitle:@"取消" handler:nil];
    [alertView show];
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

#pragma mark - 方法重写

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

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:[self edgeInsetsOfCellSeperator]];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.currentTestCase = self.interfaceModel.testCaseArray[indexPath.row];
    [self layoutTestCase];
}

@end
