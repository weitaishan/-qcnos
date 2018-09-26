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

@interface QCPersonalCenterViewController ()

@property (nonatomic, strong) NSMutableArray* listArray;

@property (nonatomic, strong) NSMutableArray* titleArray;

@end

static NSString * const QCPersonCenterListCellId = @"QCPersonCenterListCellId";
static NSString * const QCPersonCenterExitCellId = @"QCPersonCenterExitCellId";
static NSString * const QCRegisteredSetCellId = @"QCRegisteredSetCell";


@implementation QCPersonalCenterViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadNavigationWithColor:k_Color_Main_Navigation];
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [self loadNavigationWithColor:[UIColor whiteColor]];
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
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);
    leftBtn.titleLabel.font = Font(15);
    [leftBtn setTitle:@"注册" forState:0];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:0];
    [leftBtn addTarget:self
                action:@selector(onCilckRegisered)
      forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    self.navigationItem.rightBarButtonItem = leftItem;
    
    
    [self addTableViewWithFrame:CGRectMake(0,0, SCREEN_WIDTH,SCREEN_HEIGHT - StatusBarAndNavigationBarHeight - TabbarHeight)];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([QCPersonCenterListCell class]) bundle:nil] forCellReuseIdentifier:QCPersonCenterListCellId];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([QCPersonCenterExitCell class]) bundle:nil] forCellReuseIdentifier:QCPersonCenterExitCellId];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([QCRegisteredSetCell class]) bundle:nil] forCellReuseIdentifier:QCRegisteredSetCellId];
    
}

- (void)onCilckRegisered {
    [self uploadHeaderImageViewRequestWithImage:[UIImage imageNamed:@"logo"]];
    QCRegisteredVC *registered = [[QCRegisteredVC alloc] init];
    registered.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:registered animated:YES];
}

- (void)uploadHeaderImageViewRequestWithImage:(UIImage *)image {
    //    [YJProgressHUD showLoading:@"上传中..."];
    //    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //    NSData *imageData = UIImageJPEGRepresentation(image, 0.1); //image为要上传的图片(UIImage)
    //    params[@"type"] = @"headPhoto";
    //
    //    NSURLRequest *request = [NSURLRequest uploadHeaderImageWithParameters:params
    //                                                                 fileName:@"fileData"];
    //    [QCURLSessionManager uploadFileWithFileData:imageData request:request successBlock:^(id responseObject) {
    //        NSLog(@"%@", responseObject);
    //        [YJProgressHUD showMessage:@"上传成功"];
    //    } failBlock:^(QCError *error) {
    //        [YJProgressHUD showError:error.localizedDescription];
    //
    //    }];
    
    //需要提交的数据
    NSData  *data_s = UIImageJPEGRepresentation(image, 0.8);
    NSDictionary  * dic = [NSMutableDictionary new];
    [dic setValue:@"headPhoto" forKey:@"type"];
    
    //配置AF
//    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
//    [manage.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    manage.requestSerializer = [AFHTTPRequestSerializer serializer];
//    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
//
//    [manage POST:@"http://43.254.45.72:8888/file/upload/uploadImg" parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        formatter.dateFormat = @"yyyyMMddHHmmss";
//        NSString *fileName = [NSString stringWithFormat:@"%@.png",
//                              [formatter stringFromDate:[NSDate date]]];
//        [formData appendPartWithFileData:data_s name:@"fileData" fileName:fileName mimeType:@"image/jpeg"];
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//        NSLog(@"%@", responseDic);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//    }];
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
    
    QCUploadImageViewController* vc = [[QCUploadImageViewController alloc] init];
    
    vc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
   
}
#pragma mark - 懒加载
-(NSMutableArray *)listArray{
    
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
