//
//  QCShopReleaseViewController.m
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/20.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCShopReleaseViewController.h"
#import "QCShoppingTitleCell.h"
#import "QCShopReleaseCell.h"

@interface QCShopReleaseViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation QCShopReleaseViewController

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
    self.title = @"发布区块动态";
    self.view.backgroundColor = [UIColor whiteColor];

    [self loadSubViews];
}

- (void)loadSubViews {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self.view);
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QCShopReleaseCell"
                                               bundle:nil]
         forCellReuseIdentifier:@"QCShopReleaseCell"];
}

#pragma mark UITableViewDelegate, UITableViewDataSource的回调方法

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 175;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCShopReleaseCell *cell =
    [tableView dequeueReusableCellWithIdentifier:@"QCShopReleaseCell"
                                    forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.backgroundColor = [UIColor whiteColor];
    button1.titleLabel.font = Font(11.f);
    button1.layer.masksToBounds = YES;
    button1.layer.cornerRadius = 3.f;
    button1.layer.borderColor = RGBA(229, 229, 229, 1).CGColor;
    button1.layer.borderWidth = 1.f;
 
    
    [button1 setTitleColor:k_Color_Title forState:0];
    [button1 setTitle:@"分类" forState:0];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = k_Color_Text_Main;
    button.titleLabel.font = Font(13.f);
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 5.f;
    
    [button setTitleColor:[UIColor whiteColor] forState:0];
    [button setTitle:@"确认发布" forState:0];
    
    [view addSubview:button1];
    [view addSubview:button];
    
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view).offset(10);
        make.left.mas_equalTo(view).offset(20);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(18);
    }];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view);
        make.top.mas_equalTo(button1.mas_bottom).offset(80.f);
        make.width.mas_equalTo(110);
        make.height.mas_equalTo(32);
    }];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 150;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
