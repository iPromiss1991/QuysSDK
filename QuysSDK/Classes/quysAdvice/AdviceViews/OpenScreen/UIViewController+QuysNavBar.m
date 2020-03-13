//
//  UIViewController+QuysNavBar.m
//  quysAdvice
//
//  Created by quys on 2019/12/25.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "UIViewController+QuysNavBar.h"



@implementation UIViewController (QuysNavBar)

+ (void)load
{
//        SEL viewDidLoad = @selector(viewDidLoad);
//        SEL swizzhViewDidLoad = @selector(quys_viewDidLoad);
//        [[self class] exChanageMethodSystemSel:viewDidLoad swizzSel:swizzhViewDidLoad];
}

+ (void)exChanageMethodSystemSel:(SEL)systemSel swizzSel:(SEL)swizzSel
{
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
     self.view.backgroundColor = [UIColor whiteColor];
    // 统一定义导航栏返回按钮
    self.navigationItem.leftBarButtonItems = @[[self backBarButtonItem]];
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
    [self.quys_navBackButtonColor?:[UIColor whiteColor] setFill];             // **
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
    [[self.quys_navBackButtonColor?:[UIColor whiteColor] colorWithAlphaComponent:0.5] setFill];
    
    CGContextFillRect(navContext, navRect);
    UIImage *hlNewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImage* backItemHlImage = hlNewImage?:[UIImage imageNamed:@"nav_back" inBundle:MYBUNDLE compatibleWithTraitCollection:nil];
    // -----------------------------------------------------------
    
    self.quys_navBackButton = [[UIButton alloc] init];
    // 按钮图片
    [self.quys_navBackButton setImage:backItemImage forState:UIControlStateNormal];
    [self.quys_navBackButton setImage:backItemHlImage forState:UIControlStateHighlighted];
    // 按钮字体颜色
    UIColor *titleColor = self.quys_navBackButtonColor?:[UIColor whiteColor];     // ****
    [self.quys_navBackButton setTitleColor:titleColor forState:UIControlStateNormal];
    [self.quys_navBackButton setTitleColor:[titleColor colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
    //
    [self.quys_navBackButton setTitle:self.quys_navBackButtonTitle?:@"返回" forState:UIControlStateNormal];
    self.quys_navBackButton.titleLabel.font = [UIFont systemFontOfSize:16];
    
    self.quys_navBackButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);     // 图片和字体靠近一点，根据实际情况调整
    self.quys_navBackButton.contentEdgeInsets = UIEdgeInsetsMake(0, -6, 0, 0);
    [self.quys_navBackButton sizeToFit];
    
    [self.quys_navBackButton addTarget:self action:@selector(quys_navigationItemHandleBack:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.quys_navBackButton];
    backButtonItem.customView.userInteractionEnabled = YES;
    return backButtonItem;
}


- (void)quys_navigationItemHandleBack:(UIButton *)button
{
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
}



// -----------------------------------------------------------------------------
#pragma mark - 分类添加属性

#pragma mark - 返回键
- (void)setQuys_navBackButtonTitle:(NSString *)quys_navBackButtonTitle
{
    objc_setAssociatedObject(self, @selector(quys_navBackButtonTitle), quys_navBackButtonTitle,  OBJC_ASSOCIATION_RETAIN_NONATOMIC); // lj: 分类提添加属性
    [self.quys_navBackButton setTitle:quys_navBackButtonTitle forState:UIControlStateNormal];
}

- (NSString *)quys_navBackButtonTitle
{
    return objc_getAssociatedObject(self, @selector(quys_navBackButtonTitle)); // lj: 分类提添加属性
}


- (void)setQuys_navBackButtonImage:(UIImage *)quys_navBackButtonImage {
    objc_setAssociatedObject(self, @selector(quys_navBackButtonImage), quys_navBackButtonImage,  OBJC_ASSOCIATION_RETAIN_NONATOMIC); // lj: 分类提添加属性
    [self.quys_navBackButton setImage:quys_navBackButtonImage forState:UIControlStateNormal];
}

- (NSString *)quys_navBackButtonImage
{
    return objc_getAssociatedObject(self, @selector(quys_navBackButtonImage)); // lj: 分类提添加属性
}


- (void)setQuys_navBackButtonColor:(UIColor *)quys_navBackButtonColor {
    objc_setAssociatedObject(self, @selector(quys_navBackButtonColor), quys_navBackButtonColor,  OBJC_ASSOCIATION_RETAIN_NONATOMIC); // lj: 分类提添加属性
    [self.quys_navBackButton setTitleColor:quys_navBackButtonColor forState:UIControlStateNormal];
}

- (NSString *)quys_navBackButtonColor
{
    return objc_getAssociatedObject(self, @selector(quys_navBackButtonColor)); // lj: 分类提添加属性
}



- (void)setQuys_navBackButton:(UIButton *)quys_navBackButton
{
    objc_setAssociatedObject(self, @selector(quys_navBackButton), quys_navBackButton,  OBJC_ASSOCIATION_RETAIN_NONATOMIC); // lj: 分类提添加属性
 }

- (UIButton *)quys_navBackButton
{
    return objc_getAssociatedObject(self, @selector(quys_navBackButton)); // lj: 分类提添加属性
}





@end
