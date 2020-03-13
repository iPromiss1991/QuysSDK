//
//  QuysAdSplashApi.h
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysBaseNetworkApi.h"

NS_ASSUME_NONNULL_BEGIN
///插屏广告
@interface QuysAdSplashApi : QuysBaseNetworkApi
@property (nonatomic,strong) NSString *businessID;
@property (nonatomic,strong) NSString *bussinessKey;
@end

NS_ASSUME_NONNULL_END
