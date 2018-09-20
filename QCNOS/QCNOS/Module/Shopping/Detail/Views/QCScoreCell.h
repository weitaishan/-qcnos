//
//  QCScoreCell.h
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/20.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QCScoreCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
//评分小星星的View
@property (weak, nonatomic) IBOutlet UIView *scoreView;
//转发
@property (weak, nonatomic) IBOutlet UIButton *forwardingBtn;
//评论
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;

@end
