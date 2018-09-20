//
//  QCRegisteredNameVC.m
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/8/23.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCRegisteredNameVC.h"
#import "QCRegisteredSuccessVC.h"
#import "QCGenderView.h"
#import "QCRegisteredModel.h"
#import "QCResetModel.h"
#import "QCRegisteredNameViewModel.h"

@interface QCRegisteredNameVC () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UIButton *doneBtn;

@property (nonatomic, copy) NSString *password; //密码

@property (nonatomic, copy) NSString *validationPassword; //确认密码

@property (nonatomic, strong) QCRegisteredNameViewModel *viewModel;

@end

@implementation QCRegisteredNameVC

- (IBAction)onCilckButton:(id)sender {
    if ([self validationParams]) { //初步验证数据的正确性
        if (self.type == QCRegisteredTypeInformation &&
            self.source == QCRegisteredSourceNone) { //注册的时候需要验证身份证号码是否存在
            [self validationIdNumberRequest];
        }
        else {
            [self todealPushViewController];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.doneBtn.layer.masksToBounds = YES;
    self.doneBtn.layer.cornerRadius = 5.f;
    self.doneBtn.backgroundColor = k_Color_Main_Navigation;
    self.viewModel = [[QCRegisteredNameViewModel alloc] initWithSoure:self.source
                                                                 type:self.type];
    
    switch (self.type) {
        case QCRegisteredTypePassword:
            [self loadContentViewSubViewName];
            break;
        case QCRegisteredTypeInformation:
            [self loadContentViewSubViewNumber];
            break;
        case QCRegisteredTypeGender:
            [self loadContentViewSubViewGender];
            break;
        case QCRegisteredTypeNickname:
            [self loadContentViewSubViewNickname];
            break;
    }
}

- (void)loadContentViewSubViewName {
    switch (self.source) {
        case QCRegisteredSourceNone:
        {
            self.titleLabel.text = @"设置承载节点授权密码";
            self.contentLabel.text = @"请创建容易记住的密码请";
            [self.doneBtn setTitle:@"继续" forState:0];
        }
            break;
            
        case QCRegisteredSourceReset:
        {
            self.titleLabel.text = @"重置承接节点授权密码";
            self.contentLabel.text = @"新的授权密码";
            [self.doneBtn setTitle:@"继续" forState:0];
        }
            break;
            
        case QCRegisteredSourceCompany:
            
            break;
    }
    [self loadContentTextFieldSubViews];
}

- (void)loadContentViewSubViewNumber {
    switch (self.source) {
        case QCRegisteredSourceNone:
        {
            self.titleLabel.text = @"节点归属主体确认";
            self.contentLabel.text = @"输入有效证件号码";
            [self.doneBtn setTitle:@"继续" forState:0];
        }
            break;
            
        case QCRegisteredSourceReset:
        {
            self.titleLabel.text = @"验证承载节点归属主体";
            self.contentLabel.text = @"";
            [self.doneBtn setTitle:@"继续" forState:0];
        }
            break;
            
        case QCRegisteredSourceCompany:
        {
            self.titleLabel.text = @"验证承载节点归属主体";
            self.contentLabel.text = @"";
            [self.doneBtn setTitle:@"继续" forState:0];
        }
            break;
    }
    [self loadContentTextFieldSubViews];
}

- (void)loadContentViewSubViewGender {
    self.titleLabel.text = @"节点归属主体确认";
    self.contentLabel.text = @"请选择主体性别";
    [self.doneBtn setTitle:@"继续" forState:0];
    [self loadContentViewWithGenderSubViews];
}

- (void)loadContentViewSubViewNickname {
    switch (self.source) {
        case QCRegisteredSourceNone:
        {
            self.titleLabel.text = @"为您的承载节点设置个性化信息";
            self.contentLabel.text = @"上传头像设置昵称可有效降低您的个人隐私泄露风险";
            [self.doneBtn setTitle:@"继续" forState:0];
        }
            break;
            
        case QCRegisteredSourceReset:
            break;
            
        case QCRegisteredSourceCompany:
        {
            self.titleLabel.text = @"商业节点所属法人的个性化信息";
            self.contentLabel.text = @"上传法人标识及简称将有助于提高品牌曝光度";
            [self.doneBtn setTitle:@"继续" forState:0];
        }
            break;
    }
   
    [self loadContentSubViews];
}

#pragma mark -- 加载contentView的视图
- (void)loadContentViewWithGenderSubViews {
    QCGenderView *manView = [[QCGenderView alloc] initWtihType:QCGenderTypeMen
                                                        select:NO];
    
    
    QCGenderView *view = [[QCGenderView alloc] initWtihType:QCGenderTypeWomen
                                                     select:YES];
    UITapGestureRecognizer *manTap = [[UITapGestureRecognizer alloc] init];
    manTap.numberOfTapsRequired = 1;
    [manView addGestureRecognizer:manTap];
    [manTap.rac_gestureSignal subscribeNext:^(id x) {
        [manView genderViewSelect];
        [view genderViewNone];
        self.model.gender = @"MALE";
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    tap.numberOfTapsRequired = 1;
    [view addGestureRecognizer:tap];
    [tap.rac_gestureSignal subscribeNext:^(id x) {
        [view genderViewSelect];
        [manView genderViewNone];
        self.model.gender = @"FEMALE";
    }];
    
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = RGBA(210, 210, 210, 1);
    
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.font = Font(11);
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.textColor = RGBA(255, 140, 24, 1);
    textLabel.text = @"性别选择后不可更改";
    
    [self.contentView addSubviews:@[manView, view, line, textLabel]];
    
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(0);
        make.right.mas_equalTo(self.contentView).offset(0);
        make.height.mas_equalTo(12);
        make.bottom.mas_equalTo(self.contentView).offset(-30);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(0);
        make.right.mas_equalTo(self.contentView).offset(0);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(textLabel.mas_top).offset(-10);
    }];
    
    [manView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(65);
        make.top.mas_equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(80);
        make.bottom.mas_equalTo(line.mas_top).offset(-10);
    }];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).offset(-75);
        make.top.mas_equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(80);
        make.bottom.mas_equalTo(line.mas_top).offset(-10);
    }];

}

