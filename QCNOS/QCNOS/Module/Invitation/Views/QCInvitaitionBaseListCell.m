//
//  QCInvitaitionBaseListCell.m
//  QCNOS
//
//  Created by 魏太山 on 2018/9/20.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCInvitaitionBaseListCell.h"

@implementation QCInvitaitionBaseListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)hiddenViewWithType:(NSInteger)type{
    
    if (type == 0) {
        
        self.centerView.hidden = YES;
        self.footerView.hidden = YES;
        
    }else if (type == 1){
        
        self.centerView.hidden = NO;
        self.footerView.hidden = YES;

    }
    
    self.centerView.hidden = NO;
    self.footerView.hidden = NO;
}

+ (CGFloat)heightWithType:(NSInteger)type{
    
    if (type == 0) {
        
        return 111.f;
        
    }else if (type == 1){
        
        return 208.f;
        
    }
    
    return 260.f;
}
@end
