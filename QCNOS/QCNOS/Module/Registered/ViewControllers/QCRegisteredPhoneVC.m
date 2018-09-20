//
//  QCRegisteredPhoneVC.m
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/8/23.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCRegisteredPhoneVC.h"
#import "QCRegisteredValidationVC.h"
#import "QCRegisteredModel.h"
#import "QCNationVC.h"

@interface QCRegisteredPhoneVC () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *button;

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UILabel *nationLabel;

@property (weak, nonatomic) IBOutlet UIButton *emailBtn;

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@end

@implementation QCRegisteredPhoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.button.layer.masksToBounds = YES;
    self.button.layer.cornerRadius = 5.f;
    self.button.backgroundColor = k_Color_Main_Navigation;
    
    self.textField.textAlignment = NSTextAlignmentCenter;
    self.textField.delegate = self;
    [self.textField placeholderTextAlignmentCenter];
    
    @weakify(self);
    [[self.textField rac_textSignal] subscribeNext:^(NSString *number) {
        @strongify(self);
        self.model.mobile = number ?: @"";
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    self.nationLabel.userInteractionEnabled = YES;
    [self.nationLabel addGestureRecognizer:tap];
    
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        @strongify(self);
        QCNationVC *nationVC = [[QCNationVC alloc] init];
        @weakify(self);
        nationVC.block = ^(NSString *mobileCode,
                           NSString *code,
                           NSString *chineseName,
                           NSString *chineseLanguage,
                           NSString *languageDescription) {
            @strongify(self);
            self.nationLabel.text =
            [NSString stringWithFormat:@"%@\n%@", chineseName, chineseLanguage];
            self.numberLabel.text = [NSString stringWithFormat:@"+%@", mobileCode];
            self.model.languageDescription = languageDescription;
            self.model.nationCode = code;
            self.model.mobileCode = mobileCode;
            self.model.nationName = chineseName;
        };
        [self.navigationController pushViewController:nationVC animated:YES];
    }];
    
}

- (IBAction)onCilkcEmailButton:(UIButton *)sender {
    [YJProgressHUD showMessage:@"此功能暂未开放"];
}

- (IBAction)onCilckButton:(id)sender {
    if (self.textField.text.length == 0) {
        [YJProgressHUD showMessage:@"手机号码不能为空"];
        return;
    }
    [self validationPhoneRequest];
}

- (void)sendCodeRequest {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"mobile"] = self.textField.text;
    params[@"codeType"] = @"REGISTER"; //注册
    params[@"mobileCode"] = self.model.mobileCode;
    NSURLRequest *request = [NSURLRequest messageSendCodeWithParameters:params];
    [QCURLSessionManager dataTaskWithRequest:request successBlock:^(id responseObject) {
        [YJProgressHUD showSuccess:@"短信发送成功"];
        QCRegisteredValidationVC *validationVC = [[QCRegisteredValidationVC alloc] init];
        validationVC.model = self.model;
        validationVC.codeType = QCMessageCodeTypeRegistered;
        [self.navigationController pushViewController:validationVC animated:YES];
    } failBlock:^(QCError *error) {
        [YJProgressHUD showError:error.localizedDescription];
    }];
}

- (void)validationPhoneRequest {
    [YJProgressHUD showLoading:@"发送中..."];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"mobile"] = self.textField.text;
    params[@"mobileCode"] = self.model.mobileCode;
    NSURLRequest *request = [NSURLRequest userIsExistMobileWithParameters:params];
    [QCURLSessionManager dataTaskWithRequest:request successBlock:^(id responseObject) {
        [self sendCodeRequest];
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
