//
//  QCPersonCenterListCell.h
//  QCNOS
//
//  Created by 魏太山 on 2018/9/20.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCBaseTableViewCell.h"

@interface QCPersonCenterListCell : QCBaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *rightTitle;
@property (weak, nonatomic) IBOutlet UIImageView *rightImg;

@end
