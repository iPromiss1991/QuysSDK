//
//  QuysMD5.h
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
///MD5加密
@interface QuysMD5 : NSObject
/**
 md5加密区分32、16位与大小写

 @param str 需要md5加密的字符串
 @param bateNum 填32即32位md5，16或16之外的即16位md5
 @param isLowercaseStr YES即小写，NO即大写
 @return md5加密后的字符串
 */
+ (NSString *)md5EncryptStr:(NSString *)str bateNum:(NSInteger)bateNum isLowercaseStr:(BOOL)isLowercaseStr;

@end

NS_ASSUME_NONNULL_END
