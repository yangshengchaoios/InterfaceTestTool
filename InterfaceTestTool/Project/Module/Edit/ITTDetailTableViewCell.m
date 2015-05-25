//
//  ITTDetailTableViewCell.m
//  InterfaceTestTool
//
//  Created by yangshengchao on 15/5/25.
//  Copyright (c) 2015年 Builder. All rights reserved.
//

#import "ITTDetailTableViewCell.h"

@implementation ITTDetailTableViewCell

+ (CGFloat)HeightOfCell {
    return AUTOLAYOUT_LENGTH(80);
}

- (void)layoutDataModel:(TestCaseModel *)dataModel {
    self.caseIdLabel.text = [NSString stringWithFormat:@"%ld", dataModel.caseId];
    self.caseOutputModelLabel.text = dataModel.caseOutputModel;
    if (CaseOutputTypeDictionary == dataModel.caseOutputType) {//字典
        self.caseOutputTypeLabel.text = @"Dictionary";
    }
    else if (CaseOutputTypeArray == dataModel.caseOutputType) {//数组
        self.caseOutputTypeLabel.text = @"Array";
    }
    else {
        self.caseOutputTypeLabel.text = @"Empty";
    }
}

@end
