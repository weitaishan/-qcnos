//
//  QCRegisteredValidationVC.m
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/8/23.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCRegisteredValidationVC.h"
#import "LQPasswordView.h"
#import "QCRegisteredNameVC.h"
#import "QCRegisteredModel.h"
#import "QCResetModel.h"

@interface QCRegisteredValidationVC ()

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (nonatomic, strong) UIButton *sendCode;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSInteger i;

@property (nonatomic, strong) LQPasswordView *inputView;

@end

@implementation QCRegisteredValidationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.phoneLabel.text = self.model.mobile;
    
    [self loadValidationView];

    [self runTimer];
    
    [self loadSubViews];
}

- (void)runTimer {
    _i = 60;
    self.timer =  [NSTimer scheduledTimerWithTimeInterval:1.0
                                               target:self
                                             selector:@selector(changeTime)
                                             userInfo:nil
                                              repeats:YES];
}

- (void)changeTime {
    _i--;
    if (_i <= 0) {
        [self.sendCode setTitle:@"重新发送" forState:0];
        [self clearTimer];
    }
    else {
        [self.sendCode setTitle:[NSString stringWithFormat:@"%zis", _i] forState:0];
    }
}

- (void)loadSubViews {
    UILabel *label = [[UILabel alloc] init];
    label.font = Font(12);
    label.textColor = RGBA(164, 164, 164, 1);
    label.text = @"4位数字";
    
    self.sendCode = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendCode.titleLabel.font = Font(12);
    [self.sendCode setTitle:[NSString stringWithFormat:@"%zis", _i] forState:0];
    [self.sendCode setTitleColor:k_Color_Text_Main forState:0];
    self.sendCode.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.sendCode.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    @weakify(self);
    [[self.sendCode rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self runTimer];
    }];
    
    [self.view addSubview:label];
    [self.view addSubview:self.sendCode];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(245);
        make.left.mas_equalTo(self.view).offset(40);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(13);
    }];
    
    [self.sendCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(245);
        make.right.mas_equalTo(self.view).offset(-40);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(13);
    }];
}

- (void)loadValidationView {
    
    self.inputView = [[LQPasswordView alloc] initWithFrame:
                      CGRectMake(40, 200,__kScreenWidth - 80, 40)];
    self.inputView.num = 4;
    self.inputView.lineViewColor = RGBA(210, 210, 210, 1);
    self.inputView.selectlineViewColor = RGBA(76, 129, 239, 1);
    self.inputView.lineColor = RGBA(210, 210, 210, 1);
    self.inputView.errorlineViewColor = RGBA(220, 20, 60, 1);
    
    @weakify(self);
    self.inputView.callBackBlock = ^(NSString *text) {
        @strongify(self);
        [self validationCodeRequestWithCode:text];
    };
    [self.inputView showPassword];
    [self.view addSubview:self.inputView];
}

- (void)validationCodeRequestWithCode:(NSString *)code {
    [YJProgressHUD showLoading:@"验证中..."];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.source == QCRegisteredSourceReset) {
        params[@"mobile"] = self.resetModel.mobile;
    }
    else {
        params[@"mobile"] = self.model.mobile;
    }
    params[@"mobileCode"] = self.model.mobileCode;
    switch (self.codeType) {
        case QCMessageCodeTypeRegistered:
            params[@"codeType"] = @"REGISTER"; //注册
            break;
        case QCMessageCodeTypeResetPassword:
            params[@"codeType"] = @"RESET_PASSWORD"; //重置密码
            break;
        case QCMessageCodeTypeWithdraw:
            params[@"codeType"] = @"WITHDRAW"; //提现
            break;
        case QCMessageCodeTypeAddCompany:
            params[@"codeType"] = @"ADD_COMPANY"; //新增企业
            break;
    }
    params[@"code"] = code;
    
    NSURLRequest *request = [NSURLRequest messageValidateCodeWithParameters:params];
    [QCURLSessionManager dataTaskWithRequest:request successBlock:^(id responseObject) {
        [YJProgressHUD showSuccess:@"验证成功"];
        QCRegisteredNameVC *VC = [[QCRegisteredNameVC alloc] init];
        if (self.source == QCRegisteredSourceNone) {
            VC.type = QCRegisteredTypePassword;
            self.model.code = code;
            VC.model = self.model;
        }
        else {
            VC.type = QCRegisteredTypeInformation;
            self.resetModel.code = code;
            VC.resetModel = self.resetModel;
        }
        VC.source = self.source;
        [self.navigationController pushViewController:VC animated:YES];
    } failBlock:^(QCError *error) {
        [self.inputView cleanPassword:nil];
        [YJProgressHUD showError:error.localizedDescription];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)clearTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)dealloc {
    [self clearTimer];
}

@end
