//
//  QCPersonSelectNodeListCell.m
//  QCNOS
//
//  Created by 魏太山 on 2018/9/20.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCPersonSelectNodeListCell.h"
#import "QCGetBlockType.h"
@implementation QCPersonSelectNodeListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setModel:(QCGetBlockTypeChildList *)model{
    
    _model = model;
    
    self.lbName.text = model.name;
    
    self.lbDesc.text = model.desc ? model.desc : @"关于区块的文字介绍";
    
    
    
}
@end
