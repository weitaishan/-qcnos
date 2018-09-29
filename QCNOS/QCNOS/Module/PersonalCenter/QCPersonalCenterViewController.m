//
//  QCPersonalCenterViewController.m
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/8/29.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCPersonalCenterViewController.h"
#import "QCRegisteredVC.h"
#import "QCPersonCenterListCell.h"
#import "QCPersonCenterExitCell.h"
#import "QCRegisteredSetCell.h"
#import "QCUploadImageViewController.h"
#import "QCUserInformation.h"
#import "QCRegisteredSetVC.h"
#import "QCCompanyModel.h"
#import "QCDeployApplicationBlockViewController.h"
#import "QCDeployApplicationNodeViewController.h"
#import "QCRegisteredVC.h"

@interface QCPersonalCenterViewController ()

@property (nonatomic, strong) NSMutableArray* listArray;

@property (nonatomic, strong) NSMutableArray* titleArray;

@property (nonatomic, strong) QCUserInformation* userInfo;

@end

static NSString * const QCPersonCenterListCellId = @"QCPersonCenterListCellId";
static NSString * const QCPersonCenterExitCellId = @"QCPersonCenterExitCellId";
static NSString * const QCRegisteredSetCellId = @"QCRegisteredSetCell";


@implementation QCPersonalCenterViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([QCUserManager standardUserManager].user) {
        [self loadNavigationWithColor:k_Color_Main_Navigation];
        [self getAllInfoRequest];
        
        for (UIViewController *VC in self.childViewControllers) {
            [VC willMoveToParentViewController:nil];
            
            [VC.view removeFromSuperview];
            
            [VC removeFromParentViewController];
        }
    }
    else {
        [self loadNavigationWithColor:[UIColor whiteColor]];
        QCRegisteredVC *vc = [[QCRegisteredVC alloc] init];
        [self addChildViewController:vc];
        vc.view.frame = self.view.bounds;
        [self.view addSubview:vc.view];
        [vc didMoveToParentViewController:self];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (![QCUserManager standardUserManager].user) {
        [self loadNavigationWithColor:k_Color_Main_Navigation];
    }
}

/**
 获取个人所有信息
 */
- (void)getAllInfoRequest {
    self.userInfo = [QCUserManager standardUserManager].user;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSURLRequest *request = [NSURLRequest userGetAllInfoWithParameters:params];
    [QCURLSessionManager dataTaskWithRequest:request successBlock:^(id responseObject) {
        QCUserInformation *userInfo = [QCUserInformation yy_modelWithJSON:responseObject[@"data"]];
        
        if (userInfo) {
            
            self.userInfo = userInfo;

        }
        
    } failBlock:^(QCError *error) {
        [YJProgressHUD showError:error.localizedDescription];
    }];
}

- (void)loadNavigationWithColor:(UIColor *)color {
    CGSize imageSize = CGSizeMake(10, 10);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    
    [color set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.navigationController.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"承载";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addTableViewWithFrame:CGRectMake(0,0, SCREEN_WIDTH,SCREEN_HEIGHT - StatusBarAndNavigationBarHeight - TabbarHeight)];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([QCPersonCenterListCell class]) bundle:nil] forCellReuseIdentifier:QCPersonCenterListCellId];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([QCPersonCenterExitCell class]) bundle:nil] forCellReuseIdentifier:QCPersonCenterExitCellId];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([QCRegisteredSetCell class]) bundle:nil] forCellReuseIdentifier:QCRegisteredSetCellId];
}

