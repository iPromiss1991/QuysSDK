//
//  QuysVideoPlayerView.m
//  quysAdvice
//
//  Created by quys on 2020/1/2.
//  Copyright © 2020 Quys. All rights reserved.
//

#import "QuysVideoPlayerView.h"
#import "QuysVidoePlayButtonView.h"

@interface QuysVideoPlayerView ()

@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) UILabel *speedTextLabel;//显示网速Label

@property (nonatomic, strong) id playbackObserver;
@property (nonatomic) BOOL buffered;//是否缓冲完毕
@property (nonatomic) BOOL isReplay;//是否重复播放
@property (nonatomic,assign) BOOL isPlayToEnd ;//!<是否播放至最后

@property (nonatomic,strong) QuysVidoePlayButtonView *playButtonView;

@end

@implementation QuysVideoPlayerView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self)
    {
        [self createUI];
    }
    return self;
    
}

- (void)createUI
{
    kWeakSelf(self)
    [self.layer addSublayer:self.playerLayer];
    QuysVidoePlayButtonView *playButtonView = [[QuysVidoePlayButtonView alloc]initWithFrame:self.bounds];
    playButtonView.center = self.center;
    playButtonView.quysAdviceClickPlayButtonBlockItem = ^(void) {
        [weakself playStatesChanged];
    };
    [self addSubview:playButtonView];
    self.playButtonView = playButtonView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.playButtonView.frame = self.bounds;;
}


#pragma mark - PrivateMethod

//(优化playStatesChanged方法)同时支持网络监测、播放暂停等功能
-(void)playStatesChanged
{
    kWeakSelf(self)
    QuysNetworkReachabilityStatus status = [QuysAdviceManager shareManager].networkReachabilityStatus;
    switch (status) {
        case QuysNetworkReachabilityStatusUnknown:
            
//            break;
        case QuysNetworkReachabilityStatusNotReachable:
            
//            break;
        case QuysNetworkReachabilityStatusReachableViaWWAN://
        {
            [[[QuysAdviceManager shareManager] dicMReplace] setObject:kStringFormat(@"%@",@"1") forKey:kVideoType];

            if (![QuysAdviceManager shareManager].playVideoWithoutWifi)
            {
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"使用流量播放" message:@"当前为非wifi连接" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"继续播放" style:UIAlertActionStyleDefault
                                                                         handler:^(UIAlertAction * action) {
                                                                             //响应事件
                    [QuysAdviceManager shareManager].playVideoWithoutWifi = YES;;
                                                        [weakself playVideo];
                                                                           }];
                   UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault
                                                                         handler:^(UIAlertAction * action) {
                                                                             //响应事件
                       [[NSNotificationCenter defaultCenter ] postNotificationName:kAVPlayerItemDidRemoveNotification object:nil];
                       [[NSNotificationCenter defaultCenter ] postNotificationName:kRemoveIncentiveBackgroundImageViewNotify object:nil];
                                                                           }];

                   [alertVC addAction:defaultAction];
                   [alertVC addAction:cancelAction];
                   [[UIViewController quys_findVisibleViewController:NSClassFromString(@"QuysIncentiveVideoWindow")] presentViewController:alertVC animated:YES completion:nil];
            }else
            {
                [self playVideo];
            }
        }
            break;
        case QuysNetworkReachabilityStatusReachableViaWiFi:
        {
            [self playVideo];
        }
            break;
            
        default:
            break;
    }
}


