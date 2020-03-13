//
//  QuysAdSplashVM.m
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysIncentiveVideoVM.h"
#import "QuysIncentiveVideoWindow.h"
#import "QuysFullScreenReplaceView.h"
#import "QuysNavigationController.h"
#import "QuysWebViewController.h"
#import "QuysPictureViewController.h"
#import "QuysAppDownUrlApi.h"
#import "QuysDownAddressModel.h"
@interface QuysIncentiveVideoVM()
@property (nonatomic,strong) QuysIncentiveVideoDataModel *adModel;
@property (nonatomic,weak) id <QuysIncentiveVideoDelegate> delegate;
@property (nonatomic,assign) CGRect cgFrame;
@property (nonatomic,strong) UIView *adView;
@property (nonatomic,strong) QuysIncentiveVideoService *service;

@end



@implementation QuysIncentiveVideoVM
- (instancetype)initWithModel:(QuysIncentiveVideoDataModel*)model delegate:(id<QuysIncentiveVideoDelegate>)delegate frame:(CGRect)cgFrame  
{
    if (self = [super init])
    {
        self.delegate = delegate;
        [self packingModel:model frame:cgFrame];
    }
    return self;
}


#pragma mark - PrivateMethod

- (void)packingModel:(QuysIncentiveVideoDataModel*)model frame:(CGRect)cgFrame
{
    self.adModel = model;
    self.cgFrame = cgFrame;
    [self updateReplaceDictionary:kResponeAdWidth value:kStringFormat(@"%@",_adModel.videoWidth)];
    [self updateReplaceDictionary:kResponeAdHeight value:kStringFormat(@"%@",_adModel.videoHeight)];
    [self updateReplaceDictionary:kRealAdWidth value:kStringFormat(@"%f",cgFrame.size.width)];
    [self updateReplaceDictionary:kRealAdHeight value:kStringFormat(@"%f",cgFrame.size.height)];
    self.strImgUrl = model.icon;
    self.videoUrl = model.videoUrl;
    self.isClickable = model.isClickable;
}



- (void)updateReplaceDictionary:(NSString *)replaceKey value:(NSString *)replaceVlue
{
    [[[QuysAdviceManager shareManager] dicMReplace] setObject:replaceVlue forKey:replaceKey];
}

- (void)uploadServer:(NSArray*)uploadUrlArr
{
    [[QuysUploadApiTaskManager shareManager] addTaskUrls:uploadUrlArr];
}


#pragma mark - QuysIncentiveVideoDelegate

