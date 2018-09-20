//
//  QCShoppingDetailVC.m
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/20.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCShoppingDetailVC.h"
#import "QCHomeScrollView.h"
#import "QCRecommendView.h"
#import "QCQuestionView.h"
#import "QCCustomerFlowView.h"
#import "QCBlockView.h"
#import "QCShoppingTitleCell.h"

@interface QCShoppingDetailVC () <QCHomeScrollViewDelegate>

@property (nonatomic, strong) QCRecommendView *recommendView;

@property (nonatomic, strong) QCQuestionView *questionView;

@property (nonatomic, strong) QCCustomerFlowView *customerFlowView;

@property (nonatomic, strong) QCBlockView *blockView;

@end

@implementation QCShoppingDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"店铺详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadSubViews];
}

- (void)loadSubViews {
    
    QCShoppingTitleCell *cell =
    [[NSBundle mainBundle] loadNibNamed:@"QCShoppingTitleCell" owner:self options:nil].firstObject;
    cell.headerImageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:cell.contentView];
    [cell.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(70);
        make.left.right.top.mas_equalTo(self.view);
    }];
    
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = RGBA(229, 229, 229, 1);
    
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(self.view).offset(70);
        make.left.right.mas_equalTo(self.view);
    }];
    
    NSArray *titles = @[@"推荐", @"问答", @"客流", @"区块"];
    NSArray *views = @[self.recommendView, self.questionView, self.customerFlowView, self.blockView];
    QCHomeScrollView *scrollView = [[QCHomeScrollView alloc] initWithFrame:
                                    CGRectMake(0, 71, SCREEN_WIDTH, SCREEN_HEIGHT - 71 - 64)
                                                                    titles:titles
                                                            scrviewSubviews:views.copy
                                                                 titleColor:RGBA(52, 52, 52, 1)
                                                                sliderColor:k_Color_Text_Main
                                                                       font:Font(13.f)
                                                               sliderHeight:3];
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
}

#pragma mark -- QCHomeScrollViewDelegate的回调
- (void)homeScrollViewOnCilckButton:(UIButton *)button
                              index:(NSInteger)index
                       selectButton:(UIButton *)selectButton {
    button.titleLabel.font = Font(15.f);
    selectButton.titleLabel.font = Font(13.f);
}

#pragma mark -- 懒加载

- (QCRecommendView *)recommendView {
    if (!_recommendView) {
        _recommendView = [[QCRecommendView alloc] init];
    }
    return _recommendView;
}

- (QCQuestionView *)questionView {
    if (!_questionView) {
        _questionView = [[QCQuestionView alloc] init];
    }
    return _questionView;
}

- (QCCustomerFlowView *)customerFlowView {
    if (!_customerFlowView) {
        _customerFlowView = [[QCCustomerFlowView alloc] init];
    }
    return _customerFlowView;
}

- (QCBlockView *)blockView {
    if (!_blockView) {
        _blockView = [[QCBlockView alloc] init];
    }
    return _blockView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
