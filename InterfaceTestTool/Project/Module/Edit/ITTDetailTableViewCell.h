//
//  ITTDetailTableViewCell.h
//  InterfaceTestTool
//
//  Created by yangshengchao on 15/5/25.
//  Copyright (c) 2015年 Builder. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CaseOutputType) {
    CaseOutputTypeDictionary = 0,
    CaseOutputTypeArray = 1,
    CaseOutputTypeEmpty = 2
};

@interface ITTDetailTableViewCell : BaseTableViewCell
@property (nonatomic, weak) IBOutlet UILabel *caseIdLabel;
@property (nonatomic, weak) IBOutlet UILabel *caseOutputModelLabel;
@property (nonatomic, weak) IBOutlet UILabel *caseOutputTypeLabel;
@property (nonatomic, weak) IBOutlet UILabel *caseStatusLabel;
@end
