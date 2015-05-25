//
//  ITTMainTableViewCell.m
//  InterfaceTestTool
//
//  Created by yangshengchao on 15/5/25.
//  Copyright (c) 2015年 Builder. All rights reserved.
//

#import "ITTMainTableViewCell.h"

@implementation ITTMainTableViewCell

+ (CGFloat)HeightOfCell {
    return AUTOLAYOUT_LENGTH(80);
}

- (void)layoutDataModel:(InterfaceModel *)dataModel {
    self.interfacePathLabel.text = dataModel.interfacePath;
    self.interfaceNameLabel.text = dataModel.interfaceName;
    self.totalCaseNumberLabel.text = [NSString stringWithFormat:@"%ld", dataModel.totalCaseNumber];
    self.successCaseNumberLabel.text = [NSString stringWithFormat:@"%ld", dataModel.successCaseNumber];
    self.partialCaseNumberLabel.text = [NSString stringWithFormat:@"%ld", dataModel.partialCaseNumber];
    self.errorCaseNumberLabel.text = [NSString stringWithFormat:@"%ld", dataModel.errorCaseNumber];
    if (0 == dataModel.interfaceRequestType) {
        self.interfaceRequestTypeLabel.text = @"get";
    }
    else {
        self.interfaceRequestTypeLabel.text = @"post";
    }
    self.statusSwitch.on = dataModel.interfaceStatus;
}

@end