- (UIView *)createAdviceView
{
    kWeakSelf(self)
    QuysIncentiveVideoWindow *adView = [[QuysIncentiveVideoWindow alloc]initWithFrame:self.cgFrame viewModel:self];
    [adView hlj_setTrackTag:kStringFormat(@"%ld",[adView hash]) position:0 trackData:@{}];
    
    //点击事件
    adView.quysAdviceClickEventBlockItem = ^(CGPoint cp) {
        [weakself interstitialOnClick:cp];
        if ([weakself.delegate respondsToSelector:@selector(quys_interstitialOnClick:service:)])
        {
            [weakself.delegate quys_interstitialOnClick:cp service:(QuysAdBaseService*)weakself.service];
        }
    };
    
    //关闭事件
    adView.quysAdviceCloseEventBlockItem = ^{
        [self interstitialOnInterrupt];
        if ([weakself.delegate respondsToSelector:@selector(quys_interstitialOnAdClose:)])
        {
            [weakself.delegate quys_interstitialOnAdClose:(QuysAdBaseService*)weakself.service];
        }
    };
    
    //曝光事件
    adView.quysAdviceStatisticalCallBackBlockItem = ^{
        [weakself interstitialOnExposure];
        if ([weakself.delegate respondsToSelector:@selector(quys_interstitialOnExposure:)])
        {
            [weakself.delegate quys_interstitialOnExposure:(QuysAdBaseService*)weakself.service];
        }
    };
    
    //播放开始
    adView.quysAdvicePlayStartCallBackBlockItem = ^{
        if (weakself.adModel.playStartUploadEnable)
        {
            [weakself updateClientTimeStamp];
            [weakself uploadServer:weakself.adModel.reportVideoStartUrl];
            weakself.adModel.statisticsModel.playStart = YES;
        }
        if ([weakself.delegate respondsToSelector:@selector(quys_IncentiveVideoPlaystart:)])
        {
             [weakself.delegate quys_IncentiveVideoPlaystart:(QuysAdBaseService*)weakself.service];
        }
    };
    
    
    //播放完成（尾帧展示逻辑：部分）
    adView.quysAdvicePlayEndCallBackBlockItem = ^(QuysAdviceVideoEndShowType endType)
    {
        if (weakself.adModel.playEndUploadEnable)
        {
            [weakself updateClientTimeStamp];
            [weakself uploadServer:weakself.adModel.reportVideoEndUrl];
            weakself.adModel.statisticsModel.playEnd = YES;
        }
        if ([weakself.delegate respondsToSelector:@selector(quys_IncentiveVideoPlayEnd:)])
        {
             [weakself.delegate quys_IncentiveVideoPlayEnd:(QuysAdBaseService*)weakself.service];
        }
    };
    
    //播放进度
    adView.quysAdviceProgressEventBlockItem = ^(NSInteger progress)
    {
        [weakself updateClientTimeStamp];
        [weakself uploadProgressEvent:progress];
        if ([weakself.delegate respondsToSelector:@selector(quys_IncentiveVideoPlayProgress:service:)])
        {
             [weakself.delegate quys_IncentiveVideoPlayProgress:progress service:(QuysAdBaseService*)weakself.service];
        }
    };
    
    //静音
    adView.quysAdviceMuteCallBackBlockItem = ^{
        if (weakself.adModel.muteUploadEnable)
        {
            [weakself updateClientTimeStamp];
            [weakself uploadServer:weakself.adModel.reportVideoMuteUrl];
            weakself.adModel.statisticsModel.mute = YES;
        }
        if ([weakself.delegate respondsToSelector:@selector(quys_IncentiveVideoMuteplay:)])
        {
             [weakself.delegate quys_IncentiveVideoMuteplay:(QuysAdBaseService*)weakself.service];
        }
    };
    
    //关闭静音
    adView.quysAdviceCloseMuteCallBackBlockItem = ^{
        if (weakself.adModel.closeMuteUploadEnable)
        {
            [weakself updateClientTimeStamp];
            [weakself uploadServer:weakself.adModel.reportVideoUnMuteUrl];
            weakself.adModel.statisticsModel.closeMute = YES;
        }
        if ([weakself.delegate respondsToSelector:@selector(quys_IncentiveVideoUnMuteplay:)])
        {
             [weakself.delegate quys_IncentiveVideoUnMuteplay:(QuysAdBaseService*)weakself.service];
        }
    };
    
    //关闭尾帧
    adView.quysAdviceEndViewCloseEventBlockItem = ^
    {
        if (weakself.adModel.endViewClosedUploadEnable)
        {
            [weakself updateClientTimeStamp];
            [weakself uploadServer:weakself.adModel.reportLandingPageCloseUrl];
            weakself.adModel.statisticsModel.endViewClosed = YES;
        }
        if ([weakself.delegate respondsToSelector:@selector(quys_endViewInterstitialOnAdClose:)])
        {
             [weakself.delegate quys_endViewInterstitialOnAdClose:(QuysAdBaseService*)weakself.service];
        }
    };
    
    //尾帧点击
    adView.quysAdviceEndViewClickEventBlockItem = ^(CGPoint cp) {
            [weakself interstitialEndviewOnClick:cp];
      
        if ([weakself.delegate respondsToSelector:@selector(quys_endViewInterstitialOnClick:service:)])
        {
            [weakself.delegate quys_endViewInterstitialOnClick:cp service:(QuysAdBaseService*)weakself.service];
        }
    };
    
    
    //视频暂停
    adView.quysAdviceSuspendCallBackBlockItem = ^{
        if (weakself.adModel.suspendMuteUploadEnable)
        {
            [weakself updateClientTimeStamp];
            [weakself uploadServer:weakself.adModel.reportVideoPauseUrl];
            weakself.adModel.statisticsModel.suspend = YES;
        }
        if ([weakself.delegate respondsToSelector:@selector(quys_IncentiveVideoSuspend:)])
        {
             [weakself.delegate quys_IncentiveVideoSuspend:(QuysAdBaseService*)weakself.service];
        }
    };
    
    //视频再次播放
    adView.quysAdvicePlayagainCallBackBlockItem = ^{
        if (weakself.adModel.resumUploadEnable)
        {
            [weakself updateClientTimeStamp];
            [weakself uploadServer:weakself.adModel.reportVideoPauseUrl];
            weakself.adModel.statisticsModel.resume = YES;
        }
        if ([weakself.delegate respondsToSelector:@selector(quys_IncentiveVideoResume:)])
        {
             [weakself.delegate quys_IncentiveVideoResume:(QuysAdBaseService*)weakself.service];
        }
    };
    
    //尾帧曝光事件
    adView.quysAdviceEndViewStatisticalCallBackBlockItem = ^{
        [weakself interstitialOnExposureEndView];
        if ([weakself.delegate respondsToSelector:@selector(quys_endViewInterstitialOnExposure:)])
        {
            [weakself.delegate quys_endViewInterstitialOnExposure:(QuysAdBaseService*)weakself.service];
        }
    };
    
    //加载成功
    adView.quysAdviceLoadSucessCallBackBlockItem = ^{
        if (weakself.adModel.loadSucessUploadEnable)
        {
            [weakself updateClientTimeStamp];
            [weakself uploadServer:weakself.adModel.reportVideoPauseUrl];
            weakself.adModel.statisticsModel.loadSucess = YES;
        }
        if ([weakself.delegate respondsToSelector:@selector(quys_IncentiveVideoLoadSuccess:)])
        {
             [weakself.delegate quys_IncentiveVideoLoadSuccess:(QuysAdBaseService*)weakself.service];
        }
    };
    
    //加载失败
    adView.quysAdviceLoadFailCallBackBlockItem = ^(NSError * error) {
        if (weakself.adModel.loadFailUploadEnable)
        {
            [weakself updateClientTimeStamp];
            [weakself uploadServer:weakself.adModel.reportVideoPauseUrl];
            weakself.adModel.statisticsModel.loadFail = YES;
        }
        if ([weakself.delegate respondsToSelector:@selector(quys_IncentiveVideoLoadFail:service:)])
        {
            [weakself.delegate quys_IncentiveVideoLoadFail:error service:(QuysAdBaseService*)weakself.service];
        }
    };
    
    self.adView = adView;
    return adView;
    
}


