//
//  QCAlertController.m
//  SheHui
//
//  Created by 谭川江 on 2018/5/21.
//  Copyright © 2018年 谭川江. All rights reserved.
//

#import "QCAlertController.h"

@implementation QCAlertController

+ (void)alertControllerWithNoDevelopShowViewController:(UIViewController *)VC {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                                                             message:@"该功能还在努力开发中"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *doneAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:doneAction];
    [VC presentViewController:alertController animated:YES completion:nil];
}

+ (void)alertControllerWithShowViewController:(UIViewController *)VC
                                      message:(NSString *)message
                                    doneBlock:(void(^)(void))doneBlock {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *doneAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (doneBlock) {
            doneBlock();
        }
    }];
    UIAlertAction *cancalAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancalAction];
    [alertController addAction:doneAction];
    [VC presentViewController:alertController animated:YES completion:nil];
}

+ (void)alertControllerWithShowViewController:(UIViewController *)VC
                                      message:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancalAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancalAction];
    [VC presentViewController:alertController animated:YES completion:nil];
}

+ (NSDate *)timestampToDate:(NSNumber *)time {
    return [NSDate dateWithTimeIntervalSince1970:[time doubleValue]];
}

+ (NSString *)timestampToYMDHM:(NSNumber *)time semantic:(BOOL)semantic {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (semantic) {
        [formatter setDateFormat:@"yy-MM-dd HH:mm"];
    }
    else {
        [formatter setDateFormat:@"yyyy-MM-dd"];
    }
    NSString *dateString = [formatter stringFromDate:[self timestampToDate:time]];
    return dateString;
}

@end