/// 播放视频
- (void)playVideo
{
    NSLog(@">>>%lf",CMTimeGetSeconds(self.player.currentItem.currentTime));
    if (self.player.rate)
    {
        [self.player pause];
        [self.playButtonView showView];
        if (self.quysAdviceSuspendCallBackBlockItem)
        {
            self.quysAdviceSuspendCallBackBlockItem();
        }
        [[[QuysAdviceManager shareManager] dicMReplace] setObject:kStringFormat(@"%lf",CMTimeGetSeconds(self.player.currentItem.currentTime)) forKey:kVideoEndTime];
    }else
    {
        [self.playButtonView hiddenView];
        if (!(CMTimeGetSeconds(self.player.currentItem.currentTime)  >= 0) )
        {
            [[[QuysAdviceManager shareManager] dicMReplace] setObject:kStringFormat(@"%f",0.0) forKey:kVideoBeginTime];
            [[[QuysAdviceManager shareManager] dicMReplace] setObject:kStringFormat(@"%@",@"1") forKey:kVideoIsFirstFrame];
            [[[QuysAdviceManager shareManager] dicMReplace] setObject:kStringFormat(@"%@",@"1") forKey:kVideoType];
        }else
        {
            [[[QuysAdviceManager shareManager] dicMReplace] setObject:kStringFormat(@"%lf",CMTimeGetSeconds(self.player.currentItem.currentTime)) forKey:kVideoBeginTime];
            [[[QuysAdviceManager shareManager] dicMReplace] setObject:kStringFormat(@"%@",@"0") forKey:kVideoIsFirstFrame];
            if (self.isReplay)
            {
                [[[QuysAdviceManager shareManager] dicMReplace] setObject:kStringFormat(@"%@",@"3") forKey:kVideoType];
                [self rerunPlayVideo];
                self.isReplay = NO;
            }else
            {
                [[[QuysAdviceManager shareManager] dicMReplace] setObject:kStringFormat(@"%@",@"2") forKey:kVideoType];
            }
            if (self.quysAdvicePlayagainCallBackBlockItem)
            {
                self.quysAdvicePlayagainCallBackBlockItem();
            }
        }
        [self.player play];
    }
}




#pragma mark - Time


/// 播放进度计算 & 回调
- (void)quys_progressCallback
{
    [[[QuysAdviceManager shareManager] dicMReplace] setObject:kStringFormat(@"%@",@"0") forKey:kVideoStatus];
    BOOL isNormalStatus = NO;
    NSTimeInterval totalTime = CMTimeGetSeconds(self.player.currentItem.duration);//总时长
    NSTimeInterval currentTime = CMTimeGetSeconds(self.player.currentItem.currentTime);//当前时间进度
    
    // 切换视频源时totalTime/currentTime的值会出现nan导致时间错乱
    if (!(totalTime >= 0) || !(currentTime >= 0))
    {
        totalTime = 0;
        currentTime = 0;
    }else
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [[[QuysAdviceManager shareManager] dicMReplace] setObject:kStringFormat(@"%lf",totalTime) forKey:kVideoTotalTime];
        });
        isNormalStatus = YES;
        if (currentTime == 0)
        {
            [self.playButtonView hiddenView];
        }
    }
    
    NSInteger totalMin = totalTime / 60;
    NSInteger totalSec = (NSInteger)totalTime % 60;
    NSString *totalTimeStr = [NSString stringWithFormat:@"%02ld:%02ld",totalMin,totalSec];
    self.totalTime = totalTimeStr;
    
    NSInteger currentMin = currentTime / 60;
    NSInteger currentSec = (NSInteger)currentTime % 60;
    NSString *currentTimeStr = [NSString stringWithFormat:@"%02ld:%02ld",currentMin,currentSec];
    self.currentTime = currentTimeStr;
//    NSLog(@"=============%@       %@",totalTimeStr,currentTimeStr);

    if ([self.delegate respondsToSelector:@selector(quys_videoPlay:isCorrectStatus:)])
    {
        [self.delegate quys_videoPlay:@{kAVPlayerItemTotalTime:[NSString stringWithFormat:@"%02ld:%02ld",totalMin,totalSec],kAVPlayerItemCurrentTime:[NSString stringWithFormat:@"%02ld:%02ld",currentMin,currentSec]} isCorrectStatus:isNormalStatus];
    }
}

#pragma mark - 观察者

- (void)vpc_playerRemoveNotification {
    // 移除通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(validatePlayer) name:kAVPlayerItemDidRemoveNotification object:nil];
}

- (void)vpc_playerItemAddNotification {
    // 播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(vpc_playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
}

-(void)vpc_playbackFinished:(NSNotification *)noti
{
    self.isReplay = YES;
    [self.player pause];
    [self.playButtonView showView];
    
}

- (void)vpc_addObserverToPlayerItem:(AVPlayerItem *)playerItem {
    // 监听播放状态
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    // 监听缓冲进度
    [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)vpc_playerItemRemoveNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
}

