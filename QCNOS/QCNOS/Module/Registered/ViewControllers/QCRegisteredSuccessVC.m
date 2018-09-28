//
//  QCRegisteredSuccessVC.m
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/8/23.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCRegisteredSuccessVC.h"
#import "QCRegisteredLoadView.h"
#import "QCLoginViewController.h"
#import "QCRegisteredModel.h"
#import "QCResetModel.h"
#import "QCCompanyModel.h"

@interface QCRegisteredSuccessVC ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *codeLabel;

@property (weak, nonatomic) IBOutlet UIButton *button;

@property (nonatomic, strong) QCRegisteredLoadView *rootView;

@end

@implementation QCRegisteredSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    
    self.button.layer.masksToBounds = YES;
    self.button.layer.cornerRadius = 5.f;
    self.button.backgroundColor = k_Color_Main_Navigation;

    self.rootView = [[QCRegisteredLoadView alloc] init];
    self.rootView.backgroundColor = [UIColor whiteColor];
    [self.navigationController.view addSubview:self.rootView];
    
    [self.rootView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.navigationController.view);
    }];
    switch (self.source) {
        case QCRegisteredSourceNone:
            [self userRegisterRequest];
            break;
        case QCRegisteredSourceReset:
            [self userResetPasswordRequest];
            break;
        case QCRegisteredSourceCompany:
            [self companyRegisteredRequest];
            break;
    }
}

- (void)userRegisterRequest {
    NSURLRequest *request = [NSURLRequest userRegisterWithParameters:[self.model yy_modelToJSONObject]];
    [QCURLSessionManager dataTaskWithRequest:request successBlock:^(id responseObject) {
        self.nameLabel.text = responseObject[@"data"][@"name"];
        self.codeLabel.text = responseObject[@"data"][@"nodeCode"];
        [self.rootView removeFromSuperview];
    } failBlock:^(QCError *error) {
        [self.navigationController popViewControllerAnimated:YES];
        [YJProgressHUD showError:error.localizedDescription];
    }];
}

- (void)userResetPasswordRequest {
    NSURLRequest *request = [NSURLRequest userResetPasswordWithParameters:[self.resetModel yy_modelToJSONObject]];
    [QCURLSessionManager dataTaskWithRequest:request successBlock:^(id responseObject) {
        self.nameLabel.text = responseObject[@"data"][@"name"];
        self.codeLabel.text = responseObject[@"data"][@"nodeCode"];
        [self.rootView removeFromSuperview];
    } failBlock:^(QCError *error) {
        [self.navigationController popViewControllerAnimated:YES];
        [YJProgressHUD showError:error.localizedDescription];
    }];
}

- (void)companyRegisteredRequest {
    NSURLRequest *request = [NSURLRequest companyAddWithParameters:[self.companyModel yy_modelToJSONObject]];
    [QCURLSessionManager dataTaskWithRequest:request successBlock:^(id responseObject) {
        self.nameLabel.text = responseObject[@"data"][@"name"];
        self.codeLabel.text = responseObject[@"data"][@"nodeCode"];
        [self.rootView removeFromSuperview];
    } failBlock:^(QCError *error) {
        [self.navigationController popViewControllerAnimated:YES];
        [YJProgressHUD showError:error.localizedDescription];
    }];
}

- (IBAction)backMainViewController:(UIButton *)sender {
    self.navigationController.navigationBar.hidden = NO;
    QCLoginViewController *loginVC = [[QCLoginViewController alloc] init];
    loginVC.isDisableRegistered = YES;
    NSMutableArray *navVCs =
    [[NSMutableArray alloc] initWithArray:self.navigationController.viewControllers];
    
    for (NSInteger i = navVCs.count - 1; i > 0; i--) {
        if (i > 0) {
            UIViewController *VC = navVCs[i];
            [navVCs removeObject:VC];
        }
    }
    self.navigationController.viewControllers = navVCs;
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
