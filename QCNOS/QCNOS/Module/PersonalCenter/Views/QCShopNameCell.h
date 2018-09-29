//
//  QCShopNameCell.h
//  QCNOS
//
//  Created by 魏太山 on 2018/9/29.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCBaseTableViewCell.h"

@interface QCShopNameCell : QCBaseTableViewCell
@property (weak, nonatomic) IBOutlet UITextField *lbName;
@property (weak, nonatomic) IBOutlet UITextField *lbCity;
@property (weak, nonatomic) IBOutlet UITextField *lbAddress;

@end
