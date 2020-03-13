//
//  UIViewController+QuysNavBar.m
//  quysAdvice
//
//  Created by quys on 2019/12/26.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "UIViewController+QuysNavBar.h"
#import <objc/runtime.h>



@implementation QuysBaseViewController (QuysNavBar)

+(void)load
{
    
    SEL viewDidLoadSel = @selector(viewDidLoad);
    SEL swizzhViewDidLoadSel = @selector(quys_viewDidLoad);
    [self exChanageMethodSystemSel:viewDidLoadSel swizzSel:swizzhViewDidLoadSel];
}

+ (void)exChanageMethodSystemSel:(SEL)systemSel swizzSel:(SEL)swizzSel{
    //两个方法的Method
    Method systemMethod = class_getInstanceMethod([self class], systemSel);
    Method swizzMethod = class_getInstanceMethod([self class], swizzSel);
    //首先动态添加方法，实现是被交换的方法，返回值表示添加成功还是失败
    BOOL isAdd = class_addMethod(self, systemSel, method_getImplementation(swizzMethod), method_getTypeEncoding(swizzMethod));
    if (isAdd) {
        //如果成功，说明类中不存在这个方法的实现
        //将被交换方法的实现替换到这个并不存在的实现
        class_replaceMethod(self, swizzSel, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
    }else{
        //否则，交换两个方法的实现
        method_exchangeImplementations(systemMethod, swizzMethod);
    }
}

- (void)quys_viewDidLoad
{
    // 统一定义导航栏返回按钮
    self.navigationItem.leftBarButtonItems = @[self.backBarButtonItem];
    if (self.navigationController.navigationBar) {
        for (UIView *view in self.navigationController.navigationBar.subviews) {
            Class _UIButtonBarStackViewClass = NSClassFromString(@"_UIButtonBarStackView");
            if (_UIButtonBarStackViewClass != nil) {
                if (![view isKindOfClass:_UIButtonBarStackViewClass]) {
                    view.layer.masksToBounds = NO;
                    view.clipsToBounds = NO;
                }
            }
            //
            Class _UITAMICAdaptorViewClass = NSClassFromString(@"_UITAMICAdaptorView");
            if (_UITAMICAdaptorViewClass != nil) {
                if (![view isKindOfClass:_UITAMICAdaptorViewClass]) {
                    view.layer.masksToBounds = NO;
                    view.clipsToBounds = NO;
                }
            }
        }
    }
    [self quys_viewDidLoad];
}



- (UIBarButtonItem *)backBarButtonItem
{
    UIImage* backItemImage = [UIImage imageNamed:@"nav_back" inBundle:MYBUNDLE compatibleWithTraitCollection:nil];
    
    UIGraphicsBeginImageContextWithOptions(backItemImage.size, NO, backItemImage.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, backItemImage.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, backItemImage.size.width, backItemImage.size.height);
    CGContextClipToMask(context, rect, backItemImage.CGImage);
    [self.qus_navBackButtonColor?:[UIColor whiteColor] setFill];             // **
    CGContextFillRect(context, rect);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    backItemImage = newImage?:backItemImage;
    
    // 绘制高亮的背景，0.5透明度
    UIGraphicsBeginImageContextWithOptions(backItemImage.size, NO, backItemImage.scale);
    CGContextRef navContext = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(navContext, 0, backItemImage.size.height);
    CGContextScaleCTM(navContext, 1.0, -1.0);
    CGContextSetBlendMode(navContext, kCGBlendModeNormal);
    CGRect navRect = CGRectMake(0, 0, backItemImage.size.width, backItemImage.size.height);
    CGContextClipToMask(navContext, navRect, backItemImage.CGImage);
    [[self.qus_navBackButtonColor?:[UIColor whiteColor] colorWithAlphaComponent:0.5] setFill];
    
    CGContextFillRect(navContext, navRect);
    UIImage *hlNewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImage* backItemHlImage = hlNewImage?:[UIImage imageNamed:@"nav_back" inBundle:MYBUNDLE compatibleWithTraitCollection:nil];
    // -----------------------------------------------------------
    
    self.qus_navBackButton = [[UIButton alloc] init];
    // 按钮图片
    [self.qus_navBackButton setImage:backItemImage forState:UIControlStateNormal];
    [self.qus_navBackButton setImage:backItemHlImage forState:UIControlStateHighlighted];
    // 按钮字体颜色
    UIColor *titleColor = self.qus_navBackButtonColor?:[UIColor whiteColor];     // ****
    [self.qus_navBackButton setTitleColor:titleColor forState:UIControlStateNormal];
    [self.qus_navBackButton setTitleColor:[titleColor colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
    //
    [self.qus_navBackButton setTitle:self.qus_navBackButtonTitle?:@"返回上一页" forState:UIControlStateNormal];
    self.qus_navBackButton.titleLabel.font = [UIFont systemFontOfSize:16];
    
    self.qus_navBackButton.titleEdgeInsets = UIEdgeInsetsMake(0, -6, 0, 0);     // 图片和字体靠近一点，根据实际情况调整
    self.qus_navBackButton.contentEdgeInsets = UIEdgeInsetsMake(0, -36, 0, 0);
    [self.qus_navBackButton sizeToFit];
    
    [self.qus_navBackButton addTarget:self action:@selector(qus_navigationItemHandleBack:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.qus_navBackButton];
    backButtonItem.customView.userInteractionEnabled = YES;
    return backButtonItem;
}




#pragma mark - Event


// 设置导航栏返回按钮

-(void)setQus_navBackButtonTitle:(NSString *)qus_navBackButtonTitle
{
    objc_setAssociatedObject(self, @selector(qus_navBackButtonTitle), qus_navBackButtonTitle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.qus_navBackButton setTitle:qus_navBackButtonTitle forState:UIControlStateNormal];
}

-(NSString *)qus_navBackButtonTitle
{
  return  objc_getAssociatedObject(self, @selector(qus_navBackButtonTitle));
}

//
-(void)setQus_navBackButtonImage:(UIImage *)qus_navBackButtonImage
{
    objc_setAssociatedObject(self, @selector(qus_navBackButtonImage), qus_navBackButtonImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.qus_navBackButton setImage:qus_navBackButtonImage forState:(UIControlStateNormal)];
}

-(UIImage *)qus_navBackButtonImage
{
  return  objc_getAssociatedObject(self, @selector(qus_navBackButtonImage));
}

//
-(void )setQus_navBackButtonColor:(UIColor *)qus_navBackButtonColor
{
    objc_setAssociatedObject(self, @selector(qus_navBackButtonColor), qus_navBackButtonColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.qus_navBackButton setTitleColor:qus_navBackButtonColor forState:UIControlStateNormal];
}

-(UIColor *)qus_navBackButtonColor
{
  return  objc_getAssociatedObject(self, @selector(qus_navBackButtonColor));
}

//
-(void )setQus_navBackButton:(UIButton *)qus_navBackButton
{
    objc_setAssociatedObject(self, @selector(qus_navBackButton), qus_navBackButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIButton *)qus_navBackButton
{
  return  objc_getAssociatedObject(self, @selector(qus_navBackButton));
}







- (void)qus_navigationItemHandleBack:(UIButton *)button
{
    [[NSNotificationCenter defaultCenter ] postNotificationName:kRemoveOpenScreenBackgroundImageViewNotify object:nil];

    if ([self.navigationController respondsToSelector:@selector(popViewControllerAnimated:)])
    {
        [self.navigationController popViewControllerAnimated:YES];
    } else
    {
        if ([self respondsToSelector:@selector(dismissViewControllerAnimated:completion:)])
        {
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
    }
    //在本类中调用super后，实现自己的逻辑
}
@end
