//
//  QCRegisteredNameViewModel.h
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/7.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QCRegisteredHeader.h"

@interface QCRegisteredNameViewModel : NSObject

- (instancetype)initWithSoure:(QCRegisteredSource)source
                         type:(QCRegisteredType)type;

- (void)loadTextFieldTopDataBlock:(void(^)(NSString *text, NSString *placeholder))block;

- (void)loadTextFieldBottomDataBlock:(void(^)(NSString *text, NSString *placeholder))block;

@end
