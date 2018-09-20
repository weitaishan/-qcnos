//
//  QCNationVC.m
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/4.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCNationVC.h"
#import "QCNationTableViewCell.h"
#import "QCNationModel.h"

@interface QCNationVC () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) NSMutableArray<QCNationModel *> *datas;

@end

@implementation QCNationVC

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorColor = Color_Cell_Separator;
        _tableView.scrollEnabled = YES;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"所有其他国家或地区";
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadSubView];
}

- (void)loadSubView {
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self.view);
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QCNationTableViewCell"
                                               bundle:nil]
         forCellReuseIdentifier:@"QCNationTableViewCell"];
    [self nationRequestServerData];
}

- (void)nationRequestServerData {
    [YJProgressHUD showLoading:@"加载中..."];
    NSURLRequest *request = [NSURLRequest nationalWithParameters:nil];
    [QCURLSessionManager dataTaskWithRequest:request successBlock:^(id responseObject) {
        NSDictionary *datas = responseObject[@"data"];
        self.datas = [NSMutableArray array];
        for (NSDictionary *data in datas) {
            [self.datas addObject:[QCNationModel yy_modelWithDictionary:data]];
        }
        [self.tableView reloadData];
        [YJProgressHUD showSuccess:@"加载成功"];
    } failBlock:^(QCError *error) {
        [YJProgressHUD showError:error.localizedDescription];
    }];
}

#pragma mark UITableViewDelegate, UITableViewDataSource的回调方法

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCNationTableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:@"QCNationTableViewCell"
                                    forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    QCNationModel *model = self.datas[indexPath.row];
    cell.titleLabel.text = model.chineseName;
    cell.contentLabel.text = model.chineseLanguage;
    cell.numberLabel.text = [NSString stringWithFormat:@"+%@", model.mobileCode];
    if ([model.chineseName isEqualToString:@"中国"]) {
        cell.imgView.hidden = NO;
    }
    else {
        cell.imgView.hidden = YES;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.block) {
        QCNationModel *model = self.datas[indexPath.row];
        self.block(model.mobileCode,
                   model.code,
                   model.chineseName,
                   model.chineseLanguage,
                   model.languageDescription);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark headerAndFooter

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30, 30)];
    contentView.backgroundColor = RGBA(237, 242, 253, 1);
    [view addSubview:contentView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = Font(12);
    titleLabel.textColor = RGBA(83, 83, 83, 1);
    titleLabel.text = @"使用您当前的位置";
    
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.image = [UIImage imageNamed:@"nation_icon"];
    
    [contentView addSubview:imgView];
    [contentView addSubview:titleLabel];
    
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentView).offset(3);
        make.left.mas_equalTo(contentView).offset(6);
        make.bottom.mas_equalTo(contentView).offset(-3);
        make.width.mas_equalTo(24);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentView).offset(9);
        make.left.mas_equalTo(imgView.mas_right).offset(10);
        make.bottom.mas_equalTo(contentView).offset(-9);
        make.height.mas_equalTo(12);
    }];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UITableViewHeaderFooterView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
