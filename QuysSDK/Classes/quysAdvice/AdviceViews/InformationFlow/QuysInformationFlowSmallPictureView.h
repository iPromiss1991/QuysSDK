//
//  QuysInformationFlowDefault.h
//  quysAdvice
//
//  Created by quys on 2019/12/16.
//  Copyright © 2019 Quys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuysInformationFlowVM.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^QuysAdviceCloseEventBlock)(void);//!< 关闭事件
typedef void(^QuysAdviceClickEventBlock)(CGPoint cp);//!< 点击事件
typedef void(^QuysAdviceStatisticalCallBackBlock)(void);//!< 曝光事件
///信息流（小图）
@interface QuysInformationFlowSmallPictureView:UIView
- (instancetype)initWithFrame:(CGRect)frame viewModel:(QuysInformationFlowVM*)viewModel;

@property (nonatomic,strong) QuysInformationFlowVM *vm;
@property (nonatomic,copy) QuysAdviceCloseEventBlock quysAdviceCloseEventBlockItem;
@property (nonatomic,copy) QuysAdviceClickEventBlock quysAdviceClickEventBlockItem;
@property (nonatomic,copy) QuysAdviceStatisticalCallBackBlock quysAdviceStatisticalCallBackBlockItem;

@end

NS_ASSUME_NONNULL_END