- (void)onCilckRegisered {
    QCRegisteredVC *registered = [[QCRegisteredVC alloc] init];
    registered.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:registered animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDelegate/dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 6;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [@[@2,@2,@3,@1,@2,@1][section] integerValue];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSArray* contentArray = self.titleArray[indexPath.section][indexPath.row];
    
    
    if (indexPath.section == 5 ) {
        
        QCPersonCenterExitCell * cell = [tableView dequeueReusableCellWithIdentifier:QCPersonCenterExitCellId forIndexPath:indexPath];
        @weakify(self);
        [[[cell.exitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal]
         subscribeNext:^(id x) {
             @strongify(self);
            [QCAlertController alertControllerWithShowViewController:self
                                                             message:@"确定要退出登录？"
                                                           doneBlock:^{
                                                               [self logout];
                                                           }];
        }];
        return cell;
        
        
    }else if (indexPath.section == 2){
        
        QCRegisteredSetCell * cell = [tableView dequeueReusableCellWithIdentifier:QCRegisteredSetCellId forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = contentArray[0];
        cell.contentLabel.text = contentArray[1];
        cell.cellSwitch.on = [contentArray[2] integerValue];
        
        return cell;
        
    }
    
    QCPersonCenterListCell * cell = [tableView dequeueReusableCellWithIdentifier:QCPersonCenterListCellId forIndexPath:indexPath];
    
    cell.lbTitle.text = contentArray[0];

    if ([contentArray.lastObject integerValue] == 1) {
        
        cell.rightTitle.hidden = YES;
        cell.rightImg.hidden = YES;
        cell.lbTitle.font = [UIFont systemFontOfSize:16];
        
        
    }else {
        
        cell.rightTitle.text = contentArray[1];

        cell.rightTitle.hidden = NO;
        cell.rightImg.hidden = NO;
        cell.lbTitle.font = [UIFont systemFontOfSize:12];

    }
    //    QCInvitaitionListModel* model = self.listArray[indexPath.row];
    //    cell.model = model;
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 5) {
        
        return 76;
        
    }else if (indexPath.section == 2){
        
        return 75;
    }
    
    return 36;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    
    return 10;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return CGFLOAT_MIN;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:{
            
            
        }
            
            break;
            
        case 1:{
            
            if (indexPath.row == 0) {
                
                QCDeployApplicationNodeViewController* vc = [[QCDeployApplicationNodeViewController alloc] init];
                
                vc.type = 1;
                
                vc.hidesBottomBarWhenPushed = YES;
                
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                QCDeployApplicationBlockViewController* vc = [[QCDeployApplicationBlockViewController alloc] init];
                
                vc.hidesBottomBarWhenPushed = YES;
                
                [self.navigationController pushViewController:vc animated:YES];
                
            }
        }
            
            break;
            
        case 2:{
            
            
        }
            
            break;
            
        case 3:{
        
        }
            
            break;
            
        case 4:{
            
            
        }
            
            break;
            
        case 5:
            break;
        default:
            break;
    }
    
   
}

- (void)logout {
    [YJProgressHUD showLoading:@"退出登录中"];
    NSURLRequest *request = [NSURLRequest userLogoutWithParameters:nil];
    [QCURLSessionManager dataTaskWithRequest:request successBlock:^(id responseObject) {
        [QCUserManager clearUserDatas];
        [YJProgressHUD showSuccess:@"退出登录成功"];
        QCRegisteredVC *vc = [[QCRegisteredVC alloc] init];
        [self addChildViewController:vc];
        vc.view.frame = self.view.bounds;
        [self.view addSubview:vc.view];
        [vc didMoveToParentViewController:self];
        [self loadNavigationWithColor:[UIColor whiteColor]];
    } failBlock:^(QCError *error) {
        [YJProgressHUD showError:error.localizedDescription];
    }];
}

#pragma mark - 懒加载
- (NSMutableArray *)listArray{
    
    if (!_listArray) {
        
        _listArray = @[].mutableCopy;
    }
    
    return _listArray;
    
}


-(NSMutableArray *)titleArray{
    
    if (!_titleArray) {
        
        _titleArray = @[@[@[@"自然人承载节点",@1],
                          @[@"陈小橙的橙", @"完善信息",@2]],
                        @[@[@"应用节点", @"12节",@2],
                          @[@"应用区块", @"23区",@2]],
                        @[@[@"银行账号", @"开启后，你的投资收益将自动汇入你的银行账号，你消费结算",@1,@3],
                          @[@"记账推送", @"开启后，系统将自动定位你的当前位置，为你推送共识订单",@0,@3],
                          @[@"银行账号", @"开启后，系统将自动定位你的当前位置，为你推送共识订单",@1,@3]],
                        @[@[@"承接节点验证授权管理", @"",@2]],
                        @[@[@"法律条款和隐私政策", @"",@2],
                          @[@"关于量芯", @"",@2]],
                        @[@[]],
                        ].mutableCopy;
    }
    
    return _titleArray;
    
}

@end
