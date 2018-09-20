//
//  QCGenderView.m
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/8/24.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCGenderView.h"

@interface QCGenderView ()

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UIImageView *selectImgView;

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, assign) QCGenderType type;

@property (nonatomic, assign) BOOL select;

@end

@implementation QCGenderView

- (instancetype)initWtihType:(QCGenderType)type
                      select:(BOOL)select {
    self = [super init];
    if (self) {
        self.type = type;
        self.select = select;
        [self loadGenderSubViews];
    }
    return self;
}

- (void)loadGenderSubViews {
    self.imgView = [[UIImageView alloc] init];
    self.selectImgView = [[UIImageView alloc] init];
    self.label = [[UILabel alloc] init];
    self.label.font = Font(11);
    self.label.textAlignment = NSTextAlignmentCenter;
    
    [self genderViewIsSeletStatusWithSytle];
    
    [self addSubviews:@[self.selectImgView, self.imgView, self.label]];
    
    [self.selectImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self).offset(-30);
        make.left.mas_equalTo(self).offset(5);
        make.width.height.mas_equalTo(12);
    }];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self).offset(-30);
        make.left.mas_equalTo(self.selectImgView.mas_right).offset(17);
        make.width.mas_equalTo(32);
        make.height.mas_equalTo(62);
    }];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imgView.mas_bottom).offset(10);
        make.left.mas_equalTo(self.imgView.mas_left).offset(0);
        make.width.mas_equalTo(32);
        make.height.mas_equalTo(12);
    }];
}

- (void)genderViewSelect {
    self.select = YES;
    [self genderViewIsSeletStatusWithSytle];
}

- (void)genderViewNone {
    self.select = NO;
    [self genderViewIsSeletStatusWithSytle];
}

- (void)genderViewIsSeletStatusWithSytle {
    if (self.type == QCGenderTypeMen) {
        self.label.text = @"男";
        if (self.select) {
            self.label.textColor = k_Color_Text_Main;
            self.imgView.image = [UIImage imageNamed:@"registered_man_select"];
            self.selectImgView.image = [UIImage imageNamed:@"registered_gender_select"];
        }
        else {
            self.label.textColor = RGBA(164, 164, 164, 1);
            self.imgView.image = [UIImage imageNamed:@"registered_man_none"];
            self.selectImgView.image = [UIImage imageNamed:@"registered_gender_none"];
        }
    }
    else {
        self.label.text = @"女";
        if (self.select) {
            self.label.textColor = k_Color_Text_Main;
            self.imgView.image = [UIImage imageNamed:@"registered_women_select"];
            self.selectImgView.image = [UIImage imageNamed:@"registered_gender_select"];
        }
        else {
            self.label.textColor = RGBA(164, 164, 164, 1);
            self.imgView.image = [UIImage imageNamed:@"registered_women_none"];
            self.selectImgView.image = [UIImage imageNamed:@"registered_gender_none"];
        }
    }
}

@end
