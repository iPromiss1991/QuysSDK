//
//  QuysAdSplash.m
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysOpenScreenWindow.h"
#import "QuysNavigationController.h"

@interface QuysOpenScreenWindow()
@property (nonatomic,strong) QuysWindowViewController *rootVC;

@end


@implementation QuysOpenScreenWindow

- (instancetype)initWithFrame:(CGRect)frame viewModel:(QuysAdOpenScreenVM *)viewModel type:(QuysAdviceCreativeType)creativeType
{
    if (self = [super initWithFrame:frame])
    {
        self.windowLevel = UIWindowLevelAlert - 1;
        QuysWindowViewController *rootVC = [[QuysWindowViewController alloc] initWithVM:viewModel type:creativeType];
        rootVC.quysAdviceClickEventBlockItem =  self.quysAdviceClickEventBlockItem;
        rootVC.quysAdviceCloseEventBlockItem = self.quysAdviceCloseEventBlockItem;
        rootVC.quysAdviceStatisticalCallBackBlockItem = self.quysAdviceStatisticalCallBackBlockItem;
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

- (void)dealloc
{
    
}
@end
