
//
//  QuysAdviceOpeenScreenDelegate.h
//  quysAdvice
//
//  Created by quys on 2019/12/31.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysAdviceBaseDelegate.h"

NS_ASSUME_NONNULL_BEGIN

/// 开屏广告代理
@protocol QuysAdviceOpeenScreenDelegate <QuysAdviceBaseDelegate>


/// 视频播放开始
/// @param service 广告服务对象
- (void)quys_videoPlaystart:(QuysAdBaseService*)service;


/// 视频播放结束
/// @param service 广告服务对象
- (void)quys_videoPlayEnd:(QuysAdBaseService*)service;
@end

NS_ASSUME_NONNULL_END
