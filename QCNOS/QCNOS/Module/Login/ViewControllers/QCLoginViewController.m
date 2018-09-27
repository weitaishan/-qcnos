//
//  QCLoginViewController.m
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/8/30.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCLoginViewController.h"
#import "QCRegisteredSetVC.h"
#import "QCResetViewController.h"
#import "QCLoginViewModel.h"
#import "QCResetModel.h"
#import "QCRegisteredModel.h"
#import "QCNationVC.h"

@interface QCLoginViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
//登录按钮
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
//注册按钮
@property (weak, nonatomic) IBOutlet UIButton *registeredBtn;
//重置密码
@property (weak, nonatomic) IBOutlet UIButton *resetBtn;

@end

@implementation QCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.loginBtn.backgroundColor = k_Color_Main_Navigation;
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.layer.cornerRadius = 5.f;
    [self.registeredBtn setTitleColor:k_Color_Text_Main forState:0];
    [self.resetBtn setTitleColor:k_Color_Text_Main forState:0];
    if (self.isDisableRegistered) {
        self.registeredBtn.userInteractionEnabled = NO;
        [self.registeredBtn setTitleColor:RGBA(240, 240, 240, 1) forState:0];
    }
    
    self.userNameTextField.textAlignment = NSTextAlignmentCenter;
    self.userNameTextField.delegate = self;
    [self.userNameTextField placeholderTextAlignmentCenter];
    
    self.passwordTextField.textAlignment = NSTextAlignmentCenter;
    self.passwordTextField.delegate = self;
    self.passwordTextField.secureTextEntry = YES;
    [self.passwordTextField placeholderTextAlignmentCenter];
}

#pragma mark -- 重置密码
- (IBAction)onCilckResetButton:(UIButton *)sender {
    QCResetViewController *VC = [[QCResetViewController alloc] init];
    VC.codeType = QCMessageCodeTypeResetPassword;
    VC.resetModel = [[QCResetModel alloc] init];
    [self.navigationController pushViewController:VC
                                         animated:YES];
}

#pragma mark -- 注册
- (IBAction)onCilckRegisteredButton:(UIButton *)sender {
    QCRegisteredSetVC *VC = [[QCRegisteredSetVC alloc] init];
    VC.model = [[QCRegisteredModel alloc] init];
    [self.navigationController pushViewController:VC
                                         animated:YES];
}

#pragma mark -- 登录
- (IBAction)onCilckLoginButton:(UIButton *)sender {
    if (self.userNameTextField.text.length == 0) {
        [YJProgressHUD showMessage:@"授权账号不能为空"];
        return;
    }
    
    if (self.passwordTextField.text.length == 0) {
        [YJProgressHUD showMessage:@"授权密码不能为空"];
        return;
    }
    
    [self loginRequest];
}

- (void)loginRequest {
    [YJProgressHUD showLoading:@"登录中..."];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"mobile"] = self.userNameTextField.text;
    params[@"password"] = self.passwordTextField.text;
    params[@"mobileCode"] = @"86";
    NSURLRequest *request = [NSURLRequest userLoginWithParameters:params];
    [QCURLSessionManager dataTaskWithRequest:request successBlock:^(id responseObject) {
        NSMutableDictionary *data = [responseObject[@"data"] mutableCopy];
        data[@"bankList"] = @{};
        //登录成功保存用户的相关信息
        [QCUserManager userManagerSaveUserDataWithDictionary:data];
        [YJProgressHUD showSuccess:@"登录成功"];
    } failBlock:^(QCError *error) {
        [YJProgressHUD showError:error.localizedDescription];
    }];
}

//选择地区码默认+86
- (IBAction)onCilckRegionButton:(UIButton *)sender {
    QCNationVC *nationVC = [[QCNationVC alloc] init];
    @weakify(self);
    nationVC.block = ^(NSString *mobileCode,
                       NSString *code,
                       NSString *chineseName,
                       NSString *chineseLanguage,
                       NSString *languageDescription) {
        @strongify(self);
        
    };
    [self.navigationController pushViewController:nationVC animated:YES];
}

#pragma mark -- textFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    textField.backgroundColor = RGBA(237, 242, 253, 1);
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    textField.backgroundColor = RGBA(247, 247, 247, 1);
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.navigationController.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
