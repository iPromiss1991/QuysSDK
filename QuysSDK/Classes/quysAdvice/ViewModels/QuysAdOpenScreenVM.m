//
//  QuysAdSplashVM.m
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysAdOpenScreenVM.h"
#import "QuysAdviceModel.h"
#import "QuysOpenScreenWindow.h"
#import "QuysFullScreenReplaceView.h"
#import "QuysNavigationController.h"
#import "QuysWebViewController.h"
#import "QuysPictureViewController.h"
#import "QuysAppDownUrlApi.h"
#import "QuysDownAddressModel.h"
#import <AVFoundation/AVFoundation.h>
@interface QuysAdOpenScreenVM()
@property (nonatomic,strong) QuysAdviceModel *adModel;
@property (nonatomic,weak) id <QuysAdviceOpeenScreenDelegate> delegate;
@property (nonatomic,assign) CGRect cgFrame;
@property (nonatomic,strong) UIView *adView;
@property (nonatomic,strong) UIWindow *window;
@property (nonatomic,strong) QuysAdOpenScreenService *service;

@end



@implementation QuysAdOpenScreenVM
- (instancetype)initWithModel:(QuysAdviceModel*)model delegate:(id<QuysAdviceOpeenScreenDelegate>)delegate frame:(CGRect)cgFrame
{
    if (self = [super init])
    {
        self.delegate = delegate;
        self.closeWindowEnable = YES;
        [self packingModel:model frame:cgFrame];
    }
    return self;
}


#pragma mark - PrivateMethod

- (void)packingModel:(QuysAdviceModel*)model frame:(CGRect)cgFrame
{
    self.adModel = model;
    self.cgFrame = cgFrame;
    [self updateReplaceDictionary:kResponeAdWidth value:kStringFormat(@"%ld",_adModel.width)];
    [self updateReplaceDictionary:kResponeAdHeight value:kStringFormat(@"%ld",_adModel.height)];
    [self updateReplaceDictionary:kRealAdWidth value:kStringFormat(@"%f",cgFrame.size.width)];
    [self updateReplaceDictionary:kRealAdHeight value:kStringFormat(@"%f",cgFrame.size.height)];
    self.strImgUrl = model.imgUrl;
    self.materialUrl = model.materialUrl;
}



- (void)updateReplaceDictionary:(NSString *)replaceKey value:(NSString *)replaceVlue
{
    [[[QuysAdviceManager shareManager] dicMReplace] setObject:replaceVlue forKey:replaceKey];
}

- (void)uploadServer:(NSArray*)uploadUrlArr
{
    [[QuysUploadApiTaskManager shareManager] addTaskUrls:uploadUrlArr];
}


#pragma mark - QuysAdSplashDelegate

