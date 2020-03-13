//
//  NSDate+QuysTimestamp.m
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "NSDate+QuysTimestamp.h"

TT_FIX_CATEGORY_BUG(qys_QuysTimestamp)
@implementation NSDate (QuysTimestamp) 
+(NSString *)quys_getNowTimeTimestamp
{

    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式

    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)([datenow timeIntervalSince1970]*1000)];

    return timeSp;
}
@end
