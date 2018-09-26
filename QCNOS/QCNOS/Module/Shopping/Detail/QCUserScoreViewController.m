//
//  QCUserScoreViewController.m
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/21.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCUserScoreViewController.h"
#import "QCShoppingTitleCell.h"
#import "QCScoreCell.h"
#import "QCUserScoreCell.h"
#import "QCUserScoreInputCell.h"

@interface QCUserScoreViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation QCUserScoreViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorColor = Color_Cell_Separator;
        _tableView.scrollEnabled = YES;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户评分";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadSubViews];
}

- (void)loadSubViews {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self.view);
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QCScoreCell"
                                               bundle:nil]
         forCellReuseIdentifier:@"QCScoreCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QCUserScoreCell"
                                               bundle:nil]
         forCellReuseIdentifier:@"QCUserScoreCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QCUserScoreInputCell"
                                               bundle:nil]
         forCellReuseIdentifier:@"QCUserScoreInputCell"];
}

#pragma mark UITableViewDelegate, UITableViewDataSource的回调方法

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            return 120;
        case 1:
            return 35;
        case 2:
            return 125;
    }
    return 90;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            QCUserScoreCell *cell =
            [tableView dequeueReusableCellWithIdentifier:@"QCUserScoreCell"
                                            forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        case 1:
        {
            QCScoreCell *cell =
            [tableView dequeueReusableCellWithIdentifier:@"QCScoreCell"
                                            forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        case 2:
        {
            QCUserScoreInputCell *cell =
            [tableView dequeueReusableCellWithIdentifier:@"QCUserScoreInputCell"
                                            forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        case 3:
        {
            NSString *identifier = @"uploadImageIdentifier";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                              reuseIdentifier:identifier];
            }
            cell.accessoryType = UITableViewCellAccessoryNone;
            return cell;
        }
    }
    return [[UITableViewCell alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark headerAndFooter

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = RGBA(245, 245, 245, 1);
    QCShoppingTitleCell *cell =
    [[NSBundle mainBundle] loadNibNamed:@"QCShoppingTitleCell" owner:self options:nil].firstObject;
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.headerImageView.backgroundColor = [UIColor redColor];
    cell.scoreLabel.text = @"当前发布:655条";
    [view addSubview:cell.contentView];
    [cell.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(70);
        make.left.right.top.mas_equalTo(view);
    }];
    
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = RGBA(229, 229, 229, 1);
    
    [view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(view).offset(70);
        make.left.right.mas_equalTo(view);
    }];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = k_Color_Title;
    label.font = Font(15);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"请为此推荐项目打分";
    
    UIView *scoreView = [[UIView alloc] init];
    scoreView.backgroundColor = [UIColor redColor];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.textColor = RGBA(255, 87, 34, 1);
    label1.font = Font(15);
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = @"四星，很棒！";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = k_Color_Text_Main;
    button.titleLabel.font = Font(13.f);
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 5.f;
    
    [button setTitleColor:[UIColor whiteColor] forState:0];
    [button setTitle:@"确认评分" forState:0];
    
    [view addSubviews:@[label, label1, scoreView, button]];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view).offset(40);
        make.left.mas_equalTo(view).offset(20);
        make.right.mas_equalTo(view).offset(-20);
        make.height.mas_equalTo(18);
    }];
    
    [scoreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label.mas_bottom).offset(20);
        make.centerX.mas_equalTo(view);
        make.width.mas_equalTo(190);
        make.height.mas_equalTo(30);
    }];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scoreView.mas_bottom).offset(20);
        make.left.mas_equalTo(view).offset(20);
        make.right.mas_equalTo(view).offset(-20);
        make.height.mas_equalTo(18);
    }];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view);
        make.top.mas_equalTo(label1.mas_bottom).offset(50);
        make.width.mas_equalTo(110);
        make.height.mas_equalTo(32);
    }];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 275;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
