//
//  QCShoppingDetailVC.m
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/20.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCShoppingDetailVC.h"
#import "QCHomeScrollView.h"

@interface QCShoppingDetailVC () <QCHomeScrollViewDelegate>

@property (nonatomic, strong) QCHomeScrollView *rootScrollView;

@end

@implementation QCShoppingDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"店铺详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadSubViews];
}

- (void)loadSubViews {
    NSArray *titles = @[@"推荐", @"附近", @"上新", @"热门"];
    NSMutableArray *views = [NSMutableArray array];
    for (int i = 0; i < 4; i ++) {
        UIView *view = [[UIView alloc] init];
        if (i == 0) {
            view.backgroundColor = [UIColor redColor];
        }
        else {
            view.backgroundColor = [UIColor blueColor];
        }
        [views addObject:view];
    }
    QCHomeScrollView *scrollView = [[QCHomeScrollView alloc] initWithTitles:titles
                                                            scrviewSubviews:views.copy
                                                                 titleColor:RGBA(52, 52, 52, 1)
                                                                sliderColor:k_Color_Text_Main
                                                                       font:Font(13.f)
                                                               sliderHeight:3];
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

#pragma mark -- QCHomeScrollViewDelegate的回调
- (void)homeScrollViewOnCilckButton:(UIButton *)button
                              index:(NSInteger)index
                       selectButton:(UIButton *)selectButton {
    button.titleLabel.font = Font(15.f);
    selectButton.titleLabel.font = Font(13.f);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
