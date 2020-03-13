//
//  QuysVideoCoverView.h
//  quysAdvice
//
//  Created by quys on 2020/3/3.
//  Copyright © 2020 Quys. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^QuysAdviceVoiceEventBlock)(BOOL voiceEnable);
@interface QuysVideoCoverView : UIView
@property (nonatomic,assign) NSInteger showDuration;//!< 播放倒计时



@property (nonatomic,copy) QuysAdviceVoiceEventBlock quysAdviceVoiceEventBlockItem;
@property (nonatomic,copy) QuysAdviceCloseEventBlock quysAdviceCloseEventBlockItem;
@property (nonatomic,copy) QuysAdviceClickEventBlock quysAdviceClickEventBlockItem;
@property (nonatomic,copy) QuysAdviceStatisticalCallBackBlock quysAdviceStatisticalCallBackBlockItem;
@end

NS_ASSUME_NONNULL_END
