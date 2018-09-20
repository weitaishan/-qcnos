//
//  QCShoppingContentCell.m
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/20.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCShoppingContentCell.h"

@implementation QCShoppingContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.typeLabel.backgroundColor = RGBA(235, 84, 5, 0.1);
    self.typeLabel.textColor = RGBA(235, 84, 5, 1);
    self.typeLabel.layer.cornerRadius = 3.f;
    self.typeLabel.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
