//
//  QCShoppingTitleCell.m
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/20.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCShoppingTitleCell.h"

@implementation QCShoppingTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.typeBtn.backgroundColor = RGBA(65, 122, 239, 0.1);
    self.typeBtn.layer.cornerRadius = 3.f;
    self.typeBtn.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
