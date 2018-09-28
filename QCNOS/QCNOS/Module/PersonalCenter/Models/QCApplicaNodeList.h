//
//Created by ESJsonFormatForMac on 18/09/28.
//

#import <Foundation/Foundation.h>

@class QCApplicaNodeListData;
@interface QCApplicaNodeList : NSObject

@property (nonatomic, copy) NSString *message;

@property (nonatomic, strong) NSArray<QCApplicaNodeListData *> *data;

@property (nonatomic, assign) NSInteger code;

@end
@interface QCApplicaNodeListData : QCBaseModel

@property (nonatomic, copy) NSString *provinceName;

@property (nonatomic, copy) NSString *regionName;

@property (nonatomic, copy) NSString *ownerMobile;

@property (nonatomic, copy) NSString *bankStatus;

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, copy) NSString *regionCode;

@property (nonatomic, copy) NSString *creditCode;

@property (nonatomic, copy) NSString *aiStatus;

@property (nonatomic, copy) NSString *hasShop;

@property (nonatomic, copy) NSString *cityCode;

@property (nonatomic, copy) NSString *logoPhoto;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *type3;

@property (nonatomic, copy) NSString *registeredStatus;

@property (nonatomic, copy) NSString *bankList;

@property (nonatomic, copy) NSString *type1;

@property (nonatomic, copy) NSString *updateId;

@property (nonatomic, copy) NSString *scope;

@property (nonatomic, copy) NSString *provinceCode;

@property (nonatomic, copy) NSString *nationName;

@property (nonatomic, copy) NSString *walletCode;

@property (nonatomic, copy) NSString *createId;

@property (nonatomic, copy) NSString *nodeCode;

@property (nonatomic, copy) NSString *updateTime;

@property (nonatomic, copy) NSString *nodeStatus;

@property (nonatomic, copy) NSString *nationCode;

@property (nonatomic, copy) NSString *addressList;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *registeredOrgan;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *cityName;

@property (nonatomic, copy) NSString *createDate;

@property (nonatomic, copy) NSString *approvalDate;

@property (nonatomic, copy) NSString *ownerType;

@property (nonatomic, copy) NSString *cardPhoto;

@property (nonatomic, copy) NSString *type2;

@property (nonatomic, copy) NSString *pushStatus;

@property (nonatomic, assign) long long createTime;

@property (nonatomic, copy) NSString *ownerName;

@property (nonatomic, copy) NSString *nodeType;

@property (nonatomic, copy) NSString *shortName;

@property (nonatomic, copy) NSString *shopStatus;

@property (nonatomic, copy) NSString *isLong;

@property (nonatomic, copy) NSString *registeredCapital;

@property (nonatomic, copy) NSString *nodeName;

@property (nonatomic, copy) NSString *startDate;

@property (nonatomic, copy) NSString *gpsStatus;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *endDate;

@end

