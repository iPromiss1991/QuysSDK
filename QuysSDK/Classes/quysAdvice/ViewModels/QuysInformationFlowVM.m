//
//  QuysInformationFlowVM.m
//  quysAdvice
//
//  Created by quys on 2019/12/16.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysInformationFlowVM.h"
#import "QuysAdviceModel.h"

#import "QuysInformationFlowDefaultView.h"
#import "QuysInformationFlowMorePictureView.h"
#import "QuysInformationFlowSmallPictureView.h"

#import "QuysNavigationController.h"
#import "QuysWebViewController.h"
#import "QuysPictureViewController.h"
#import "QuysAppDownUrlApi.h"
#import "QuysDownAddressModel.h"
@interface QuysInformationFlowVM()
@property (nonatomic,strong) QuysAdviceModel *adModel;
@property (nonatomic,weak) id <QuysAdSplashDelegate> delegate;
@property (nonatomic,assign) CGRect cgFrame;
@property (nonatomic,strong) UIView *adView;
@property (nonatomic,strong) QuysInformationFlowService *service;

@end



@implementation QuysInformationFlowVM
- (instancetype)initWithModel:(QuysAdviceModel *)model delegate:( id<QuysAdSplashDelegate>)delegate frame:(CGRect)cgFrame service:(QuysInformationFlowService*)service
{
    if (self = [super init])
    {
        self.delegate = delegate;
        self.service = service;
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
}



- (void)updateReplaceDictionary:(NSString *)replaceKey value:(NSString *)replaceVlue
{
    [[[QuysAdviceManager shareManager] dicMReplace] setObject:replaceVlue forKey:replaceKey];
}

- (void)uploadServer:(NSArray*)uploadUrlArr
{
    [[QuysUploadApiTaskManager shareManager] addTaskUrls:uploadUrlArr];
}

- (UIView *)createAdviceView
{
    switch (self.adModel.creativeType) {
        case QuysAdviceCreativeTypeBigPicture:
        {
            kWeakSelf(self)
            QuysInformationFlowDefaultView *adView = [[QuysInformationFlowDefaultView alloc]initWithFrame:self.cgFrame viewModel:self];
            [adView hlj_setTrackTag:kStringFormat(@"%ld",[adView hash]) position:0 trackData:@{}];
            
            //点击事件
            adView.quysAdviceClickEventBlockItem = ^(CGPoint cp) {
                [weakself interstitialOnClick:cp];
                if ([weakself.delegate respondsToSelector:@selector(quys_interstitialOnClick:service:) ])
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
            break;
        case QuysAdviceCreativeTypeSmallPicture:
            {
                kWeakSelf(self)
                QuysInformationFlowSmallPictureView *adView = [[QuysInformationFlowSmallPictureView alloc]initWithFrame:self.cgFrame viewModel:self];
                [adView hlj_setTrackTag:kStringFormat(@"%ld",[adView hash]) position:0 trackData:@{}];
                
                //点击事件
                adView.quysAdviceClickEventBlockItem = ^(CGPoint cp) {
                    [weakself interstitialOnClick:cp];
                    if ([weakself.delegate respondsToSelector:@selector(quys_interstitialOnClick:service:)])
                    {
                        [weakself.delegate quys_interstitialOnClick:cp service:(QuysAdBaseService*)self.service];
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
            break;
        case QuysAdviceCreativeTypeMultiPicture:
            {
                kWeakSelf(self)
                QuysInformationFlowMorePictureView *adView = [[QuysInformationFlowMorePictureView alloc]initWithFrame:self.cgFrame viewModel:self];
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
        
            break;
           
        default:
            {
                kWeakSelf(self)
                QuysInformationFlowDefaultView *adView = [[QuysInformationFlowDefaultView alloc]initWithFrame:self.cgFrame viewModel:self];
                [adView hlj_setTrackTag:kStringFormat(@"%ld",[adView hash]) position:0 trackData:@{}];
                
                //点击事件
                adView.quysAdviceClickEventBlockItem = ^(CGPoint cp) {
                    [weakself interstitialOnClick:cp];
                    if ([weakself.delegate respondsToSelector:@selector(quys_interstitialOnClick:service:) ])
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
            break;
    }
}


#pragma mark - Event


- (void)interstitialOnClick:(CGPoint)cpClick
{
    kWeakSelf(self)
    if ([self.adView isMemberOfClass:[QuysInformationFlowDefaultView class]] ||[self.adView isMemberOfClass:[QuysInformationFlowSmallPictureView class]]||[self.adView isMemberOfClass:[QuysInformationFlowMorePictureView class]])
    {
        switch (self.adModel.ctype) {
            case QuysAdviceActiveTypeHtmlSourceCode:
            {
                QuysWebViewController *webVC = [[QuysWebViewController alloc] initWithHtml:self.adModel.htmStr];
                UIViewController* rootVC = [UIViewController quys_findVisibleViewController:[UIWindow class]] ;
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
                     UIViewController* rootVC = [UIViewController quys_findVisibleViewController:[UIWindow class]] ;
                     [rootVC quys_presentViewController:webVC animated:YES completion:^{
                     }];
                }
                [self updateClickAndUpload:cpClick];
            }
                break;
            case QuysAdviceActiveTypeHtmlLink:
            {
                QuysWebViewController *webVC = [[QuysWebViewController alloc] initWithHtml:self.adModel.htmStr];
                UIViewController* rootVC = [UIViewController quys_findVisibleViewController:[UIWindow class]] ;
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



#pragma mark - Init

-(NSString *)strTitle
{
    if (_strTitle == nil)
    {
        _strTitle = self.adModel.title;
    }return _strTitle;
}

- (NSString *)strImgUrl
{
    if (_strImgUrl == nil)
    {
        _strImgUrl = self.adModel.imgUrl;
    }return _strImgUrl;
}


- (NSArray *)arrImgUrl
{
    if (_arrImgUrl == nil)
    {
        _arrImgUrl = [NSArray array];
        if (self.adModel.imgUrlList.count == 1)
        {
            for (int i=0; i<3; i++)
            {
              _arrImgUrl =  [_arrImgUrl arrayByAddingObject:self.adModel.imgUrlList[0]];
            }
        }else if (self.adModel.imgUrlList.count == 2)
        {
            for (int i=0; i<2; i++)
            {
                _arrImgUrl =  [_arrImgUrl arrayByAddingObject:self.adModel.imgUrlList[i]];
            }
            _arrImgUrl =  [_arrImgUrl arrayByAddingObject:self.adModel.imgUrlList[arc4random()%1]];
        }else
        {
            for (int i=0; i<3; i++)
            {
              _arrImgUrl =  [_arrImgUrl arrayByAddingObject:self.adModel.imgUrlList[i]];
            }
        }
    }    return _arrImgUrl;
}



@end

