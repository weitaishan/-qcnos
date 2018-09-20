//
//  QCRegisteredHeader.h
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/8/30.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#ifndef QCRegisteredHeader_h
#define QCRegisteredHeader_h

typedef NS_ENUM(NSUInteger, QCRegisteredSource) {
    QCRegisteredSourceNone = 0,       //注册
    QCRegisteredSourceReset,          //重置密码
    QCRegisteredSourceCompany,        //企业注册
};

typedef NS_ENUM(NSUInteger, QCRegisteredType) {
    QCRegisteredTypePassword = 0,       //密码
    QCRegisteredTypeInformation,        //证件号码
    QCRegisteredTypeGender,             //性别
    QCRegisteredTypeNickname,           //昵称
};

//发送验证码的类型
typedef NS_ENUM(NSUInteger, QCMessageCodeType) {
    QCMessageCodeTypeRegistered = 0,   //注册
    QCMessageCodeTypeResetPassword,    //重置密码
    QCMessageCodeTypeWithdraw,         //提现
    QCMessageCodeTypeAddCompany,       //新增企业
};



#endif /* QCRegisteredHeader_h */
