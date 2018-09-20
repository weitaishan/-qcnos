//
//  QCResetViewController.m
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/8/30.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCResetViewController.h"
#import "QCRegisteredValidationVC.h"
#import "QCResetModel.h"

@interface QCResetViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;

@end

@implementation QCResetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.doneBtn.layer.masksToBounds = YES;
    self.doneBtn.layer.cornerRadius = 5.f;
    self.phoneTextField.textAlignment = NSTextAlignmentCenter;
    self.phoneTextField.delegate = self;
    [self.phoneTextField placeholderTextAlignmentCenter];
}

- (IBAction)onCilckButton:(id)sender {
    if (self.phoneTextField.text.length == 0) {
        [YJProgressHUD showMessage:@"手机号码不能为空"];
        return;
    }
    [self sendCodeRequest];
}

- (void)sendCodeRequest {
    [YJProgressHUD showLoading:@"发送中..."];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"mobile"] = self.phoneTextField.text;
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
    NSURLRequest *request = [NSURLRequest messageSendCodeWithParameters:params];
    [QCURLSessionManager dataTaskWithRequest:request successBlock:^(id responseObject) {
        [YJProgressHUD showSuccess:@"短信发送成功"];
        self.resetModel.mobile = self.phoneTextField.text;
        QCRegisteredValidationVC *validationVC = [[QCRegisteredValidationVC alloc] init];
        validationVC.source = QCRegisteredSourceReset;
        validationVC.codeType = self.codeType;
        validationVC.resetModel = self.resetModel;
        [self.navigationController pushViewController:validationVC animated:YES];
    } failBlock:^(QCError *error) {
        [YJProgressHUD showError:error.localizedDescription];
    }];
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
