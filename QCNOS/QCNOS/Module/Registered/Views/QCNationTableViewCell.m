//
//  QCNationTableViewCell.m
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/4.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCNationTableViewCell.h"

@implementation QCNationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.numberLabel.layer.masksToBounds = YES;
    self.numberLabel.layer.cornerRadius = 5.f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