#pragma mark - Event


/// 视频播放点击
/// @param cpClick 点击坐标
- (void)interstitialOnClick:(CGPoint)cpClick
{
    if ([self.adView isMemberOfClass:[QuysIncentiveVideoWindow class]])
    {
        /*点击事件优先级：
         1\deep:
         2\isDownLoadType？Y：fileUrl：landingPageUrl（判断是否.ipa）。
         */
        if (self.adModel.isDownLoadType)
        {
            if (self.adModel.clickPosition == 1)
            {
                [self getRealDownUrl:self.adModel.fileUrl point:cpClick];
            }else
            {
                NSString *strMacroReplace = [[QuysAdviceManager shareManager] replaceSpecifiedString:self.adModel.fileUrl];
                [self openUrl:strMacroReplace];
                [self updateClickAndUpload:cpClick];
            }
            
        }else
        {
            if ([self.adModel.landingPageUrl containsString:@"ipa"])
            {
                NSString *strMacroReplace = [[QuysAdviceManager shareManager] replaceSpecifiedString:self.adModel.landingPageUrl];
                [self openUrl:strMacroReplace];
                [self updateClickAndUpload:cpClick];
            }else
            {
                QuysWebViewController *webVC = [[QuysWebViewController alloc] initWithUrl:self.adModel.landingPageUrl];
                QuysIncentiveVideoWindow *window = (QuysIncentiveVideoWindow*)self.adView;
                QuysNavigationController *nav= (QuysNavigationController*)window.rootViewController;
                [nav pushViewController:webVC animated:YES];
                [self updateClickAndUpload:cpClick];
            }
        }
    }
}




