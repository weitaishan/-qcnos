//
//  QCInvitaitionBaseListCell.h
//  QCNOS
//
//  Created by 魏太山 on 2018/9/20.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCBaseTableViewCell.h"

@interface QCInvitaitionBaseListCell : QCBaseTableViewCell

@property (weak, nonatomic) IBOutlet UIView *centerView;

@property (weak, nonatomic) IBOutlet UIView *footerView;


- (void)hiddenViewWithType:(NSInteger)type;

+ (CGFloat)heightWithType:(NSInteger)type;
@end