- (void)loadContentTextFieldSubViews {
    __block NSString *topText = @"";
    __block NSString *topPlaceholder = @"";
    [self.viewModel loadTextFieldTopDataBlock:^(NSString *text, NSString *placeholder) {
        topText = text;
        topPlaceholder = placeholder;
    }];
    UIView *topView = [self loadTextFieldViewWithText:topText
                                          placeholder:topPlaceholder
                                           textSignal:^(id x) {
                                               [self textfieldNameTopWithString:x];
                                           }];
    
    __block NSString *bottomText = @"";
    __block NSString *bottomPlaceholder = @"";
    [self.viewModel loadTextFieldBottomDataBlock:^(NSString *text, NSString *placeholder) {
        bottomText = text;
        bottomPlaceholder = placeholder;
    }];
    
    UIView *bottomView = [self loadTextFieldViewWithText:bottomText
                                             placeholder:bottomPlaceholder
                                              textSignal:^(id x) {
                                                  [self textfieldNameBottomWithString:x];
                                              }];
    
    UILabel *label = [[UILabel alloc] init];
    label.font = Font(11);
    label.textColor = RGBA(255, 140, 24, 1);
    label.textAlignment = NSTextAlignmentCenter;
    
    if (self.type == QCRegisteredTypePassword) {
        label.text = @"密码不能过于简单";
    }
    else {
        label.text = @"您的个人隐私信息将收到量芯隐私保护";
    }
    
    [self.contentView addSubviews:@[topView, bottomView, label]];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(70);
        make.top.mas_equalTo(self.contentView).offset(30);
    }];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(70);
        make.top.mas_equalTo(topView.mas_bottom).offset(25);
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(13);
        make.top.mas_equalTo(bottomView.mas_bottom).offset(10);
    }];
}

