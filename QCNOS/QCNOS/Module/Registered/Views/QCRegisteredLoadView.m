//
//  QCRegisteredLoadView.m
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/8/23.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCRegisteredLoadView.h"

@implementation QCRegisteredLoadView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self loadSubViews];
    }
    return self;
}

- (void)loadSubViews {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = [UIImage imageNamed:@"logo"];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = Font(21);
    titleLabel.textColor = RGBA(76, 76, 76, 1);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 0;
    titleLabel.text = @"量芯AI助手";
    
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = RGBA(210, 210, 210, 1);
    
    UILabel *label = [[UILabel alloc] init];
    label.font = Font(12);
    label.textColor = RGBA(83, 83, 83, 1);
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.text = @"即将为您的承载节点重置授权密码";
    
    [self addSubviews:@[imageView, titleLabel, line, label]];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(80);
        make.width.height.mas_equalTo(70);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView.mas_bottom).offset(55);
        make.left.mas_equalTo(self).offset(15);
        make.right.mas_equalTo(self).offset(-15);
        make.height.mas_equalTo(23);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self).offset(15);
        make.right.mas_equalTo(self).offset(-15);
        make.height.mas_equalTo(1);
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom).offset(40);
        make.left.mas_equalTo(self).offset(15);
        make.right.mas_equalTo(self).offset(-15);
        make.height.mas_equalTo(14);
    }];
}

@end
