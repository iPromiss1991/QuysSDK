//
//  QuysAdSplash.m
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysIncentiveVideoWindow.h"
#import "QuysNavigationController.h"
@interface QuysIncentiveVideoWindow()
@property (nonatomic,strong) QuysIncentiveVideoWindowVC *rootVC;

@end


@implementation QuysIncentiveVideoWindow

- (instancetype)initWithFrame:(CGRect)frame viewModel:(QuysIncentiveVideoVM *)viewModel
{
    if (self = [super initWithFrame:frame])
    {
        self.windowLevel = UIWindowLevelAlert -1;
        QuysIncentiveVideoWindowVC *rootVC = [[QuysIncentiveVideoWindowVC alloc] initWithVM:viewModel];
        QuysNavigationController *nav= [[QuysNavigationController alloc]initWithRootViewController:rootVC];
        nav.hideNavbar = YES;
        self.rootVC = rootVC;
        self.rootViewController = nav;
        self.vm = viewModel;
    }
    return self;
}

- (void)setQuysAdviceClickEventBlockItem:(QuysAdviceClickEventBlock)quysAdviceClickEventBlockItem
{
    _quysAdviceClickEventBlockItem = quysAdviceClickEventBlockItem;
    self.rootVC.quysAdviceClickEventBlockItem = quysAdviceClickEventBlockItem;
}


- (void)setQuysAdviceCloseEventBlockItem:(QuysAdviceCloseEventBlock)quysAdviceCloseEventBlockItem
{
    _quysAdviceCloseEventBlockItem = quysAdviceCloseEventBlockItem;
    self.rootVC.quysAdviceCloseEventBlockItem = quysAdviceCloseEventBlockItem;
}

- (void)setQuysAdviceStatisticalCallBackBlockItem:(QuysAdviceStatisticalCallBackBlock)quysAdviceStatisticalCallBackBlockItem
{
    _quysAdviceStatisticalCallBackBlockItem = quysAdviceStatisticalCallBackBlockItem;
    self.rootVC.quysAdviceStatisticalCallBackBlockItem = quysAdviceStatisticalCallBackBlockItem;
}
//
- (void)setQuysAdvicePlayStartCallBackBlockItem:(QuysAdvicePlayStartCallBackBlock)quysAdvicePlayStartCallBackBlockItem
{
    _quysAdvicePlayStartCallBackBlockItem = quysAdvicePlayStartCallBackBlockItem;
    self.rootVC.quysAdvicePlayStartCallBackBlockItem = quysAdvicePlayStartCallBackBlockItem;
}

- (void)setQuysAdvicePlayEndCallBackBlockItem:(QuysAdvicePlayEndCallBackBlock)quysAdvicePlayEndCallBackBlockItem
{
    _quysAdvicePlayEndCallBackBlockItem = quysAdvicePlayEndCallBackBlockItem;
    self.rootVC.quysAdvicePlayEndCallBackBlockItem = quysAdvicePlayEndCallBackBlockItem;
}

- (void)setQuysAdviceProgressEventBlockItem:(QuysAdviceProgressEventBlock)quysAdviceProgressEventBlockItem
{
    _quysAdviceProgressEventBlockItem = quysAdviceProgressEventBlockItem;
    self.rootVC.quysAdviceProgressEventBlockItem = quysAdviceProgressEventBlockItem;
}

//
- (void)setQuysAdviceMuteCallBackBlockItem:(QuysAdviceMuteCallBackBlock)quysAdviceMuteCallBackBlockItem
{
    _quysAdviceMuteCallBackBlockItem = quysAdviceMuteCallBackBlockItem;
    self.rootVC.quysAdviceMuteCallBackBlockItem = quysAdviceMuteCallBackBlockItem;
}


- (void)setQuysAdviceCloseMuteCallBackBlockItem:(QuysAdviceCloseMuteCallBackBlock)quysAdviceCloseMuteCallBackBlockItem
{
    quysAdviceCloseMuteCallBackBlockItem = quysAdviceCloseMuteCallBackBlockItem;
    self.rootVC.quysAdviceCloseMuteCallBackBlockItem = quysAdviceCloseMuteCallBackBlockItem;
}

//
- (void)setQuysAdviceEndViewCloseEventBlockItem:(QuysAdviceEndViewCloseEventBlock)quysAdviceEndViewCloseEventBlockItem
{
    _quysAdviceEndViewCloseEventBlockItem = quysAdviceEndViewCloseEventBlockItem;
    self.rootVC.quysAdviceEndViewCloseEventBlockItem = quysAdviceEndViewCloseEventBlockItem;
}

- (void)setQuysAdviceEndViewClickEventBlockItem:(QuysAdviceEndViewClickEventBlock)quysAdviceEndViewClickEventBlockItem
{
    _quysAdviceEndViewClickEventBlockItem = quysAdviceEndViewClickEventBlockItem;
    self.rootVC.quysAdviceEndViewClickEventBlockItem = quysAdviceEndViewClickEventBlockItem;
}




//

- (void)setQuysAdviceSuspendCallBackBlockItem:(QuysAdviceSuspendCallBackBlock)quysAdviceSuspendCallBackBlockItem
{
    _quysAdviceSuspendCallBackBlockItem = quysAdviceSuspendCallBackBlockItem;
    self.rootVC.quysAdviceSuspendCallBackBlockItem = quysAdviceSuspendCallBackBlockItem;
}

- (void)setQuysAdvicePlayagainCallBackBlockItem:(QuysAdvicePlayagainCallBackBlock)quysAdvicePlayagainCallBackBlockItem
{
    _quysAdvicePlayagainCallBackBlockItem = quysAdvicePlayagainCallBackBlockItem;
    self.rootVC.quysAdvicePlayagainCallBackBlockItem = quysAdvicePlayagainCallBackBlockItem;
}


- (void)setQuysAdviceEndViewStatisticalCallBackBlockItem:(QuysAdviceEndViewStatisticalCallBackBlock)quysAdviceEndViewStatisticalCallBackBlockItem
{
    _quysAdviceEndViewStatisticalCallBackBlockItem = quysAdviceEndViewStatisticalCallBackBlockItem;
    self.rootVC.quysAdviceEndViewStatisticalCallBackBlockItem = quysAdviceEndViewStatisticalCallBackBlockItem;
}

-(void)setQuysAdviceLoadSucessCallBackBlockItem:(QuysAdviceLoadSucessCallBackBlock)quysAdviceLoadSucessCallBackBlockItem
{
    _quysAdviceLoadSucessCallBackBlockItem = quysAdviceLoadSucessCallBackBlockItem;
    self.rootVC.quysAdviceLoadSucessCallBackBlockItem = quysAdviceLoadSucessCallBackBlockItem;
}

-(void)setQuysAdviceLoadFailCallBackBlockItem:(QuysAdviceLoadFailCallBackBlock)quysAdviceLoadFailCallBackBlockItem
{
    _quysAdviceLoadFailCallBackBlockItem = quysAdviceLoadFailCallBackBlockItem;
    self.rootVC.quysAdviceLoadFailCallBackBlockItem = quysAdviceLoadFailCallBackBlockItem;
}

- (void)dealloc
{
    
}
@end
