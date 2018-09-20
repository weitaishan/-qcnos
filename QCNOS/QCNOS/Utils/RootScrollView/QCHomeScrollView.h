//
//  QCHomeScrollView.h
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/6.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QCHomeScrollViewDelegate <NSObject>

/**
 点击按钮的事件回调

 @param button 当前点击的按钮
 @param index index
 @param selectButton 上一个选中的按钮
 */
- (void)homeScrollViewOnCilckButton:(UIButton *)button
                              index:(NSInteger)index
                       selectButton:(UIButton *)selectButton;

@end

@interface QCHomeScrollView : UIView

@property (nonatomic, weak) id<QCHomeScrollViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame
                       titles:(NSArray<NSString *> *)titles
              scrviewSubviews:(NSArray<UIView *> *)scrviewSubviews
                   titleColor:(UIColor *)titleColor
                  sliderColor:(UIColor *)sliderColor
                         font:(UIFont *)font
                 sliderHeight:(NSInteger)sliderHeight;

@end
