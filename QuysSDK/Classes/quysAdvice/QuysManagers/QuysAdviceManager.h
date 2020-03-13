//
//  QuysAdviceManager.h
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuysAdSplashService.h"
typedef NS_ENUM(NSInteger,QuysNetworkReachabilityStatus) {
    QuysNetworkReachabilityStatusUnknown          = -1,
    QuysNetworkReachabilityStatusNotReachable     = 0,
    QuysNetworkReachabilityStatusReachableViaWWAN = 1,
    QuysNetworkReachabilityStatusReachableViaWiFi = 2,
};
NS_ASSUME_NONNULL_BEGIN

@interface QuysAdviceManager : NSObject
@property (nonatomic,strong) NSMutableDictionary *dicMReplace;//!<需要“宏替换”的字符数组
@property (nonatomic,assign) BOOL loadAdviceEnable;//!< 是否可以加载广告
@property (nonatomic,assign) BOOL playVideoWithoutWifi;//!< 非wifi情况下自动播放视频


@property (nonatomic,strong) NSString *strUserAgent;//!<浏览器信息
@property (nonatomic,strong) NSString *strIPAddress;//!<ip信息

@property (nonatomic,assign) QuysNetworkReachabilityStatus networkReachabilityStatus;//!<  网络状态


+ (instancetype)shareManager;


/// 初始化设置（使用广告服务之前必须调用该方法）
- (void)configSettings;


/// 宏替换
/// @param strForReplace 待替换的字符串
- (NSString*)replaceSpecifiedString:(NSString*)strForReplace;
@end

NS_ASSUME_NONNULL_END
