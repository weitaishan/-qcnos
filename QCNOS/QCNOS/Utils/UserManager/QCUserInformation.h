//
//  QCUsernformation.h
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/3.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import <Realm/Realm.h>

@interface QCUserInformation : RLMObject

@property (nonatomic) NSString *id;

@property (nonatomic) NSNumber<RLMInt> *createTime;

@property (nonatomic) NSString *walletCode; //钱包code

@property (nonatomic) NSString *nodeCode; //节点code

@property (nonatomic) NSString *mobile; //手机号码

@property (nonatomic) NSString *realName; //用户名称

@property (nonatomic) NSString *gender; //性别  @“MALE” 代表 男

@property (nonatomic) NSString *idNumber; //身份证号码

@property (nonatomic) NSString *idBackPhoto; //身份证背面照片

@property (nonatomic) NSString *idFrontPhoto; //身份证正面照片

@property (nonatomic) NSString *idAddress;

@property (nonatomic) NSString *status;

@property (nonatomic) NSString *provinceCode;

@property (nonatomic) NSString *provinceName;

@property (nonatomic) NSString *cityCode;

@property (nonatomic) NSString *cityName;

@property (nonatomic) NSString *regionCode;

@property (nonatomic) NSString *regionName;

@property (nonatomic) NSString *accessToken;

@property (nonatomic) BOOL nodeStatus; //

@property (nonatomic) BOOL gpsStatus; //定位服务

@property (nonatomic) BOOL shopStatus;

@property (nonatomic) BOOL bankStatus;  //银行账号

@property (nonatomic) BOOL pushStatus;  //广告推送

@property (nonatomic) BOOL aiStatus;    //AI助手

@end
