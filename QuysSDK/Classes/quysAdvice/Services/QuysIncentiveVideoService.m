//
//  QuysAdSplashService.m
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysIncentiveVideoService.h"
#import "QuysIncentiveVideoApi.h"
#import "QuysIncentiveVideoOutLayerDataModel.h"
#import "QuysIncentiveVideoWindow.h"
#import "QuysFullScreenReplaceView.h"
#import "QuysIncentiveVideoVM.h"
@interface QuysIncentiveVideoService()<YTKRequestDelegate>

@property (nonatomic,strong) NSString *businessID;
@property (nonatomic,strong) NSString *bussinessKey;
@property (nonatomic,assign) CGRect cgFrame;


@property (nonatomic,strong) QuysIncentiveVideoApi *api;


@end


@implementation QuysIncentiveVideoService
- (instancetype)initWithID:businessID key:bussinessKey cgRect:(CGRect)cgFrame  backgroundImage:(UIImage*)imgReplace eventDelegate:(nonnull id<QuysIncentiveVideoDelegate>)delegate 
{
    if (self = [super init])
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeBackgroundImageView) name:kRemoveIncentiveBackgroundImageViewNotify object:nil];
        self.businessID = businessID;
        self.bussinessKey = bussinessKey;
        self.delegate = delegate;
        self.cgFrame = cgFrame;
        [self config:imgReplace];
    }return self;
}

#pragma mark - PrivateMethod


- (void)config:(UIImage*)imgReplace
{
    //配置api 并请求数据
    QuysIncentiveVideoApi *api = [[QuysIncentiveVideoApi alloc]init];
    api.businessID = self.businessID;
    api.bussinessKey = self.bussinessKey;
    api.delegate = self;
    self.api = api;
    [self loadAdViewNow:imgReplace];
}


/// 开始加载视图
- (void)loadAdViewNow:(UIImage*)imgReplace
{
    if ([[QuysAdviceManager shareManager] loadAdviceEnable])
    {
        kWeakSelf(self)
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            if ([weakself.delegate respondsToSelector:@selector(quys_requestStart:)])
            {
                [weakself.delegate quys_requestStart:weakself];
            }
            [weakself.api start];
        });
    }
    
}


/// 根据响应数据创建指定view
/// @param adViewModel 响应数据包装后的viewModel
- (void)configAdviceViewVM:(QuysIncentiveVideoDataModel*)adViewModel
{
    QuysIncentiveVideoVM *vm =  [[QuysIncentiveVideoVM alloc] initWithModel:adViewModel delegate:self.delegate frame:self.cgFrame  ];
    self.adviceView = [vm createAdviceView];
}



/// 展示视图
- (void)showAdView
{
    self.adviceView.hidden = NO;
}


- (void)removeBackgroundImageView
{
    NSArray *windows = [[UIApplication sharedApplication] windows];

    for (UIWindow *__strong windowItem in windows) {
        if ([windowItem isKindOfClass:[QuysIncentiveVideoWindow class]]) {
            windowItem.hidden = YES;
            windowItem = nil;
        }
    }
    self.adviceView.hidden = YES;
    self.adviceView = nil;
}


 

#pragma mark - YTKRequestDelegate

-(void)requestFinished:(__kindof YTKBaseRequest *)request
{
    QuysIncentiveVideoOutLayerDataModel *outerModel = [QuysIncentiveVideoOutLayerDataModel yy_modelWithJSON:request.responseJSONObject];
    if (outerModel && outerModel.data.count)
    {
        QuysIncentiveVideoDataModel *adviceModel = outerModel.data[0];
        [self configAdviceViewVM:adviceModel];
        if ([self.delegate respondsToSelector:@selector(quys_requestSuccess:)])
        {
            [self.delegate quys_requestSuccess:self];
        }
        [self showAdView];
    }else
    {
        [self removeBackgroundImageView];
        if ([self.delegate respondsToSelector:@selector(quys_requestFial:error:)])
        {
            NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:kQuysNetworkParsingErrorCode userInfo:@{NSUnderlyingErrorKey:@"数据解析异常！"}];
            [self.delegate quys_requestFial:self error:error];
        }
        
    }
}


- (void)requestFailed:(__kindof YTKBaseRequest *)request
{
    [self removeBackgroundImageView];
    if ([self.delegate respondsToSelector:@selector(quys_requestFial:error:)])
    {
        [self.delegate quys_requestFial:self error:request.error];
    }
    
}

-(UIWindow *)adviceView
{
    if (_adviceView == nil)
    {
        _adviceView.windowLevel = UIWindowLevelAlert - 1;
        UIViewController *rootVC = [UIViewController new];
        _adviceView.rootViewController = rootVC;
    }return _adviceView;
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kRemoveIncentiveBackgroundImageViewNotify object:nil];
}
@end
