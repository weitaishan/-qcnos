//
//  QCHomeScrollView.m
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/6.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCHomeScrollView.h"

@interface QCHomeScrollView ()<UIScrollViewDelegate>
//初始化保存数据
@property (nonatomic, strong) NSArray<NSString *> *titles;

@property (nonatomic, strong) NSArray<UIView *> *scrviewSubviews;

@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) UIColor *sliderColor;

@property (nonatomic, strong) UIFont *font;

@property (nonatomic, assign) NSInteger sliderHeight;
//页面逻辑相关
@property (nonatomic, strong) UIScrollView *topScrview;

@property (nonatomic, strong) UIScrollView *bottomScrview;

@property (nonatomic, strong) NSMutableArray<UIButton *> *buttons;

@property (nonatomic, strong) UIButton *selectButton;

@end

@implementation QCHomeScrollView

- (NSMutableArray<UIButton *> *)buttons {
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles
               scrviewSubviews:(NSArray<UIView *> *)scrviewSubviews
                    titleColor:(UIColor *)titleColor
                   sliderColor:(UIColor *)sliderColor
                          font:(UIFont *)font
                  sliderHeight:(NSInteger)sliderHeight {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.titles = titles;
        self.scrviewSubviews = scrviewSubviews;
        self.titleColor = titleColor;
        self.sliderColor = sliderColor;
        self.font = font;
        self.sliderHeight = sliderHeight;
        [self loadSubViews];
    }
    return self;
}

- (void)loadSubViews {
    [self creatScrollview];
    [self creatTableview];
}

- (void)creatTableview {
    [self.scrviewSubviews enumerateObjectsUsingBlock:^(UIView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        view.frame = CGRectMake(SCREEN_WIDTH * idx, 0, SCREEN_WIDTH, CGRectGetHeight(self.bottomScrview.frame));
        [self.bottomScrview addSubview:view];
    }];
}

- (void)creatScrollview {
    NSInteger count = self.titles.count;
    for (int i = 0; i < count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i * SCREEN_WIDTH / count,
                                                                   0,
                                                                   SCREEN_WIDTH / count,
                                                                   40)];
        [btn setTitle:self.titles[i] forState:UIControlStateNormal];
        [self.buttons addObject:btn];
        if (i == 0) {
            [btn setTitleColor:self.titleColor
                      forState:UIControlStateNormal];
            self.selectButton = btn;
            btn.titleLabel.font = Font(15.f);
        }
        else {
            btn.titleLabel.font = self.font;
            [btn setTitleColor:self.titleColor forState:UIControlStateNormal];
        }
        __weak typeof(btn) sender = btn;
        @weakify(self);
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            if ([self.delegate respondsToSelector:
                 @selector(homeScrollViewOnCilckButton:index:selectButton:)]) {
                [self.delegate homeScrollViewOnCilckButton:sender
                                                     index:i
                                              selectButton:self.selectButton];
            }
            
            self.selectButton = sender;
            
            [self.bottomScrview setContentOffset:CGPointMake(SCREEN_WIDTH * i, 0)
                                        animated:YES];
        }];
        
        [self addSubview:btn];
    }
    
    self.topScrview = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                                     CGRectGetMaxY(self.selectButton.frame),
                                                                     SCREEN_WIDTH / count,
                                                                     self.sliderHeight)];
    [self addSubview:self.topScrview];
    
    self.topScrview.backgroundColor = self.sliderColor;
    self.topScrview.delegate = self;
    self.topScrview.contentSize = CGSizeMake(SCREEN_WIDTH / count, self.sliderHeight);
    self.topScrview.showsHorizontalScrollIndicator = NO;
    self.topScrview.showsVerticalScrollIndicator = NO;
    
    self.bottomScrview = [[UIScrollView alloc]initWithFrame:CGRectMake(0,
                                                                       CGRectGetMaxY(self.topScrview.frame),
                                                                       SCREEN_WIDTH,
                                                                       SCREEN_HEIGHT -
                                                                    CGRectGetMaxY(self.topScrview.frame))];
    [self addSubview:self.bottomScrview];
    
    self.bottomScrview.delegate = self;
    self.bottomScrview.pagingEnabled = YES;
    self.bottomScrview.showsHorizontalScrollIndicator = NO;
    self.bottomScrview.showsVerticalScrollIndicator = NO;
    self.bottomScrview.contentSize = CGSizeMake(SCREEN_WIDTH * count, 0);
    self.bottomScrview.bounces = NO;

}

#pragma mark--实时监听滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.bottomScrview) {
        self.topScrview.contentOffset = CGPointMake(self.bottomScrview.contentOffset.x / self.titles.count,
                                                    0);
        self.topScrview.frame = CGRectMake(self.bottomScrview.contentOffset.x / self.titles.count,
                                           40,
                                           SCREEN_WIDTH / self.titles.count,
                                           self.sliderHeight);
    }
}

#pragma mark--停止滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.bottomScrview) {
        int i = self.bottomScrview.contentOffset.x / SCREEN_WIDTH;
        UIButton *btn = self.buttons[i];
        [self.selectButton setTitleColor:self.titleColor
                                forState:UIControlStateNormal];
        [btn setTitleColor:self.titleColor
                  forState:UIControlStateNormal];
        self.selectButton = btn;
    }
}

@end
