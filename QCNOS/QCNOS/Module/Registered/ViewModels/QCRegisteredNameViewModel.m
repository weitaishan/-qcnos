//
//  QCRegisteredNameViewModel.m
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/7.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCRegisteredNameViewModel.h"

@interface QCRegisteredNameViewModel ()

@property (nonatomic, assign) QCRegisteredType type;

@property (nonatomic, assign) QCRegisteredSource source;

@end

@implementation QCRegisteredNameViewModel

- (instancetype)initWithSoure:(QCRegisteredSource)source
                         type:(QCRegisteredType)type {
    self = [super init];
    if (self) {
        self.source = source;
        self.type = type;
    }
    return self;
}

- (void)loadTextFieldTopDataBlock:(void(^)(NSString *text, NSString *placeholder))block {
    NSString *text = nil;
    NSString *placeholder = nil;
    switch (self.source) {
        case QCRegisteredSourceNone:
        {
            if (self.type == QCRegisteredTypePassword) {
                text = @"设置授权密码:";
                placeholder = @"请输入授权密码";
            }
            else {
                text = @"请输入真实姓名全名：";
                placeholder = @"请输入本人的真实姓名";
            }
        }
            break;
            
        case QCRegisteredSourceReset:
        {
            if (self.type == QCRegisteredTypePassword) {
                text = @"设置授权密码：";
                placeholder = @"请输入授权密码";
            }
            else {
                text = @"校验归属主体:";
                placeholder = @"请输入本人的真实姓名";
            }
        }
            break;
            
        case QCRegisteredSourceCompany:
        {
            if (self.type == QCRegisteredTypePassword) {
                text = @"";
                placeholder = @"";
            }
            else {
                text = @"请设定商业节点归属的法人实体：";
                placeholder = @"以注册证件的全称信息为准";
            }
        }
            break;
    }
    block(text, placeholder);
}

- (void)loadTextFieldBottomDataBlock:(void(^)(NSString *text, NSString *placeholder))block {
    NSString *text = nil;
    NSString *placeholder = nil;
    switch (self.source) {
        case QCRegisteredSourceNone:
        {
            if (self.type == QCRegisteredTypePassword) {
                text = @"验证授权密码：";
                placeholder = @"请再次输入授权密码";
            }
            else {
                text = @"中国用户默认为公民身份号码：";
                placeholder = @"请输入本人的有效证件号码";
            }
        }
            break;
            
        case QCRegisteredSourceReset:
        {
            if (self.type == QCRegisteredTypePassword) {
                text = @"验证授权密码：";
                placeholder = @"请再次输入授权密码";
            }
            else {
                text = @"校验证件号码:";
                placeholder = @"请输入本人的有效证件号码";
            }
        }
            break;
            
        case QCRegisteredSourceCompany:
        {
            if (self.type == QCRegisteredTypePassword) {
                text = @"";
                placeholder = @"";
            }
            else {
                text = @"中国法人实体默认为统一社会信用代码：";
                placeholder = @"请输入在有效期内证件号码";
            }
        }
            break;
    }
    block(text, placeholder);
}

@end
