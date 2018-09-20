//
//  QCNationModel.h
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/4.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QCNationModel : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *englishName;

@property (nonatomic, copy) NSString *chineseName;

@property (nonatomic, copy) NSString *englishFullName;

@property (nonatomic, copy) NSString *chineseFullName;

@property (nonatomic, copy) NSString *chineseLanguage;

@property (nonatomic, copy) NSString *englishLanguage;

@property (nonatomic, copy) NSString *languageDescription;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *mobileCode;

@end

/**
 "englishFullName": "People's Republic of China",
 "chineseFullName": "中华人民共和国",
 "chineseLanguage": "简体中文",
 "englishLanguage": "Simplified Chinese",
 "languageDescription": "简体中文",
 "code": "CHN",
 "nationalCode": "86"
 */