- (void)updateClickAndUpload:(CGPoint)cpClick
{
    if (self.adModel.clickeUploadEnable)
    {
        NSString *strCpX = kStringFormat(@"%f",cpClick.x);
        NSString *strCpY = kStringFormat(@"%f",cpClick.y);
        //更新点击坐标
        [self updateReplaceDictionary:kClickInsideDownX value:strCpX];
        [self updateReplaceDictionary:kClickInsideDownY value:strCpY];
        
        [self updateReplaceDictionary:kClickUPX value:strCpX];
        [self updateReplaceDictionary:kClickUPY value:strCpY];
        self.adModel.statisticsModel.clicked = YES;
        [self uploadServer:self.adModel.reportVideoClickUrl];
    }
}


/// 尾帧点击
/// @param cpClick 点击坐标
- (void)interstitialEndviewOnClick:(CGPoint)cpClick
{
    if ([self.adView isMemberOfClass:[QuysIncentiveVideoWindow class]])
    {
        /*点击事件优先级：
         1\deep:
         2\isDownLoadType？Y：fileUrl：landingPageUrl（判断是否.ipa）。
         */
        if (self.adModel.isDownLoadType)
        {
            if (self.adModel.clickPosition == 1)
            {
                [self getRealDownUrl:self.adModel.fileUrl point:cpClick];
            }else
            {
                NSString *strMacroReplace = [[QuysAdviceManager shareManager] replaceSpecifiedString:self.adModel.fileUrl];
                [self openUrl:strMacroReplace];
                [self updateClickAndUpload:cpClick];
            }
            
        }else
        {
            if ([self.adModel.landingPageUrl containsString:@"ipa"])
            {
                NSString *strMacroReplace = [[QuysAdviceManager shareManager] replaceSpecifiedString:self.adModel.landingPageUrl];
                [self openUrl:strMacroReplace];
                [self updateClickAndUpload:cpClick];
            }else
            {
                QuysWebViewController *webVC = [[QuysWebViewController alloc] initWithUrl:self.adModel.landingPageUrl];
                QuysIncentiveVideoWindow *window = (QuysIncentiveVideoWindow*)self.adView;
                QuysNavigationController *nav= (QuysNavigationController*)window.rootViewController;
                [nav pushViewController:webVC animated:YES];
                [self updateClickAndUpload:cpClick];
            }
        }
    }
}




- (void)updateEndviewClickAndUpload:(CGPoint)cpClick
{
    if (self.adModel.endViewClickeUploadEnable)
    {
        NSString *strCpX = kStringFormat(@"%f",cpClick.x);
        NSString *strCpY = kStringFormat(@"%f",cpClick.y);
        //更新点击坐标
        [self updateReplaceDictionary:kClickInsideDownX value:strCpX];
        [self updateReplaceDictionary:kClickInsideDownY value:strCpY];
        
        [self updateReplaceDictionary:kClickUPX value:strCpX];
        [self updateReplaceDictionary:kClickUPY value:strCpY];
        self.adModel.statisticsModel.endViewClicked = YES;
        [self updateClientTimeStamp];
        [self uploadServer:self.adModel.reportLandingPageClickUrl];
    }
}


