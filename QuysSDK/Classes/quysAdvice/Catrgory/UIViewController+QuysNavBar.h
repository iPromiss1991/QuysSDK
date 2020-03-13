//
//  UIViewController+QuysNavBar.h
//  quysAdvice
//
//  Created by quys on 2019/12/26.
//  Copyright © 2019 Quys. All rights reserved.
//

 

#import "QuysBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QuysBaseViewController (QuysNavBar)
@property (nonatomic, strong) UIButton *qus_navBackButton;

/** 导航栏返回按钮图片*/
@property (nonatomic, strong) UIImage  *qus_navBackButtonImage;          // 导航栏返回按钮图片
/** 导航栏返回按钮标题*/
@property (nonatomic, strong) NSString *qus_navBackButtonTitle;         // 导航栏返回按钮标题
/** 导航栏返回按钮颜色*/
@property (nonatomic, strong) UIColor  *qus_navBackButtonColor;         // 导航栏返回按钮颜色

// ** 导航栏点击事件 **
- (void)qus_navigationItemHandleBack:(UIButton *)button;
@end

NS_ASSUME_NONNULL_END
