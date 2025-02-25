
//
//  QCUploadImageViewController.m
//  QCNOS
//
//  Created by 魏太山 on 2018/9/21.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCUploadImageViewController.h"
#import "QCUploadImgView.h"
#import "QCPersonSelectNodeHeaderCell.h"
#import "QCShopNameCell.h"
#import "MOFSPickerManager.h"

#define HEADER_HEIGHT ((SCREEN_WIDTH - 60) / 3.f)

@interface QCUploadImageViewController ()

@property (nonatomic, strong) NSMutableArray<UIImage *> *imgArr;

@property (nonatomic, strong) NSArray *assets;

@property (nonatomic, strong) QCSubmitButton* submitBtn;

@property (nonatomic, strong) NSMutableDictionary* jsonDic;

@end

static NSString * const QCPersonSelectNodeHeaderCellId = @"QCPersonSelectNodeHeaderCellId";

static NSString * const QCShopNameCellId = @"QCShopNameCellId";

@implementation QCUploadImageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    [self setBaseInfo];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setBaseInfo{
    
    self.navigationItem.title = @"上传图片";
    
    [self addTableViewWithGroupFrame:CGRectMake(0,0, SCREEN_WIDTH,SCREEN_HEIGHT - StatusBarAndNavigationBarHeight - TabbarHeight)];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([QCPersonSelectNodeHeaderCell class]) bundle:nil] forCellReuseIdentifier:QCPersonSelectNodeHeaderCellId];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([QCShopNameCell class]) bundle:nil] forCellReuseIdentifier:QCShopNameCellId];

    
    
    [self.view addSubview:self.submitBtn];
    MJWeakSelf;
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.bottom.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(44);
    }];
    
    [[self.submitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [self uploadImgs];
        
    }];
    
    self.imgArr = @[].mutableCopy;
    
    RAC(_submitBtn, userInteractionEnabled) = [[RACObserve(self, self.imgArr) merge:self.imgArr.rac_sequence.signal] map:^id(id value) {
        
        if (self.imgArr.count > 0) {
            
            _submitBtn.backgroundColor = [UIColor colorFromHexString:@"#497fef"];
        }else{
            
            _submitBtn.backgroundColor = [UIColor colorFromHexString:@"#cdcbcb"];

        }
        
        return @(self.imgArr.count > 0);
    }];
    
}

- (void)uploadImgs{
    
    [YJProgressHUD showLoading:@"上传中..."];
    [QCURLSessionManager uploadImageWithImages:self.imgArr imageType:QCUploadImageServerTypeShopPhoto progress:^(NSProgress * progress) {
        
        
        
    }success:^(NSURLSessionDataTask *task, id responseObject) {
        

        [self addShopWithImages:responseObject[@"data"]];
        
                                           
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        [YJProgressHUD showError:error.localizedDescription];
    }];
    
}

