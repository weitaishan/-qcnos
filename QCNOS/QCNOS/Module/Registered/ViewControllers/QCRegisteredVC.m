//
//  QCRegisteredVC.m
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/8/29.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCRegisteredVC.h"
#import "QCRegisteredSetVC.h"
#import "QCLoginViewController.h"
#import "QCRegisteredModel.h"

@interface QCRegisteredVC ()

@property (weak, nonatomic) IBOutlet UIButton *registeredBtn;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation QCRegisteredVC

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    self.navigationController.navigationBar.tintColor = RGBA(52, 52, 52, 1);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.layer.cornerRadius = 22.f;
    self.loginBtn.backgroundColor = k_Color_Main_Navigation;
    self.registeredBtn.layer.masksToBounds = YES;
    self.registeredBtn.layer.cornerRadius = 22.f;
    self.registeredBtn.layer.borderWidth = 1.f;
    [self.registeredBtn setTitleColor:k_Color_Main_Navigation forState:0];
    self.registeredBtn.layer.borderColor = k_Color_Main_Navigation.CGColor;
}

- (IBAction)onCilckRegistered:(UIButton *)sender {
    QCRegisteredSetVC *VC = [[QCRegisteredSetVC alloc] init];
    VC.hidesBottomBarWhenPushed = YES;
    VC.model = [[QCRegisteredModel alloc] init];
    VC.source = QCRegisteredSourceNone;
    [self.navigationController pushViewController:VC
                                         animated:YES];
}

- (IBAction)onCilckLogin:(UIButton *)sender {
    QCLoginViewController *VC = [[QCLoginViewController alloc] init];
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC
                                         animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

@end
