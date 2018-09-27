//
//  QCUsernformation.h
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/3.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import <Realm/Realm.h>

@interface QCUserInformationBankList : RLMObject

@property (nonatomic, copy) NSString *cardMobile;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *bankBranchName;

@property (nonatomic, copy) NSString *avow;

@property (nonatomic, assign) long long updateTime;

@property (nonatomic, copy) NSString *bankCityName;

@property (nonatomic, copy) NSString *cardEndTime;

@property (nonatomic, copy) NSString *isDefault;

@property (nonatomic, copy) NSString *bankProvinceName;

@property (nonatomic, copy) NSString *cardType;

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, copy) NSString *createId;

@property (nonatomic, copy) NSString *updateId;

@property (nonatomic, copy) NSString *bankName;

@property (nonatomic, copy) NSString *cardMobileCode;

@property (nonatomic, copy) NSString *bankProvinceCode;

@property (nonatomic, copy) NSString *bankCityCode;

@property (nonatomic, assign) long long createTime;

@property (nonatomic, copy) NSString *cardNo;

@property (nonatomic, copy) NSString *cardStartTime;

@property (nonatomic, copy) NSString *cardName;

@property (nonatomic, assign) NSInteger userId;

@end

RLM_ARRAY_TYPE(QCUserInformationBankList)


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

@property (nonatomic) RLMArray<QCUserInformationBankList *><QCUserInformationBankList>* bankList;    //银行列表

@end

RLM_ARRAY_TYPE(QCUserInformation)
