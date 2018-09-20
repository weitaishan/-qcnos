//
//  QCGenderView.h
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/8/24.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, QCGenderType) {
    QCGenderTypeMen = 0,           //男生
    QCGenderTypeWomen,             //女生
};

@interface QCGenderView : UIView

- (instancetype)initWtihType:(QCGenderType)type
                      select:(BOOL)select;

- (void)genderViewNone;

- (void)genderViewSelect;

@end
