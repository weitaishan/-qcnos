//
//  QCRecommendView.m
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/20.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCRecommendView.h"
#import "QCShoppingAddrssCell.h"
#import "QCScoreCell.h"
#import "QCShoppingDetailCell.h"
#import "QCCommentCell.h"
#import "QCCommentContentCell.h"

@interface QCRecommendView () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) UIView *footerView;

@end

@implementation QCRecommendView

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorColor = Color_Cell_Separator;
        _tableView.scrollEnabled = YES;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _tableView;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] init];
        
        UIView *topView = [self loadFooterTopView];
        UIView *bottomView = [self loadFooterBottomView];

        [_footerView addSubviews:@[topView, bottomView]];
        
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(_footerView).offset(0);
            make.height.mas_equalTo(50);
        }];
        
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(topView.mas_bottom).offset(0);
            make.left.right.mas_equalTo(_footerView).offset(0);
            make.height.mas_equalTo(50);
        }];
    }
    return _footerView;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self loadSubViews];
    }
    return self;
}

- (void)loadSubViews {
    [self addSubviews:@[self.tableView, self.footerView]];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self).offset(-100);
    }];
    
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self);
        make.height.mas_equalTo(100);
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QCShoppingAddrssCell"
                                               bundle:nil]
         forCellReuseIdentifier:@"QCShoppingAddrssCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QCScoreCell"
                                               bundle:nil]
         forCellReuseIdentifier:@"QCScoreCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QCShoppingDetailCell"
                                               bundle:nil]
         forCellReuseIdentifier:@"QCShoppingDetailCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QCCommentCell"
                                               bundle:nil]
         forCellReuseIdentifier:@"QCCommentCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QCCommentContentCell"
                                               bundle:nil]
         forCellReuseIdentifier:@"QCCommentContentCell"];
    
}

#pragma mark UITableViewDelegate, UITableViewDataSource的回调方法

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                return 500;
            case 1:
                return 52;
            case 2:
                return 35;
        }
    }
    else {
        if (indexPath.row == 0) {
            return 75;
        }
        else {
            return 180;
        }
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }
    else {
        return 10;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                QCShoppingDetailCell *cell =
                [tableView dequeueReusableCellWithIdentifier:@"QCShoppingDetailCell"
                                                forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
            case 1:
            {
                QCShoppingAddrssCell *cell =
                [tableView dequeueReusableCellWithIdentifier:@"QCShoppingAddrssCell"
                                                forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                return cell;
            }
            case 2:
            {
                QCScoreCell *cell =
                [tableView dequeueReusableCellWithIdentifier:@"QCScoreCell"
                                                forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
        }
    }
    else {
        if (indexPath.row == 0) {
            QCCommentCell *cell =
            [tableView dequeueReusableCellWithIdentifier:@"QCCommentCell"
                                            forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else {
            QCCommentContentCell *cell =
            [tableView dequeueReusableCellWithIdentifier:@"QCCommentContentCell"
                                            forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.headerImgView.backgroundColor = [UIColor redColor];
            return cell;
        }
    }
   
    NSString *identifier = @"defaultIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark headerAndFooter

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}


- (UIView *)loadFooterTopView {
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = RGBA(252, 175, 65, 1);
    
    UILabel *label = [[UILabel alloc] init];
    label.font = Font(11.f);
    label.text = @"你现在可以预约";
    label.textColor = [UIColor whiteColor];
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.font = Font(13.f);
    contentLabel.text = @"邀约好友一起到店可获现金奖励";
    contentLabel.textColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor whiteColor];
    @weakify(self);
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(self);
            make.bottom.mas_equalTo(self).offset(-50);
        }];
        
        [self.footerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.mas_equalTo(self);
            make.height.mas_equalTo(50);
        }];
        
        [topView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(_footerView).offset(0);
            make.height.mas_equalTo(0);
        }];
    }];
    
    [topView addSubviews:@[label, contentLabel, btn]];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView).offset(10);
        make.left.mas_equalTo(topView).offset(20);
        make.height.mas_equalTo(13);
        make.right.mas_equalTo(topView).offset(-50);
    }];
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label.mas_bottom).offset(5);
        make.left.mas_equalTo(topView).offset(20);
        make.height.mas_equalTo(15);
        make.right.mas_equalTo(topView).offset(-50);
    }];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(topView);
        make.height.width.mas_equalTo(18);
        make.right.mas_equalTo(topView).offset(-20);
    }];
    
    return topView;
}

- (UIView *)loadFooterBottomView {
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.font = Font(16.f);
    label.text = @"￥1525.00起";
    label.textColor = RGBA(254, 101, 53, 1);
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.font = Font(11.f);
    contentLabel.text = @"免费配送";
    contentLabel.textColor = RGBA(52, 52, 52, 1);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = Font(15.f);
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 3.f;
    btn.backgroundColor = RGBA(254, 101, 53, 1);
    [btn setTitle:@"马上预约" forState:0];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    
    [bottomView addSubviews:@[label, contentLabel, btn]];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomView).offset(5);
        make.left.mas_equalTo(bottomView).offset(20);
        make.height.mas_equalTo(18);
        make.right.mas_equalTo(bottomView).offset(-140);
    }];
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label.mas_bottom).offset(5);
        make.left.mas_equalTo(bottomView).offset(20);
        make.height.mas_equalTo(13);
        make.right.mas_equalTo(bottomView).offset(-140);
    }];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomView);
        make.height.mas_equalTo(32);
        make.width.mas_equalTo(110);
        make.right.mas_equalTo(bottomView).offset(-20);
    }];
    return bottomView;
}

@end
