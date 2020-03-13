//
//  QuysOpenScreenWindow.h
//  quysAdvice
//
//  Created by quys on 2019/12/24.
//  Copyright © 2019 Quys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuysIncentiveVideoVM.h"
#import "QuysIncentiveVideoWindowVC.h"

NS_ASSUME_NONNULL_BEGIN


@interface QuysIncentiveVideoWindow : UIWindow
- (instancetype)initWithFrame:(CGRect)frame viewModel:(QuysIncentiveVideoVM*)viewModel;

@property (nonatomic,strong) QuysIncentiveVideoVM *vm;

@property (nonatomic,copy) QuysAdviceCloseEventBlock quysAdviceCloseEventBlockItem;
@property (nonatomic,copy) QuysAdviceClickEventBlock quysAdviceClickEventBlockItem;
@property (nonatomic,copy) QuysAdviceStatisticalCallBackBlock quysAdviceStatisticalCallBackBlockItem;

@property (nonatomic,copy) QuysAdvicePlayStartCallBackBlock quysAdvicePlayStartCallBackBlockItem;
@property (nonatomic,copy) QuysAdvicePlayEndCallBackBlock quysAdvicePlayEndCallBackBlockItem;
@property (nonatomic,copy) QuysAdviceProgressEventBlock quysAdviceProgressEventBlockItem;

@property (nonatomic,copy) QuysAdviceMuteCallBackBlock quysAdviceMuteCallBackBlockItem;
@property (nonatomic,copy) QuysAdviceCloseMuteCallBackBlock quysAdviceCloseMuteCallBackBlockItem;

@property (nonatomic,copy) QuysAdviceEndViewCloseEventBlock quysAdviceEndViewCloseEventBlockItem;
@property (nonatomic,copy) QuysAdviceEndViewClickEventBlock quysAdviceEndViewClickEventBlockItem;

@property (nonatomic,copy) QuysAdviceSuspendCallBackBlock quysAdviceSuspendCallBackBlockItem;
@property (nonatomic,copy) QuysAdvicePlayagainCallBackBlock quysAdvicePlayagainCallBackBlockItem;
@property (nonatomic,copy) QuysAdviceEndViewStatisticalCallBackBlock quysAdviceEndViewStatisticalCallBackBlockItem;


@property (nonatomic,copy) QuysAdviceLoadSucessCallBackBlock quysAdviceLoadSucessCallBackBlockItem;
@property (nonatomic,copy) QuysAdviceLoadFailCallBackBlock quysAdviceLoadFailCallBackBlockItem;
@end

NS_ASSUME_NONNULL_END
