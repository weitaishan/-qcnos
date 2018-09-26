//
//  QCBlockView.m
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/20.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCBlockView.h"
#import "QCShoppingAddrssCell.h"
#import "QCBlockTitleCell.h"

@interface QCBlockView () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation QCBlockView

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

- (instancetype)init {
    self = [super init];
    if (self) {
        [self loadSubViews];
    }
    return self;
}

- (void)loadSubViews {
    [self addSubviews:@[self.tableView]];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self).offset(0);
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QCShoppingAddrssCell"
                                               bundle:nil]
         forCellReuseIdentifier:@"QCShoppingAddrssCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QCBlockTitleCell"
                                               bundle:nil]
         forCellReuseIdentifier:@"QCBlockTitleCell"];
}

#pragma mark UITableViewDelegate, UITableViewDataSource的回调方法

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                return 500;
            case 1:
                return 30;
            case 2:
                return 30;
        }
    }
    else {
        return 52;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }
    else {
        return 1;
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
                QCBlockTitleCell *cell =
                [tableView dequeueReusableCellWithIdentifier:@"QCBlockTitleCell"
                                                forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
            case 1:
            case 2:
            {
                NSString *identifier = @"defaultIdentifier";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                                  reuseIdentifier:identifier];
                }
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.textLabel.font = Font(11.f);
                cell.textLabel.textColor = k_Color_Title;
                if (indexPath.row == 1) {
                    cell.textLabel.text = @"官方网站地址: www.weoo.com";
                }
                else {
                    cell.textLabel.text = @"咨询服务电话: 400-1231-1267";
                }
                return cell;
            }
        }
    }
    else {
        QCShoppingAddrssCell *cell =
        [tableView dequeueReusableCellWithIdentifier:@"QCShoppingAddrssCell"
                                        forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.titleLabel.textColor = k_Color_Sub_Title;
        cell.contentLabel.textColor = k_Color_Sub_Title;
        return cell;
    }
    return [[UITableViewCell alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark headerAndFooter

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return [UIView new];
    }
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.font = Font(11.f);
    contentLabel.text = @"商业区块评估认证报告已发布";
    contentLabel.textColor = k_Color_Title;
    contentLabel.textAlignment = NSTextAlignmentCenter;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = Font(13.f);
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 3.f;
    btn.backgroundColor = k_Color_Text_Main;
    [btn setTitle:@"查看评估报告" forState:0];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    
    [view addSubviews:@[contentLabel, btn]];
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view).offset(15);
        make.left.mas_equalTo(view).offset(20);
        make.height.mas_equalTo(14);
        make.right.mas_equalTo(view).offset(-20);
    }];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentLabel.mas_bottom).offset(10);
        make.centerX.mas_equalTo(view);
        make.height.mas_equalTo(32);
        make.width.mas_equalTo(110);
    }];
    
    
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 5;
    }
    return 100;
}

@end
