//
//  QCShoppingViewController.m
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/8/22.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCShoppingViewController.h"
#import "QCShoppingTitleCell.h"
#import "QCShoppingContentCell.h"
#import "QCShoppingAddrssCell.h"
#import "QCShoppingPriceCell.h"
#import "QCShoppingDetailVC.h"

@interface QCShoppingViewController () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation QCShoppingViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"逛街";
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadNavigation];
    
    [self loadSubViews];
   
}

- (void)loadNavigation {
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 25, 30);
    leftBtn.titleLabel.font = Font(15);
    [leftBtn setTitle:@"三亚" forState:0];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:0];
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;// 水平左对齐
    leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);

    [leftBtn setImage:[UIImage imageNamed:@"navigation_positioning"] forState:0];
    [leftBtn addTarget:self
                action:@selector(onCilckPositioning)
      forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIView *searchView = [[UIView alloc] init];
    searchView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
    UITextField *searchBar = [[UITextField alloc] init];
    searchBar.frame = CGRectMake(15, 0, SCREEN_WIDTH - 90, 30);
    [self rightViewWithTextField:searchBar imageName:@"navigation_search"];
    searchBar.backgroundColor = RGBA(255, 255, 255, 0.3);
    searchBar.layer.cornerRadius = 15;
    searchBar.layer.masksToBounds = YES;
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"您可使用量芯搜索互动店铺或可信的产品"
                                                                     attributes:
  @{
    NSForegroundColorAttributeName: [UIColor whiteColor],
    NSFontAttributeName: Font(12.f)
    }];
    searchBar.attributedPlaceholder = attrString;
    
    [searchView addSubview:searchBar];
    self.navigationItem.titleView = searchView;
}

- (void)rightViewWithTextField:(UITextField *)textField
                     imageName:(NSString *)imageName {
    UIImageView *rightView = [[UIImageView alloc]init];
    rightView.userInteractionEnabled = YES;
    rightView.image = [UIImage imageNamed:imageName];
    rightView.frame = CGRectMake(0, 0, 40, 25);
    rightView.contentMode = UIViewContentModeCenter;
    textField.rightView = rightView;
    textField.rightViewMode = UITextFieldViewModeAlways;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [rightView addGestureRecognizer:tap];

    @weakify(self);
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        @strongify(self);
        NSLog(@"点击发起搜索");
    }];
    textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 0)];
    textField.leftViewMode = UITextFieldViewModeAlways;
}

- (void)loadSubViews {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self.view);
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QCShoppingTitleCell"
                                               bundle:nil]
         forCellReuseIdentifier:@"QCShoppingTitleCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QCShoppingContentCell"
                                               bundle:nil]
         forCellReuseIdentifier:@"QCShoppingContentCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QCShoppingAddrssCell"
                                               bundle:nil]
         forCellReuseIdentifier:@"QCShoppingAddrssCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QCShoppingPriceCell"
                                               bundle:nil]
         forCellReuseIdentifier:@"QCShoppingPriceCell"];
}

#pragma mark UITableViewDelegate, UITableViewDataSource的回调方法

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            return 70;
        case 1:
            return 218;
        case 2:
            return 52;
        case 3:
            return 38;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            QCShoppingTitleCell *cell =
            [tableView dequeueReusableCellWithIdentifier:@"QCShoppingTitleCell"
                                            forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.headerImageView.backgroundColor = [UIColor redColor];
            return cell;
        }
        case 1:
        {
            QCShoppingContentCell *cell =
            [tableView dequeueReusableCellWithIdentifier:@"QCShoppingContentCell"
                                            forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.iconImgView.backgroundColor = [UIColor redColor];
            cell.leftImageView.backgroundColor = [UIColor redColor];
            cell.centerImageView.backgroundColor = [UIColor redColor];
            cell.rightImageView.backgroundColor = [UIColor redColor];
            return cell;
        }
        case 2:
        {
            QCShoppingAddrssCell *cell =
            [tableView dequeueReusableCellWithIdentifier:@"QCShoppingAddrssCell"
                                            forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
        case 3:
        {
            QCShoppingPriceCell *cell =
            [tableView dequeueReusableCellWithIdentifier:@"QCShoppingPriceCell"
                                            forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
    QCShoppingDetailVC *detailVC = [[QCShoppingDetailVC alloc] init];
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark headerAndFooter

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section != 0) {
        return [UIView new];
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    contentView.backgroundColor = [UIColor whiteColor];
    NSArray *titles = @[@"美食", @"生活", @"娱乐", @"文旅", @"全部"];
    CGFloat width = SCREEN_WIDTH / titles.count;
    [titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(width * idx, 0, width, 35);
        btn.titleLabel.font = Font(12.f);
        [btn setTitle:obj forState:0];
        [btn setTitleColor:k_Color_title forState:0];
        @weakify(self);
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            NSLog(@"点击了第%ld个按钮", idx);
        }];
        [contentView addSubview:btn];
    }];
    [view addSubview:contentView];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section != 0) {
        return 0.01;
    }
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

#pragma mark -- 点击定位
- (void)onCilckPositioning {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
