//
//  QuysWindowViewController.h
//  quysAdviceTestDemo
//
//  Created by quys on 2019/12/20.
//  Copyright © 2019 Quys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuysAdOpenScreenVM.h"
#import "QuysAdOpenScreenDefaultView.h"

NS_ASSUME_NONNULL_BEGIN
///开屏广告rootVC

@interface QuysWindowViewController : UIViewController
- (instancetype)initWithVM:(QuysAdOpenScreenVM*)vm type:(QuysAdviceCreativeType)creativeType;

@property (nonatomic,copy) QuysAdviceCloseEventBlock quysAdviceCloseEventBlockItem;
@property (nonatomic,copy) QuysAdviceClickEventBlock quysAdviceClickEventBlockItem;
@property (nonatomic,copy) QuysAdviceStatisticalCallBackBlock quysAdviceStatisticalCallBackBlockItem;

@end

NS_ASSUME_NONNULL_END