- (UIView *)loadTextFieldViewWithText:(NSString *)text
                          placeholder:(NSString *)placeholder
                           textSignal:(void(^)(id x))textSignal {
    UIView *view = [[UIView alloc] init];
    UITextField *textField = [[UITextField alloc] init];
    textField.backgroundColor = RGBA(247, 247, 247, 1);
    textField.delegate = self;
    textField.textAlignment = NSTextAlignmentCenter;
    textField.font = Font(13);
    textField.textColor = RGBA(52, 52, 52, 1);
    textField.placeholder = placeholder;
    [textField placeholderTextAlignmentCenter];

    [[textField rac_textSignal] subscribeNext:^(id x) {
        textSignal(x);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.font = Font(12);
    label.textColor = RGBA(145, 145, 145, 1);
    label.text = text;
    
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = RGBA(229, 229, 229, 1);
    
    [view addSubviews:@[label, textField, line]];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(view);
        make.height.mas_equalTo(12);
        make.top.mas_equalTo(view).offset(10);
    }];
    
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(view);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(label.mas_bottom).offset(10);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(view);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(textField.mas_bottom).offset(5);
    }];
    
    return view;
}

- (void)loadContentSubViews {
    UITextField *textField = [[UITextField alloc] init];
    textField.backgroundColor = RGBA(247, 247, 247, 1);
    textField.font = Font(13);
    textField.textAlignment = NSTextAlignmentCenter;
    textField.textColor = RGBA(52, 52, 52, 1);
    textField.delegate = self;

    @weakify(self);
    [[textField rac_textSignal] subscribeNext:^(id x) {
        @strongify(self);
        self.model.nickName = x;
        if (self.model.nickName.length == 0) {
            [self.doneBtn setTitle:@"跳过" forState:0];
        }
        else {
            [self.doneBtn setTitle:@"继续" forState:0];
        }
    }];
    
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = RGBA(210, 210, 210, 1);
    
    textField.placeholder = @"设置节点昵称，最多12个汉字";
    [textField placeholderTextAlignmentCenter];
    
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.image = [UIImage imageNamed:@"registered_nickname"];
    imgView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [imgView addGestureRecognizer:tap];
    
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        @strongify(self);
        [self selectAndUploadHeaderImageView];
    }];
    
    [self.contentView addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(5);
        make.height.width.mas_equalTo(72);
        make.centerX.mas_equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:textField];
    [self.contentView addSubview:line];
    
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(10);
        make.right.mas_equalTo(self.contentView).offset(-10);
        make.height.mas_equalTo(30);
        make.bottom.mas_equalTo(self.contentView).offset(-56);
    }];

    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textField.mas_bottom).offset(6);
        make.left.mas_equalTo(self.contentView).offset(10);
        make.right.mas_equalTo(self.contentView).offset(-10);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark -- 数据处理
- (void)textfieldNameTopWithString:(NSString *)string {
    if (self.type == QCRegisteredTypePassword) {
        self.password = string;
    }
    else {
        switch (self.source) {
            case QCRegisteredSourceNone:
                self.model.realName = string;
                break;
            case QCRegisteredSourceReset:
                self.resetModel.realName = string;
                break;
            case QCRegisteredSourceCompany:
                
                break;
        }
    }
}

- (void)textfieldNameBottomWithString:(NSString *)string {
    if (self.type == QCRegisteredTypePassword) {
        self.validationPassword = string;
    }
    else {
        switch (self.source) {
            case QCRegisteredSourceNone:
                self.model.idNumber = string;
                break;
            case QCRegisteredSourceReset:
                self.resetModel.idNumber = string;
                break;
            case QCRegisteredSourceCompany:
                
                break;
        }
    }
}

#pragma mark -- 选择图片并上传
- (void)selectAndUploadHeaderImageView {
    [QCImagePicker showImagePickerFromViewController:self
                                       allowsEditing:YES
                                        finishAction:^(UIImage *image) {
        if (image) {
            [self uploadHeaderImageViewRequestWithImage:image];
        }
        else {
            [YJProgressHUD showError:@"选择的图片为空"];
        }
    }];
}

- (void)uploadHeaderImageViewRequestWithImage:(UIImage *)image {
    [YJProgressHUD showLoading:@"上传中..."];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"fileData"] = image;
    if (self.source == QCRegisteredSourceCompany) { //商业注册的时候就是上传logo
        params[@"type"] = @"logoPhoto";
    }
    else {
        params[@"type"] = @"headPhoto";
    }
    NSURLRequest *request = [NSURLRequest uploadHeaderImageWithParameters:params fileName:@"fileData"];
    [QCURLSessionManager dataTaskWithRequest:request successBlock:^(id responseObject) {
        NSLog(@"%@", responseObject);
        [YJProgressHUD showMessage:@"上传成功"];
    } failBlock:^(QCError *error) {
        [YJProgressHUD showError:error.localizedDescription];
    }];
}

