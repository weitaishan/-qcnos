//
//  NSMutableURLRequest+Extension.m
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/3.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "NSMutableURLRequest+Extension.h"

@implementation NSMutableURLRequest (Extension)

- (NSMutableURLRequest *)authorizedURLRequest {
    QCUserManager *manager = [QCUserManager standardUserManager];
    NSString *token = manager.user.accessToken;
    if (token.length > 0) {
        [self addValue:token forHTTPHeaderField:@"accessToken"];
    }
    return self;
}

@end
