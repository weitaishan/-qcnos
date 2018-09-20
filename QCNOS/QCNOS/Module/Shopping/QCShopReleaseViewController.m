//
//  QCShopReleaseViewController.m
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/20.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCShopReleaseViewController.h"
#import "QCShoppingTitleCell.h"

@interface QCShopReleaseViewController ()

@end

@implementation QCShopReleaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布区块动态";
    self.view.backgroundColor = [UIColor whiteColor];
    
    QCShoppingTitleCell *cell =
    [[NSBundle mainBundle] loadNibNamed:@"QCShoppingTitleCell" owner:self options:nil].firstObject;
    cell.headerImageView.backgroundColor = [UIColor redColor];
    cell.scoreLabel.text = @"当前发布:655条";
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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
