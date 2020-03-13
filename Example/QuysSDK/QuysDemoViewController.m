//
//  QuysDemoViewController.m
//  quysDevDemo
//
//  Created by quys on 2020/1/7.
//  Copyright © 2020 Quys. All rights reserved.
//

#import "QuysDemoViewController.h"
//#import "quysAdvice.h"
 
@interface QuysDemoViewController ()
//@property (nonatomic,strong) QuysAdBaseService *service;
@property (nonatomic, strong) UIView *viewContain;//!< <#Explement #>
@property (nonatomic, strong) UIView *viewContainBottom;//!< <#Explement #>
@property (nonatomic, strong) UIView *adviceView;//!< <#Explement #>
@end

@implementation QuysDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    UIView *viewContain = [[UIView alloc]init];
    viewContain.backgroundColor = [UIColor blueColor];
    [self.view addSubview:viewContain];
    self.viewContain=  viewContain;
    
    UIView *viewContainBottom = [[UIView alloc]init];
    viewContainBottom.backgroundColor = [UIColor purpleColor];
    [self.viewContain addSubview:viewContainBottom];
    self.viewContainBottom =  viewContainBottom;
    NSString *strService = self.title;
    
//    //TODO：正式环境测试数据
//    //
//    if ([strService isEqualToString:@"banner"])
//    {
//        self.service = [[QuysAdBannerService alloc ]initWithID:@"ziyanapp_banner" key:@"DF6CB421D36AE5B518700B40A77105A7" cgRect:CGRectMake(0, 10,[UIScreen mainScreen].bounds.size.width , 200) eventDelegate:self parentView:viewContain];
//    }
//
//    if ([strService isEqualToString:@"信息流"])
//    {
//        self.service =  [[QuysInformationFlowService alloc ]initWithID:@"quystest-xx" key:@"3A6511273E535FA02C15F37D17D22A95" cgRect:CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width, 200) eventDelegate:self parentView:viewContain];
//    }
//
//    if ([strService isEqualToString:@"插屏"])
//    {
//        self.service = [[QuysAdSplashService alloc ]initWithID:@"ziyanapp_cp" key:@"8EB8AC0B397CA55C2D78DE88DF8587C2" cgRect:CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width , 200) eventDelegate:self parentView:viewContain];
//    }
//
//    if (self.service)
//    {
//        [self.service performSelector:@selector(loadAdViewNow)];
//    }else
//    {
//        //激励视频
//    }
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)updateViewConstraints
{
//    if (self.service) {
        
//        if (![self.title  containsString:@"激励视频"])
//        {
//            [self.viewContain mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.top.mas_equalTo(self.view).mas_offset(100);
//                make.left.right.mas_equalTo(self.view);
//                make.bottom.mas_lessThanOrEqualTo(self.view);
//                make.height.mas_greaterThanOrEqualTo(300);
//            }];
//
//            [self.viewContainBottom mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.top.mas_equalTo(self.adviceView.mas_bottom);
//                make.left.right.mas_equalTo(self.viewContain);
//                make.bottom.mas_equalTo(self.viewContain);
//                make.height.mas_greaterThanOrEqualTo(100);
//            }];
//        }
//    }
    
    [super updateViewConstraints];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

//
//- (void)quys_requestStart:(QuysAdBaseService*)service
//{
//
//}
//
//- (void)quys_requestSuccess:(QuysAdBaseService*)service
//{
//
//        if ([self.service isKindOfClass:[QuysIncentiveVideoService class]]) {
//            self.adviceView = [self.service valueForKey:@"adviceView"];
//
//        }else
//        {
//            [self.service performSelector:@selector(showAdView)];
//            self.adviceView = [self.service valueForKey:@"adviceView"];
//
//        }
//
//        [self.view setNeedsUpdateConstraints];
//        [self.view updateConstraintsIfNeeded];
//
//}
//- (void)quys_requestFial:(QuysAdBaseService*)service error:(NSError*)error{
//
//}
//
//- (void)quys_interstitialOnExposure:(QuysAdBaseService*)service{
//
//}
//- (void)quys_interstitialOnClick:(CGPoint)cpClick service:(QuysAdBaseService*)service{
//
//}
//- (void)quys_interstitialOnAdClose:(QuysAdBaseService*)service{
//
//}
//
////尾帧
//- (void)quys_endViewInterstitialOnExposure:(QuysAdBaseService*)service{
//
//}
//- (void)quys_endViewInterstitialOnClick:(CGPoint)cpClick service:(QuysAdBaseService*)service{
//
//}
//
//- (void)quys_endViewInterstitialOnAdClose:(QuysAdBaseService*)service{
//
//}
//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [super touchesBegan:touches withEvent:event];
//    if ([self.title containsString:@"激励视频"])
//    {
//        self.service = [[QuysIncentiveVideoService alloc]initWithID:@"jlAdziyanapp" key:@"1262DF2885ACB4EEC8FF0486502E7A6D" cgRect:[UIScreen mainScreen].bounds backgroundImage:[UIImage imageNamed:@"Default-568h@2x"] eventDelegate:self  ];
//    }
//
//}
//
//#pragma mark - Init
//
//-(void)dealloc
//{
//
//}


@end
