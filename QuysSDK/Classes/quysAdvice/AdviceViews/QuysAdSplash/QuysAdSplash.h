//
//  QuysAdSplash.h
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuysAdSplashVM.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^QuysAdviceCloseEventBlock)(void);//!< 关闭事件
typedef void(^QuysAdviceClickEventBlock)(CGPoint cp);//!< 点击事件
typedef void(^QuysAdviceStatisticalCallBackBlock)(void);//!< 曝光事件
@interface QuysAdSplash : UIView
- (instancetype)initWithFrame:(CGRect)frame viewModel:(QuysAdSplashVM*)viewModel;

@property (nonatomic,strong) QuysAdSplashVM *vm;
@property (nonatomic,copy) QuysAdviceCloseEventBlock quysAdviceCloseEventBlockItem;
@property (nonatomic,copy) QuysAdviceClickEventBlock quysAdviceClickEventBlockItem;
@property (nonatomic,copy) QuysAdviceStatisticalCallBackBlock quysAdviceStatisticalCallBackBlockItem;

@end

NS_ASSUME_NONNULL_END
