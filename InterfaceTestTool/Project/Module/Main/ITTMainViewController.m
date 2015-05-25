//
//  ITTMainViewController.m
//  InterfaceTestTool
//
//  Created by yangshengchao on 15/5/15.
//  Copyright (c) 2015年 Builder. All rights reserved.
//

#import "ITTMainViewController.h"
#import "ITTMainTableViewCell.h"

@interface ITTMainViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@end

@implementation ITTMainViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"接口列表";
    
    [self.tableView registerNib:[ITTMainTableViewCell NibNameOfCell] forCellReuseIdentifier:kCellIdentifier];
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
    
    WeakSelfType blockSelf = self;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"添加" style:UIBarButtonItemStyleBordered handler:^(id sender) {
        [blockSelf pushViewController:@"ITTDetailViewController" withParams:@{kParamTitle : @"添加接口", kParamType : kParamAdd}];
    }];
    
}

- (UIEdgeInsets)edgeInsetsOfCellSeperator {
    return UIEdgeInsetsZero;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
    return [[ITTManager sharedInstance].interfaceGroupArray count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
    InterfaceGroupModel *groupModel = [ITTManager sharedInstance].interfaceGroupArray[section];
    return [groupModel.interfaceArray count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"\tsection_%ld", section];
    InterfaceGroupModel *groupModel = [ITTManager sharedInstance].interfaceGroupArray[section];
    return groupModel.groupName;
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    ((UITableViewHeaderFooterView *)view).contentView.backgroundColor = [UIColor lightGrayColor];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return AUTOLAYOUT_LENGTH(40);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ITTMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
//    InterfaceGroupModel *groupModel = [ITTManager sharedInstance].interfaceGroupArray[indexPath.section];
//    [cell layoutDataModel:groupModel.interfaceArray[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ITTMainTableViewCell HeightOfCell];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    InterfaceGroupModel *groupModel = [ITTManager sharedInstance].interfaceGroupArray[indexPath.section];
    InterfaceModel *interface = groupModel.interfaceArray[indexPath.row];
    [self pushViewController:@"ITTDetailViewController"
                  withParams:@{kParamTitle : [NSString stringWithFormat:@"修改接口-%@", Trim(interface.interfaceName)],
                               kParamType : kParamEdit,
                               kParamModel : interface}];
}

@end