#pragma mark -- 验证数据
- (BOOL)validationParams {
    if (self.type == QCRegisteredTypePassword) {
        if (self.password.length == 0) {
            [YJProgressHUD showMessage:@"密码不能为空"];
            return NO;
        }
        if (![self.password isEqualToString:self.validationPassword]) {
            [YJProgressHUD showMessage:@"密码不相同"];
            return NO;
        }
        if (self.source == QCRegisteredSourceReset) {
            self.resetModel.password = self.password;
        }
        else {
            self.model.password = self.password;
        }
    }
    else if (self.type == QCRegisteredTypeInformation) {
        
        if (self.source == QCRegisteredSourceReset) {
            if (self.resetModel.realName.length == 0) {
                [YJProgressHUD showMessage:@"真实姓名不能为空"];
                return NO;
            }
            if (self.resetModel.idNumber.length == 0) {
                [YJProgressHUD showMessage:@"身份证号码不能为空"];
                return NO;
            }
        }
        else {
            if (self.model.realName.length == 0) {
                [YJProgressHUD showMessage:@"真实姓名不能为空"];
                return NO;
            }
            if (self.model.idNumber.length == 0) {
                [YJProgressHUD showMessage:@"身份证号码不能为空"];
                return NO;
            }
        }
    }
    return YES;
}

#pragma mark -- 处理页面的调整
- (void)todealPushViewController {
    switch (self.source) {
        case QCRegisteredSourceNone:
        {
            if (self.type == QCRegisteredTypeNickname) {
                QCRegisteredSuccessVC *VC = [[QCRegisteredSuccessVC alloc] init];
                VC.source = self.source;
                VC.model = self.model;
                [self.navigationController pushViewController:VC animated:YES];
                return;
            }
            QCRegisteredNameVC *VC = [[QCRegisteredNameVC alloc] init];
            VC.type = self.type + 1;
            VC.model = self.model;
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case QCRegisteredSourceReset:
        {
            if (self.type == QCRegisteredTypeInformation) {
                QCRegisteredNameVC *VC = [[QCRegisteredNameVC alloc] init];
                VC.type = QCRegisteredTypePassword;
                VC.source = self.source;
                VC.model = self.model;
                [self.navigationController pushViewController:VC animated:YES];
            }
            else if (self.type == QCRegisteredTypePassword) {
                QCRegisteredSuccessVC *VC = [[QCRegisteredSuccessVC alloc] init];
                VC.source = self.source;
                VC.resetModel = self.resetModel;
                [self.navigationController pushViewController:VC animated:YES];
                return;
            }
        }
            break;
        case QCRegisteredSourceCompany:
        {
            if (self.type == QCRegisteredTypeInformation) {
                QCRegisteredNameVC *VC = [[QCRegisteredNameVC alloc] init];
                VC.type = QCRegisteredTypeNickname;
                VC.source = self.source;
                VC.model = self.model;
                [self.navigationController pushViewController:VC animated:YES];
            }
            else if (self.type == QCRegisteredTypeNickname) {
                QCRegisteredSuccessVC *VC = [[QCRegisteredSuccessVC alloc] init];
                VC.source = self.source;
                VC.resetModel = self.resetModel;
                [self.navigationController pushViewController:VC animated:YES];
                return;
            }
        }
            break;
    }
}

- (void)validationIdNumberRequest {
    [YJProgressHUD showLoading:@"验证中..."];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"idNumber"] = self.model.idNumber;
    NSURLRequest *request = [NSURLRequest userIsExistIdNumberWithParameters:params];
    [QCURLSessionManager dataTaskWithRequest:request successBlock:^(id responseObject) {
        [YJProgressHUD hideHUD];
        [self todealPushViewController];
    } failBlock:^(QCError *error) {
        [YJProgressHUD showError:error.localizedDescription];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.navigationController.view endEditing:YES];
}

#pragma mark -- textField

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    textField.backgroundColor = RGBA(237, 242, 253, 1);
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    textField.backgroundColor = RGBA(247, 247, 247, 1);
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    
}

@end