- (void)openUrl:(NSString*)strUrl
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strUrl]];
    
}
- (void)getRealDownUrl:(NSString*)strWebUrl  point:(CGPoint)cpClick
{
    kWeakSelf(self)
    strWebUrl = [[QuysAdviceManager shareManager] replaceSpecifiedString:strWebUrl];
    QuysAppDownUrlApi *api = [QuysAppDownUrlApi new];
    api.downUrl = strWebUrl;
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request)
     {
        if ( request.responseJSONObject[@"data"])
        {
            QuysDownAddressModel *model = [QuysDownAddressModel yy_modelWithJSON:request.responseJSONObject[@"data"]];
            if (!kISNullString(model.dstlink))
            {
                [weakself openUrl:model.dstlink];
            }
            
            if (!kISNullString(model.clickid))
            {
                [weakself openUrl:model.dstlink];
                [weakself updateReplaceDictionary:kClickClickID value:model.clickid];
                [weakself updateClickAndUpload:cpClick];
            }
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

-(void)interstitialOnExposure
{
    if (self.adModel.exposuredUploadEnable)
    {
        [self updateReplaceDictionary:kRealAdWidth value:kStringFormat(@"%f",self.adView.frame.size.width)];
        [self updateReplaceDictionary:kRealAdHeight value:kStringFormat(@"%f",self.adView.frame.size.height)];
        [self updateReplaceDictionary:kClientTimeStamp value:[NSDate quys_getNowTimeTimestamp]];
        [self uploadServer:self.adModel.reportVideoShowUrl];
        self.adModel.statisticsModel.exposured = YES;
    }else
    {
    }
}

-(void)interstitialOnInterrupt
{
        [self updateReplaceDictionary:kClientTimeStamp value:[NSDate quys_getNowTimeTimestamp]];
        [self uploadServer:self.adModel.reportVideoInterruptUrl];
}


-(void)interstitialOnExposureEndView
{
    if (self.adModel.endViewExposuredUploadEnable)
    {
        [self updateReplaceDictionary:kRealAdWidth value:kStringFormat(@"%f",self.adView.frame.size.width)];
        [self updateReplaceDictionary:kRealAdHeight value:kStringFormat(@"%f",self.adView.frame.size.height)];
        [self updateReplaceDictionary:kClientTimeStamp value:[NSDate quys_getNowTimeTimestamp]];
        [self uploadServer:self.adModel.reportLandingPageShowUrl];
        self.adModel.statisticsModel.endViewExposured = YES;
    }else
    {
    }
}



- (void)uploadProgressEvent:(NSInteger)progress
{
    [self.adModel.videoCheckPointList enumerateObjectsUsingBlock:^(QuysVideoCheckPoint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.checkPoint >= 0 && obj.checkPoint <= 100 && obj.isReported == NO)
        {
            //checkPoint：可能是小数0～1，也可能是1～100
            if (obj.checkPoint <= 1)
            {
                if (ceilf(obj.checkPoint*100) == progress || obj.checkPoint == 1 )
                {
                    [[QuysUploadApiTaskManager shareManager] addTaskUrls:obj.urls];
                    obj.isReported = YES;
                }
            }else
            {
                if (obj.checkPoint == progress)
                {
                    [[QuysUploadApiTaskManager shareManager] addTaskUrls:obj.urls];
                    obj.isReported = YES;
                }
            }
        }
        NSLog(@"======%lf",obj.checkPoint);
    }];
}


- (void)updateClientTimeStamp
{
    [self updateReplaceDictionary:kClientTimeStamp value:[NSDate quys_getNowTimeTimestamp]];
}

- (void)removeBackgroundImageView
{
    for (id  subObj in [UIApplication sharedApplication].delegate.window.subviews)
    {
        if ([subObj isKindOfClass:[QuysFullScreenReplaceView class]])
        {
            [subObj removeFromSuperview];
        }
    }
}

- (void)validateWindow
{
    self.adView.hidden = YES;
    self.adView = nil;
}

-(NSString *)desc
{
    return self.adModel.desc;

}

-(NSString *)strTitle
{
    return self.adModel.title;
}
- (NSInteger)showDuration
{
    return [self.adModel.videoDuration integerValue];
}

-(QuysAdviceVideoEndShowType)videoEndShowType
{
    return self.adModel.videoEndShowType;
}

-(NSString *)videoEndShowValue
{
    return self.adModel.videoEndShowValue;
}

- (NSString *)videoAlternateEndShowValue
{
    return self.adModel.image;
}

- (void)dealloc
{
    
}


@end

