//
//  QCNationVC.h
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/4.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NationBlock)(NSString *nationalCode,
                           NSString *code,
                           NSString *chineseName,
                           NSString *chineseLanguage,
                           NSString *languageDescription);

@interface QCNationVC : UIViewController

@property (nonatomic, copy) NationBlock block;

@end
