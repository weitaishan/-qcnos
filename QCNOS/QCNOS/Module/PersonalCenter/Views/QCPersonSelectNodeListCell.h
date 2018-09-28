//
//  QCPersonSelectNodeListCell.h
//  QCNOS
//
//  Created by 魏太山 on 2018/9/20.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCBaseTableViewCell.h"
@class QCGetBlockTypeChildList;

@interface QCPersonSelectNodeListCell : QCBaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImg;

@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbDesc;

@property (weak, nonatomic) IBOutlet UIButton *applyBtn;

@property (nonatomic, strong) QCGetBlockTypeChildList* model;
@end
