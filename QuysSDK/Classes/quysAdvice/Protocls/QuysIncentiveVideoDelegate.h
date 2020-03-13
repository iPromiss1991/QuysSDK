//
//  QuysIncentiveVideoDelegate.h
//  quysAdvice
//
//  Created by quys on 2019/12/30.
//  Copyright © 2019 Quys. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
///激励视频广告协议
@protocol QuysIncentiveVideoDelegate <QuysAdviceBaseDelegate>

- (void)quys_IncentiveVideoLoadSuccess:(QuysAdBaseService*)service;
- (void)quys_IncentiveVideoLoadFail:(NSError *)error service:(QuysAdBaseService*)service;


- (void)quys_IncentiveVideoPlaystart:(QuysAdBaseService*)service;
- (void)quys_IncentiveVideoPlayEnd:(QuysAdBaseService*)service;

- (void)quys_IncentiveVideoSkip:(QuysAdBaseService*)service;

- (void)quys_IncentiveVideoMuteplay:(QuysAdBaseService*)service;
- (void)quys_IncentiveVideoUnMuteplay:(QuysAdBaseService*)service;

- (void)quys_IncentiveVideoSuspend:(QuysAdBaseService*)service;
- (void)quys_IncentiveVideoResume:(QuysAdBaseService*)service;

- (void)quys_IncentiveVideoPlayProgress:(NSInteger)progress service:(QuysAdBaseService*)service;


//尾帧
- (void)quys_endViewInterstitialOnExposure:(QuysAdBaseService*)service;

- (void)quys_endViewInterstitialOnClick:(CGPoint)cpClick service:(QuysAdBaseService*)service;

- (void)quys_endViewInterstitialOnAdClose:(QuysAdBaseService*)service;

@end

NS_ASSUME_NONNULL_END
