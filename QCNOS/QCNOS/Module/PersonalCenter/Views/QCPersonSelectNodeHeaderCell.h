//
//  QCPersonSelectNodeHeaderCell.h
//  QCNOS
//
//  Created by 魏太山 on 2018/9/20.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCBaseTableViewCell.h"

@interface QCPersonSelectNodeHeaderCell : QCBaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbRight;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UILabel *lbDesc;

@end
