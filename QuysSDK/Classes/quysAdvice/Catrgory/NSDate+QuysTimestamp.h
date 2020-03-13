//
//  NSDate+QuysTimestamp.h
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (QuysTimestamp) 

/// 获取当前时间戳 （以毫秒为单位）
+(NSString *)quys_getNowTimeTimestamp;

@end

NS_ASSUME_NONNULL_END
