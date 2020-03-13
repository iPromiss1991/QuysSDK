//
//  QuysOpenScreenWindow.h
//  quysAdvice
//
//  Created by quys on 2019/12/24.
//  Copyright © 2019 Quys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuysAdOpenScreenVM.h"
#import "QuysWindowViewController.h"
#import "QuysAdviceModel.h"
NS_ASSUME_NONNULL_BEGIN


@interface QuysOpenScreenWindow : UIWindow
- (instancetype)initWithFrame:(CGRect)frame viewModel:(QuysAdOpenScreenVM *)viewModel type:(QuysAdviceCreativeType)creativeType;
@property (nonatomic,strong) QuysAdOpenScreenVM *vm;
@property (nonatomic,copy) QuysAdviceCloseEventBlock quysAdviceCloseEventBlockItem;
@property (nonatomic,copy) QuysAdviceClickEventBlock quysAdviceClickEventBlockItem;
@property (nonatomic,copy) QuysAdviceStatisticalCallBackBlock quysAdviceStatisticalCallBackBlockItem;

@end

NS_ASSUME_NONNULL_END
