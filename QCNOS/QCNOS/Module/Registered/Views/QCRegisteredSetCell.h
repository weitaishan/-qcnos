//
//  QCRegisteredSetCell.h
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/8/23.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QCRegisteredSetCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UISwitch *cellSwitch;

@end
