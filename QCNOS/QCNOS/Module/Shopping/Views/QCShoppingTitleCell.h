//
//  QCShoppingTitleCell.h
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/20.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QCShoppingTitleCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIButton *typeBtn;

@property (weak, nonatomic) IBOutlet UILabel *hotLabel;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;


@end
