//
//  UIViewController+QuysNavBar.h
//  quysAdvice
//
//  Created by quys on 2019/12/25.
//  Copyright © 2019 Quys. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/// 自定义导航栏
@interface UIViewController (QuysNavBar)

@property (nonatomic, strong) UIButton *quys_navBackButton;

/** 导航栏返回按钮图片*/
@property (nonatomic, strong) UIImage  *quys_navBackButtonImage;          // 导航栏返回按钮图片
/** 导航栏返回按钮标题*/
@property (nonatomic, strong) NSString *quys_navBackButtonTitle;         // 导航栏返回按钮标题
/** 导航栏返回按钮颜色*/
@property (nonatomic, strong) UIColor  *quys_navBackButtonColor;         // 导航栏返回按钮颜色


/// 导航栏返回事件
/// @param button backButton
- (void)quys_navigationItemHandleBack:(UIButton *)button;

@end

NS_ASSUME_NONNULL_END