- (void)vpc_playerItemRemoveObserver {
    [self.player.currentItem removeObserver:self forKeyPath:@"status"];
    [self.player.currentItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"status"])
    {
        AVPlayerStatus status= [[change objectForKey:@"new"] intValue];
        if (status == AVPlayerStatusReadyToPlay)
        {
               [self playStatesChanged];

            if (self.quysAdviceLoadSucessCallBackBlockItem)
            {
                self.quysAdviceLoadSucessCallBackBlockItem();
            }
        }else if(status == AVPlayerStatusFailed)
        {
            [[[QuysAdviceManager shareManager] dicMReplace] setObject:kStringFormat(@"%@",@"2") forKey:kVideoStatus];
            if (self.quysAdviceLoadFailCallBackBlockItem)
            {
                NSError *error = [((AVPlayerItem*)object) error];
                self.quysAdviceLoadFailCallBackBlockItem(error);
            }
        }else
        {
            [[[QuysAdviceManager shareManager] dicMReplace] setObject:kStringFormat(@"%@",@"1g") forKey:kVideoStatus];
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"])
    {
        NSArray *array = self.player.currentItem.loadedTimeRanges;
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];//本次缓冲时间范围
        NSTimeInterval startSeconds = CMTimeGetSeconds(timeRange.start);//本次缓冲起始时间
        NSTimeInterval durationSeconds = CMTimeGetSeconds(timeRange.duration);//缓冲时间
        NSTimeInterval totalBuffer = startSeconds + durationSeconds;//缓冲总长度
        float totalTime = CMTimeGetSeconds(self.player.currentItem.duration);//视频总长度
        float progress = totalBuffer/totalTime;//缓冲进度
        //如果缓冲完了，拖动进度条不需要重新显示缓冲条
        if (!self.buffered)
        {
            if (progress == 1.0)
            {
                self.buffered = YES;
            }
            self.playProgress = progress;
        }
    }
}

- (void)validatePlayer
{
    [self.player removeTimeObserver:self.playbackObserver];
    [self vpc_playerItemRemoveObserver];
    [self.player replaceCurrentItemWithPlayerItem:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


//视频重播
-(void)rerunPlayVideo
{
    if (!self.player)
    {
        return;
        
    }
    CGFloat a = 0;
    NSInteger dragedSeconds = floorf(a);
    CMTime dragedCMTime = CMTimeMake(dragedSeconds, 1);
    [self.player seekToTime:dragedCMTime];
}

- (void)setMute
{
    if (self.player.volume == 0.0)
    {
        self.player.volume = 1.0;
        if (self.quysAdviceCloseMuteCallBackBlockItem)
        {
            self.quysAdviceCloseMuteCallBackBlockItem();
        }
    }else
    {
        self.player.volume = 0.0f;
        if (self.quysAdviceMuteCallBackBlockItem)
        {
            self.quysAdviceMuteCallBackBlockItem();
        }
    }
}


//根据：runtime消息传递机制，子类先找到function的selector，然后直接调用实现（覆盖了：父类以及父类的类别）
- (void)hlj_viewStatisticalCallBack
{
    
    if (self.quysAdviceStatisticalCallBackBlockItem)
    {
        self.quysAdviceStatisticalCallBackBlockItem();
    }
}


# pragma mark - Init
-(AVPlayer *)player{
    
    if (!_player) {
        _player = [[AVPlayer alloc] init];
    }
    return _player;
    
}

-(AVPlayerLayer *)playerLayer{
    
    if (!_playerLayer) {
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        _playerLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }
    return _playerLayer;
    
}


//设置播放地址
-(void)setUrlVideo:(NSString *)urlVideo{
    
    [self.player seekToTime:CMTimeMakeWithSeconds(0, NSEC_PER_SEC) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    __weak typeof(self) weakSelf = self;
          // 每秒回调一次
    self.isPlayToEnd = NO;
    self.playbackObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time) {
              NSTimeInterval totalTime = CMTimeGetSeconds(weakSelf.player.currentItem.duration);//总时长
              NSTimeInterval currentTime = time.value / time.timescale;//当前时间进度
              weakSelf.playProgress= currentTime / totalTime;
//        NSLog(@"%lf   %lf  %lf",currentTime,totalTime,floor(totalTime));

        if (currentTime >0 & totalTime > 0 & currentTime <= floor(totalTime ) & !weakSelf.isPlayToEnd)
        {
             [weakSelf quys_progressCallback];
            (currentTime == floor(totalTime))?(weakSelf.isPlayToEnd = YES):(weakSelf.isPlayToEnd = NO);
        }else
        {
            weakSelf.isPlayToEnd = NO;
        }
           }];
    if (self.quysAdvicePlayStartCallBackBlockItem)
    {
        self.quysAdvicePlayStartCallBackBlockItem();
    }
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:urlVideo]];
    [self vpc_addObserverToPlayerItem:item];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.player replaceCurrentItemWithPlayerItem:item];
        [self vpc_playerItemAddNotification];
        [self vpc_playerRemoveNotification];
    });
    
}



- (void)dealloc
{
    [self validatePlayer];
}

@end
