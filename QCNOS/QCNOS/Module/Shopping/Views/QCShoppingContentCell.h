//
//  QCShoppingContentCell.h
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/20.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QCShoppingContentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;

@property (weak, nonatomic) IBOutlet UIImageView *centerImageView;

@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;

@end
