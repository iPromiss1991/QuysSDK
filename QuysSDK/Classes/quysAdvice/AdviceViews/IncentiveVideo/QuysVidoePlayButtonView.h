//
//  QuysVidoePlayButtonView.h
//  quysAdvice
//
//  Created by quys on 2020/1/6.
//  Copyright © 2020 Quys. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^QuysAdviceClickPlayButtonBlock)(void );//!< 点击事件
NS_ASSUME_NONNULL_BEGIN
///视频播放按钮
@interface QuysVidoePlayButtonView : UIView
@property (nonatomic,strong) UIButton *btnPlay;

@property (nonatomic,copy) QuysAdviceClickPlayButtonBlock quysAdviceClickPlayButtonBlockItem;


- (void)hiddenView;

- (void)showView;
 
@end

NS_ASSUME_NONNULL_END
