//
//  QCAlertController.h
//  SheHui
//
//  Created by 谭川江 on 2018/5/21.
//  Copyright © 2018年 谭川江. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QCAlertController : NSObject

+ (void)alertControllerWithNoDevelopShowViewController:(UIViewController *)VC;

+ (void)alertControllerWithShowViewController:(UIViewController *)VC
                                      message:(NSString *)message
                                    doneBlock:(void(^)(void))doneBlock;

+ (void)alertControllerWithShowViewController:(UIViewController *)VC
                                      message:(NSString *)message;

+ (NSString *)timestampToYMDHM:(NSNumber *)time semantic:(BOOL)semantic;

@end
