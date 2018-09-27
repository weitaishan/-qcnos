//
//  NSURLRequest+User.h
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/3.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLRequest (User)

/** 登录接口 */
+ (NSURLRequest *)userLoginWithParameters:(id)parameters;

/** 注册接口 */
+ (NSURLRequest *)userRegisterWithParameters:(id)parameters;

/** 重置密码接口 */
+ (NSURLRequest *)userResetPasswordWithParameters:(id)parameters;

/** 注册的时候验证手机号码是否存在接口 */
+ (NSURLRequest *)userIsExistMobileWithParameters:(id)parameters;

/** 注册的时候验证证件号码是否存在接口 */
+ (NSURLRequest *)userIsExistIdNumberWithParameters:(id)parameters;

/** 退出登录接口 */
+ (NSURLRequest *)userLogoutWithParameters:(id)parameters;

/** 获取个人所有信息 */
+ (NSURLRequest *)userGetAllInfoWithParameters:(id)parameters;
@end
