//
//  NSDate+Util.h
//  DeviseHome
//
//  Created by 魏太山 on 16/12/6.
//  Copyright © 2016年 weitaishan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Util)

//通过时间获取一个字段，只能在我的当前项目里面使用
+(NSString *)stringFromCtStr:(NSInteger)created_at;

+(NSString *)stringFromActTime:(NSInteger)created_at;

+(NSString *)stringFromLiveTime:(NSInteger)startTime;

+(BOOL)isTimeToLive:(NSInteger)startTime;

+(NSString *)utcTimeToDataString;

+(BOOL)isTimeToCreateLive:(NSString *)startTime;
+(NSString *)dateToDateString:(NSDate *)date;

+ (NSInteger)cTimestampFromDate:(NSDate *)date;

+(NSInteger)cTimestampFromString:(NSString *)timeStr
                          format:(NSString *)format;
+ (NSString *)dateStrFromCstampTime:(NSInteger)timeStamp
                     withDateFormat:(NSString *)format;
@end
