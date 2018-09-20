//
//  QCPersonalCenterViewController.m
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/8/29.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCPersonalCenterViewController.h"
#import "QCRegisteredVC.h"

@interface QCPersonalCenterViewController ()

@end

@implementation QCPersonalCenterViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadNavigationWithColor:k_Color_Main_Navigation];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self loadNavigationWithColor:[UIColor whiteColor]];
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
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    [manage.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    manage.requestSerializer = [AFHTTPRequestSerializer serializer];
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manage POST:@"http://43.254.45.72:8888/file/upload/uploadImg" parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *fileName = [NSString stringWithFormat:@"%@.png",
                              [formatter stringFromDate:[NSDate date]]];
        [formData appendPartWithFileData:data_s name:@"fileData" fileName:fileName mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@", responseDic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
