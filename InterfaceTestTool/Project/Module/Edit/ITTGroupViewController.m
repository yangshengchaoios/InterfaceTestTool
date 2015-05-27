//
//  ITTGroupViewController.m
//  InterfaceTestTool
//
//  Created by yangshengchao on 15/5/27.
//  Copyright (c) 2015年 Builder. All rights reserved.
//

#import "ITTGroupViewController.h"
#import "YSCTableViewCell.h"

@interface ITTGroupViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITextField *groupNameTextField;
@property (nonatomic, weak) IBOutlet UITextField *groupSequenceIdTextField;

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, copy) CallBackWithResponseBlock callBackBlock;
@property (nonatomic, strong) InterfaceGroupModel *selectedGroup;

@end

@implementation ITTGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.callBackBlock = self.params[kParamCallBackBlock];
    self.selectedGroup = [InterfaceGroupModel new];
    self.selectedGroup.groupId = [self.params[kParamGroupId] integerValue];
    
    [self initTableView];
    [self layoutGroupInfo];
    [self refreshGroups];
}

- (void)initTableView {
    [self.tableView registerNib:[YSCTableViewCell NibNameOfCell] forCellReuseIdentifier:kCellIdentifier];
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

- (UIViewController *)backViewController {
    if (self.callBackBlock && self.selectedGroup.groupId > 0) {
        self.callBackBlock(self.selectedGroup);
    }
    return [super backViewController];
}

- (void)layoutGroupInfo {
    if (0 == self.selectedGroup.groupId) {
        self.groupNameTextField.text = nil;
        self.groupSequenceIdTextField.text = nil;
    }
    else {
        self.groupNameTextField.text = Trim(self.selectedGroup.groupName);
        self.groupSequenceIdTextField.text = [NSString stringWithFormat:@"%ld", self.selectedGroup.sequenceId];
    }
}
//刷新数据源
- (void)refreshGroups {
    if (nil == self.dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    else {
        [self.dataArray removeAllObjects];
    }
    self.groupNameTextField.text = nil;
    self.groupSequenceIdTextField.text = nil;
    [self.dataArray addObjectsFromArray:[InterfaceGroupModel FetchGroups]];
    [self.tableView reloadData];
}

#pragma mark - 按钮事件

- (IBAction)addButtonClicked:(id)sender {
    self.selectedGroup.groupId = 0;
    [self layoutGroupInfo];
}

- (IBAction)deleteButtonClicked:(id)sender {
    if (0 == self.selectedGroup.groupId) {
        [self showResultThenHide:@"请先选择分组"];
        return;
    }
    
    [self showHUDLoading:@"正在删除"];
    if ([self.selectedGroup deleteFromDB]) {
        [self showResultThenHide:@"删除成功"];
        self.selectedGroup = [InterfaceGroupModel new];
        [self refreshGroups];
    }
    else {
        [self showResultThenHide:@"删除失败"];
    }
}

- (IBAction)saveButtonClicked:(id)sender {
    NSString *groupName = Trim(self.groupNameTextField.text);
    CheckIfEmpty(groupName, @"请先输入分组名称");
    if ([CommonUtils SqliteCheckIfExists:[NSString stringWithFormat:@"SELECT 1 FROM interface_group WHERE groupName = '%@'", groupName]]) {
        [self showResultThenHide:[NSString stringWithFormat:@"分组名称[%@]已经存在", groupName]];
        return;
    }
    
    [self showHUDLoading:@"正在保存"];
    self.selectedGroup.groupName = groupName;
    self.selectedGroup.sequenceId = [self.groupSequenceIdTextField.text integerValue];
    if (0 == self.selectedGroup.groupId) {
        if ([self.selectedGroup addToDB]) {
            [self showResultThenHide:@"添加成功"];
            [self refreshGroups];
        }
        else {
            [self showResultThenHide:@"添加失败"];
        }
    }
    else {
        if ([self.selectedGroup saveToDB]) {
            [self showResultThenHide:@"修改成功"];
            [self refreshGroups];
        }
        else {
            [self showResultThenHide:@"修改失败"];
        }
    }
}

#pragma mark - 方法重写

- (UIEdgeInsets)edgeInsetsOfCellSeperator {
    return UIEdgeInsetsZero;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return AUTOLAYOUT_LENGTH(80);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YSCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    InterfaceGroupModel *groupModel = self.dataArray[indexPath.row];
    if (self.selectedGroup.groupId == groupModel.groupId) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.subtitleLeftTitleLabel.text = groupModel.groupName;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:[self edgeInsetsOfCellSeperator]];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedGroup = self.dataArray[indexPath.row];
    [self layoutGroupInfo];
}

@end
