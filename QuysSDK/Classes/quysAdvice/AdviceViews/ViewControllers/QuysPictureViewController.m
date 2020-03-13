//
//  QuysPictureViewController.m
//  quysAdvice
//
//  Created by quys on 2019/12/24.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysPictureViewController.h"

@interface QuysPictureViewController ()
@property (nonatomic,strong) UIImageView *imgView;

@property (nonatomic,strong) NSString *picUrl;

@end

@implementation QuysPictureViewController

- (instancetype)initWithUrl:(NSString*)picUrl
{
    if (self == [super init])
    {
        self.picUrl = picUrl;
    }return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self vhl_setNavBarBackgroundColor:[UIColor colorWithRed:(rand() % 100 * 0.01) green:(rand() % 100 * 0.01) blue:0.86 alpha:1.00]];
    [self vhl_setNavigationSwitchStyle:VHLNavigationSwitchStyleFakeNavBar];
    //[self vhl_setNavBarBackgroundImage:[UIImage imageNamed:@"millcolorGrad"]];
    //[self vhl_setNavBarBackgroundAlpha:0.f];
    [self vhl_setStatusBarHidden:YES];
    [self vhl_setNavBarShadowImageHidden:YES];
    [self vhl_setNavBarBackgroundAlpha:1.0f];
    [self vhl_setNavBarHidden:NO];
    [self setQus_navBackButtonTitle:@"返回"];
    [self vhl_setInteractivePopGestureRecognizerEnable:NO];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    [self.view addSubview:imgView];
    [imgView sd_setImageWithURL:[NSURL URLWithString:self.picUrl]];
    self.imgView = imgView;
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
}

- (void)updateViewConstraints
{
    [self.imgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(kNavBarHeight);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
    [super updateViewConstraints];
}


-(void)qus_navigationItemHandleBack:(UIButton *)button
{
    [[NSNotificationCenter defaultCenter ] postNotificationName:kRemoveOpenScreenBackgroundImageViewNotify object:nil];
    [[NSNotificationCenter defaultCenter ] postNotificationName:kRemoveIncentiveBackgroundImageViewNotify object:nil];

    [super qus_navigationItemHandleBack:button];
    
}

- (void)dealloc
{
    
}


@end