- (UIView *)createAdviceView
{
    if (self.adModel.creativeType == QuysAdviceCreativeTypeDefault || self.adModel.creativeType == QuysAdviceCreativeTypeVideo)
    {
        kWeakSelf(self)
        QuysOpenScreenWindow *adView = [[QuysOpenScreenWindow alloc]initWithFrame:self.cgFrame viewModel:self type:self.adModel.creativeType];
        [adView hlj_setTrackTag:kStringFormat(@"%ld",[adView hash]) position:0 trackData:@{}];
        
        //点击事件
        adView.quysAdviceClickEventBlockItem = ^(CGPoint cp) {
            weakself.closeWindowEnable = NO;
            [weakself interstitialOnClick:cp];
            if ([weakself.delegate respondsToSelector:@selector(quys_interstitialOnClick:service:)])
            {
                [weakself.delegate quys_interstitialOnClick:cp service:(QuysAdBaseService*)weakself.service];
            }
        };
        
        //关闭事件
        adView.quysAdviceCloseEventBlockItem = ^{
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
        self.adView = adView;
        return adView;
        
    }else
    {
        kWeakSelf(self)
        QuysOpenScreenWindow *adView = [[QuysOpenScreenWindow alloc]initWithFrame:self.cgFrame viewModel:self type:QuysAdviceCreativeTypeDefault];//QuysAdviceCreativeTypePictureOnly
        [adView hlj_setTrackTag:kStringFormat(@"%ld",[adView hash]) position:0 trackData:@{}];
        
        //点击事件
        adView.quysAdviceClickEventBlockItem = ^(CGPoint cp) {
            weakself.closeWindowEnable = NO;
            [weakself interstitialOnClick:cp];
            if ([weakself.delegate respondsToSelector:@selector(quys_interstitialOnClick:service:)])
            {
                [weakself.delegate quys_interstitialOnClick:cp service:(QuysAdBaseService*)weakself.service];
            }
        };
        
        //关闭事件
        adView.quysAdviceCloseEventBlockItem = ^{
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
        self.adView = adView;
        return adView;
        
    }
}


#pragma mark - Event

#pragma mark - QuysOpenScreenWindow

- (void)interstitialOnClick:(CGPoint)cpClick
{
    kWeakSelf(self)
    if ([self.adView isMemberOfClass:[QuysOpenScreenWindow class]])
    {
        switch (self.adModel.ctype) {
            case QuysAdviceActiveTypeHtmlSourceCode:
            {
                QuysWebViewController *webVC = [[QuysWebViewController alloc] initWithHtml:self.adModel.htmStr];
                UIViewController* rootVC = [UIViewController quys_findVisibleViewController:[QuysOpenScreenWindow class]] ;
                [rootVC quys_presentViewController:webVC animated:YES completion:^{
                    [weakself updateClickAndUpload:cpClick];
                }];
            }
                break;
            case QuysAdviceActiveTypeImageUrl:
            {
                //判断后缀是否.ipa==直接下载； 或者加载web
                if ([self.adModel.ldp containsString:@".ipa"])
                {
                    [self openUrl:self.adModel.ldp];
                }else
                {
                    QuysWebViewController *webVC = [[QuysWebViewController alloc] initWithUrl:self.adModel.ldp];
                    UIViewController* rootVC = [UIViewController quys_findVisibleViewController:[QuysOpenScreenWindow class]] ;
                    [rootVC quys_presentViewController:webVC animated:YES completion:^{
                    }];
                }
                [self updateClickAndUpload:cpClick];
            }
                break;
            case QuysAdviceActiveTypeHtmlLink:
            {
                QuysWebViewController *webVC = [[QuysWebViewController alloc] initWithHtml:self.adModel.htmStr];
                UIViewController* rootVC = [UIViewController quys_findVisibleViewController:[QuysOpenScreenWindow class]] ;
                [rootVC quys_presentViewController:webVC animated:YES completion:^{
                    [weakself updateClickAndUpload:cpClick];
                }];
            }
                break;
            case QuysAdviceActiveTypeDownAppAppstore:
            {
                [self openUrl:self.adModel.downUrl];
                [self updateClickAndUpload:cpClick];
            }
                break;
            case QuysAdviceActiveTypeDownAppAppstoreSecond:
            {
                [self openUrl:self.adModel.downUrl];
                [self updateClickAndUpload:cpClick];
            }
                break;
            case QuysAdviceActiveTypeDownAppWebUrl:
            {
                [self getRealDownUrl:self.adModel.downUrl point:cpClick];
            }
                break;
            default:
                break;
        }
    }
}


- (void)openUrl:(NSString*)strUrl
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strUrl]];
    
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
        [self uploadServer:self.adModel.clkTracking];
    }
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
        [self uploadServer:self.adModel.clkTracking];
        self.adModel.statisticsModel.exposured = YES;
    }else
    {
    }
}


- (void)validateWindow
{
    self.adView.hidden = YES;
    self.adView = nil;
}

- (NSString *)title
{
    if (_title == nil) {
        _title = self.adModel.title;
    }return _title;
}
- (NSInteger)showDuration
{
    if (self.adModel.creativeType == QuysAdviceCreativeTypeVideo)
    {
        NSInteger totalSecond = [self getVideoTimeByUrlString:self.adModel.materialUrl];
        return totalSecond <= 15?totalSecond:15;//quys_warning:视屏最长15s?
    }else
    {
        return self.adModel.showDuration <= 0?5:(self.adModel.showDuration <=5?self.adModel.showDuration:5);
    }
}

- (NSInteger)getVideoTimeByUrlString:(NSString*)urlString
{
    //计算视频长度  （秒）
    NSURL *url = [NSURL URLWithString:urlString];
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:opts];
    NSInteger totalSecond = urlAsset.duration.value / urlAsset.duration.timescale;
    NSLog(@"计算视频长度 = %ld",(long)totalSecond);
    return totalSecond;
}

- (void)dealloc
{
    
}


@end

