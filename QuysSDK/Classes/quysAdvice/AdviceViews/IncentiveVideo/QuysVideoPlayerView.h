//
//  QuysVideoPlayerView.h
//  quysAdvice
//
//  Created by quys on 2020/1/2.
//  Copyright © 2020 Quys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>

#define kAVPlayerItemDidRemoveNotification @"kAVPlayerItemDidRemoveNotification"
#define kAVPlayerItemTotalTime @"kAVPlayerItemTotalTime"
#define kAVPlayerItemCurrentTime @"kAVPlayerItemCurrentTime"



NS_ASSUME_NONNULL_BEGIN

@protocol QuysVideoPlayerDelegate <NSObject>

-(void)quys_videoPlay:(NSDictionary*)playItemInfo isCorrectStatus:(BOOL)status;




@end

@interface QuysVideoPlayerView : UIView
@property (nonatomic, strong) AVPlayer *player;

@property (nonatomic, strong) NSString *urlVideo;
@property (nonatomic,assign) CGFloat playProgress;
@property (nonatomic,strong) NSString *totalTime;
@property (nonatomic,strong) NSString *currentTime;
@property (nonatomic,weak) id<QuysVideoPlayerDelegate> delegate;


@property (nonatomic,copy) QuysAdviceStatisticalCallBackBlock quysAdviceStatisticalCallBackBlockItem;
@property (nonatomic,copy) QuysAdvicePlayStartCallBackBlock quysAdvicePlayStartCallBackBlockItem;

@property (nonatomic,copy) QuysAdviceLoadSucessCallBackBlock quysAdviceLoadSucessCallBackBlockItem;
@property (nonatomic,copy) QuysAdviceLoadFailCallBackBlock quysAdviceLoadFailCallBackBlockItem;

@property (nonatomic,copy) QuysAdviceMuteCallBackBlock quysAdviceMuteCallBackBlockItem;
@property (nonatomic,copy) QuysAdviceCloseMuteCallBackBlock quysAdviceCloseMuteCallBackBlockItem;

@property (nonatomic,copy) QuysAdviceSuspendCallBackBlock quysAdviceSuspendCallBackBlockItem;
@property (nonatomic,copy) QuysAdvicePlayagainCallBackBlock quysAdvicePlayagainCallBackBlockItem;



- (void)setMute;

/// 播放、暂停
 -(void)playStatesChanged;


@end

NS_ASSUME_NONNULL_END