- (void)addShopWithImages:(NSString *)images{
    
    if ([self.jsonDic[@"name"] length] == 0) {
        
        [YJProgressHUD showMessage:@"请填写店铺名字"];
        return;
        
    }
    
    if ([self.jsonDic[@"address"] length] == 0) {
        
        [YJProgressHUD showMessage:@"请填写店铺详细地址"];

        return;
        
    }
    
    if ([self.jsonDic[@"regionName"] length] == 0) {
        
        [YJProgressHUD showMessage:@"请选择省市区"];
        
        return;
        
    }
    
    if ([self.jsonDic[@"companyId"] length] == 0) {
        
        [YJProgressHUD showMessage:@"没有公司Id"];
        
        return;
        
    }
    
    
    
    NSArray *imageArr = [images componentsSeparatedByString:@","];
    [self.jsonDic setObject:imageArr.firstObject forKey:@"logoPhoto"];
    [self.jsonDic setObject:imageArr.firstObject forKey:@"displayPhoto"];

    
    
    NSURLRequest *request = [NSURLRequest addShopWithParameters:self.jsonDic];
    [QCURLSessionManager dataTaskWithRequest:request successBlock:^(id responseObject) {
    
        
        
    } failBlock:^(QCError *error) {
        [YJProgressHUD showError:error.localizedDescription];
    }];
    
    

    
    
}
#pragma mark - UITableViewDelegate/dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        QCPersonSelectNodeHeaderCell * cell = [tableView dequeueReusableCellWithIdentifier:QCPersonSelectNodeHeaderCellId forIndexPath:indexPath];

        return cell;
    }
    
    QCShopNameCell * cell = [tableView dequeueReusableCellWithIdentifier:QCShopNameCellId forIndexPath:indexPath];
    
    [[[cell.lbName rac_textSignal] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
       
        [self.jsonDic setObject:x ? : @"" forKey:@"name"];

        
    }];
    
    [[[cell.lbAddress rac_textSignal] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
        
        [self.jsonDic setObject:x ? : @"" forKey:@"address"];

    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [cell.lbCity addGestureRecognizer:tap];
    
    @weakify(self);
    [[[tap rac_gestureSignal] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
        @strongify(self);
        
        [[MOFSPickerManager shareManger] showMOFSAddressPickerWithDefaultAddress:@"四川省-成都市-武侯区" numberOfComponents:3 title:@"请选择城市" cancelTitle:@"取消" commitTitle:@"确定" commitBlock:^(NSString *address, NSString *zipcode) {
            
            
            cell.lbCity.text = [address stringByReplacingOccurrencesOfString:@"-"withString:@" "];
            
            NSArray *addressCodeArr = [zipcode componentsSeparatedByString:@"-"];
            NSString* province = zipcode.length ? addressCodeArr[0] : @"";
            NSString* city = zipcode.length ? addressCodeArr[1] : @"";
            NSString* county = zipcode.length ? addressCodeArr[2] : @"";
            
            [self.jsonDic setObject:province forKey:@"provinceCode"];
            [self.jsonDic setObject:city forKey:@"provinceCode"];
            [self.jsonDic setObject:county forKey:@"regionCode"];
            [self.jsonDic setObject:@"CHN" forKey:@"nationCode"];

            
            
            NSArray *addressArr = [address componentsSeparatedByString:@"-"];
            NSString* provinceName = address.length ? addressArr[0] : @"";
            NSString* cityName = address.length ? addressArr[1] : @"";
            NSString* regionName = address.length ? addressArr[2] : @"";
            
            [self.jsonDic setObject:provinceName forKey:@"provinceName"];
            [self.jsonDic setObject:cityName forKey:@"cityName"];
            [self.jsonDic setObject:regionName forKey:@"regionName"];
            [self.jsonDic setObject:@"中国" forKey:@"nationName"];

            NSLog(@"jsonDic = %@",self.jsonDic);
            
        } cancelBlock:^{
            
            
        }];
    }];
    //    QCInvitaitionListModel* model = self.listArray[indexPath.row];
    //    cell.model = model;
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {

        return 73;
    }
    return 142;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 10;
    }
    CGFloat row =  (self.imgArr.count ) / 3 + 1;
    
    return HEADER_HEIGHT * row + row*10 + 10;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return CGFLOAT_MIN;
    
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView* view = [[UIView alloc] init];
    
    view.backgroundColor = [UIColor colorFromHexString:@"#f5f5f5"];
    
    if (section == 1) {

        QCUploadImgView* uploadImg = [[QCUploadImgView alloc] initWithImgArr:self.imgArr assets:self.assets isVideo:NO];
        
        [view addSubview:uploadImg];
        
        uploadImg.reloadBlock = ^(NSMutableArray *imgArr, NSArray *assets) {
            
            self.imgArr = imgArr;
            self.assets = assets;
            
            [self.tableView reloadData];
            
        };
        [uploadImg mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.left.bottom.right.equalTo(view);
            
        }];
        
    }
    
    
    return view;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma mark - 懒加载
//-(NSMutableArray<QCInvitaitionListModel *> *)listArray{
//
//    if (!_listArray) {
//
//        _listArray = @[].mutableCopy;
//    }
//
//    return _listArray;
//
//}

-(NSMutableDictionary *)jsonDic{
    
    if (!_jsonDic) {
        
        _jsonDic = @{}.mutableCopy;
        
        [_jsonDic setObject:@"2" forKey:@"type"];
        [_jsonDic setObject:[NSString stringWithFormat:@"%ld",self.companyId] forKey:@"companyId"];

    }
    
    return _jsonDic;
}


-(QCSubmitButton *)submitBtn{
    
    if (!_submitBtn) {
        
        _submitBtn = [[QCSubmitButton alloc] init];
        [_submitBtn setTitle:@"确认上传" forState:UIControlStateNormal];
        _submitBtn.backgroundColor = [UIColor colorFromHexString:@"#cdcbcb"];
        _submitBtn.userInteractionEnabled = NO;
        
    }
    return _submitBtn;
}
@end
