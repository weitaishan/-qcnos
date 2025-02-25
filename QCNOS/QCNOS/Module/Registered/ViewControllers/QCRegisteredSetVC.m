//
//  QCRegisteredSetVC.m
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/8/23.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCRegisteredSetVC.h"
#import "QCRegisteredSetCell.h"
#import "QCRegisteredPhoneVC.h"
#import "QCRegisteredModel.h"
#import "QCRegisteredValidationVC.h"
#import "QCCompanyModel.h"
#import "QCRegisteredNameVC.h"

@interface QCRegisteredSetVC () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation QCRegisteredSetVC

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
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadSubView];
}

- (void)loadSubView {
    [self.view addSubview:self.tableView];
  
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self.view);
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QCRegisteredSetCell"
                                               bundle:nil]
         forCellReuseIdentifier:@"QCRegisteredSetCell"];
}

#pragma mark UITableViewDelegate, UITableViewDataSource的回调方法

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 86;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.source == QCRegisteredSourceCompany) {
        return 3;
    }
    return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCRegisteredSetCell *cell =
    [tableView dequeueReusableCellWithIdentifier:@"QCRegisteredSetCell"
                                    forIndexPath:indexPath];
    switch (indexPath.row) {
        case 0:
        {
            if (self.source == QCRegisteredSourceNone) {
                [cell.cellSwitch setOn:self.model.pushStatus];
                cell.titleLabel.text = @"广告推送";
                cell.contentLabel.text = @"开启后，你的个人节点将允许接受广告推送，有机会赚取广告令牌，也可发布个人广告业务";
            }
            else {
                [cell.cellSwitch setOn:self.companyModel.bankStatus];
                cell.titleLabel.text = @"银行账号";
                cell.contentLabel.text = @"开启后，你的投资收益将自动汇入你的银行账号，你消费结算";
            }

            @weakify(self);
            [[[cell.cellSwitch rac_signalForControlEvents:UIControlEventValueChanged]
             takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
                @strongify(self);
                if (self.source == QCRegisteredSourceNone) {
                    self.model.pushStatus = !self.model.pushStatus;
                }
                else {
                    self.companyModel.bankStatus = !self.companyModel.bankStatus;
                }
                [self.tableView reloadRowsAtIndexPaths:@[indexPath]
                                      withRowAnimation:UITableViewRowAnimationAutomatic];
            }];
        }
            break;
        case 1:
        {
            if (self.source == QCRegisteredSourceNone) {
                [cell.cellSwitch setOn:self.model.gpsStatus];
                cell.titleLabel.text = @"地理位置";
                cell.contentLabel.text = @"开启后，系统将自动定位你的当前位置，为你推送共识订单";
            }
            else {
                [cell.cellSwitch setOn:self.companyModel.nodeStatus];
                cell.titleLabel.text = @"节点共识";
                cell.contentLabel.text = @"开启后，系统将自动定位你的当前位置，为你推送共识订单";
            }
           
            @weakify(self);
            [[[cell.cellSwitch rac_signalForControlEvents:UIControlEventValueChanged]
              takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
                @strongify(self);
                if (self.source == QCRegisteredSourceNone) {
                    self.model.gpsStatus = !self.model.gpsStatus;
                }
                else {
                    self.companyModel.nodeStatus = !self.companyModel.nodeStatus;
                }
                [self.tableView reloadRowsAtIndexPaths:@[indexPath]
                                      withRowAnimation:UITableViewRowAnimationAutomatic];
            }];
        }
            break;
        case 2:
        {
            if (self.source == QCRegisteredSourceNone) {
                [cell.cellSwitch setOn:self.model.bankStatus];
                cell.titleLabel.text = @"银行账号";
                cell.contentLabel.text = @"开启后，你的投资收益将自动汇入你的银行账号，你的消费结算将由第三方自动扣付";
            }
            else {
                [cell.cellSwitch setOn:self.companyModel.pushStatus];
                cell.titleLabel.text = @"记账推送";
                cell.contentLabel.text = @"开启后，系统将自动定位你的当前位置，为你推送共识订单";
            }
            
            @weakify(self);
            [[[cell.cellSwitch rac_signalForControlEvents:UIControlEventValueChanged]
              takeUntil:cell.rac_prepareForReuseSignal]
             subscribeNext:^(id x) {
                @strongify(self);
                 if (self.source == QCRegisteredSourceNone) {
                     self.model.bankStatus = !self.model.bankStatus;
                 }
                 else {
                     self.companyModel.pushStatus = !self.companyModel.pushStatus;
                 }
                [self.tableView reloadRowsAtIndexPaths:@[indexPath]
                                      withRowAnimation:UITableViewRowAnimationAutomatic];
            }];
        }
            break;
        case 3:
        {
            if (self.source == QCRegisteredSourceNone) {
                [cell.cellSwitch setOn:self.model.aiStatus];
            }
            else {
                [cell.cellSwitch setOn:self.companyModel.aiStatus];
            }
            cell.titleLabel.text = @"量芯AI助手";
            cell.contentLabel.text = @"开启后，量芯AI助手将为你提供便捷服务，你可以抢先体验量芯服务，并优先抢单记账";
            @weakify(self);
            [[[cell.cellSwitch rac_signalForControlEvents:UIControlEventValueChanged]
              takeUntil:cell.rac_prepareForReuseSignal]
             subscribeNext:^(id x) {
                @strongify(self);
                 if (self.source == QCRegisteredSourceNone) {
                     self.model.aiStatus = !self.model.aiStatus;
                 }
                 else {
                     self.companyModel.aiStatus = !self.companyModel.aiStatus;
                 }
                [self.tableView reloadRowsAtIndexPaths:@[indexPath]
                                      withRowAnimation:UITableViewRowAnimationAutomatic];
            }];
        }
            break;
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark headerAndFooter

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 125)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = Font(22);
    titleLabel.textColor = RGBA(52, 52, 52, 1);
    titleLabel.text = @"智能合约配置";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel *subLabel = [[UILabel alloc] init];
    subLabel.font = Font(12);
    subLabel.numberOfLines = 0;
    subLabel.textColor = RGBA(76, 76, 76, 1);
    subLabel.text = @"开启即代表你本人自动完全授权量芯AI助手为您的个人\
    节点设置智能合约及安全隐私策略，并提供相关服务";
    subLabel.textAlignment = NSTextAlignmentCenter;
    
    [view addSubview:titleLabel];
    [view addSubview:subLabel];

    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view).offset(30);
        make.left.mas_equalTo(view).offset(30);
        make.right.mas_equalTo(view).offset(-30);
        make.height.mas_equalTo(24);
    }];
    
    [subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(view).offset(30);
        make.right.mas_equalTo(view).offset(-30);
        make.height.mas_equalTo(35);
    }];
    
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 168)];
    view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = k_Color_Main_Navigation;
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 5.f;
    btn.titleLabel.font = Font(17);
    [btn setTitle:@"授权并确认" forState:0];
    @weakify(self);
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        if (self.source == QCRegisteredSourceNone) {
            QCRegisteredPhoneVC *VC = [[QCRegisteredPhoneVC alloc] init];
            VC.model = self.model;
            [self.navigationController pushViewController:VC animated:YES];
        }
        else {
            QCRegisteredNameVC *VC = [[QCRegisteredNameVC alloc] init];
            VC.type = QCRegisteredTypeInformation;
            VC.companyModel = self.companyModel;
            VC.source = self.source;
            [self.navigationController pushViewController:VC animated:YES];
        }
    }];
    
    UILabel *subLabel = [[UILabel alloc] init];
    subLabel.font = Font(10);
    subLabel.numberOfLines = 0;
    subLabel.textColor = RGBA(164, 164, 164, 1);
    subLabel.text = @"我已同意协议文字所述内容我已同意协议文字所述内容我已同意协议文字所述内容";
    subLabel.textAlignment = NSTextAlignmentCenter;
    
    [view addSubview:btn];
    [view addSubview:subLabel];
    
    [subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view).offset(15);
        make.left.mas_equalTo(view).offset(25);
        make.right.mas_equalTo(view).offset(-25);
        make.height.mas_equalTo(25);
    }];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(view).offset(-30);
        make.left.mas_equalTo(view).offset(100);
        make.right.mas_equalTo(view).offset(-100);
        make.height.mas_equalTo(44);
    }];

    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 168;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 160;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
