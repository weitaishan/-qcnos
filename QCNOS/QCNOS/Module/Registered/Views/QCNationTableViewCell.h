//
//  QCNationTableViewCell.h
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/4.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QCNationTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@end
