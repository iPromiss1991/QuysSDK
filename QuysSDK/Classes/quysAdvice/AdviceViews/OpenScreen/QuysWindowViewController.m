
//
//  QuysWindowViewController.m
//  quysAdviceTestDemo
//
//  Created by quys on 2019/12/20.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysWindowViewController.h"
#import "QuysAdOpenScreenVideoView.h"
#import "QuysAdOpenScreenDefaultView.h"
@interface QuysWindowViewController ()
@property (nonatomic,strong) QuysAdOpenScreenVM *vm;
@property (nonatomic,assign) QuysAdviceCreativeType creativeType;

@end

@implementation QuysWindowViewController

-(instancetype)initWithVM:(QuysAdOpenScreenVM *)vm type:(QuysAdviceCreativeType)creativeType
{
    if (self == [super init])
    {
        self.vm = vm;
        self.creativeType = creativeType;
    }
    return self;
}
- (void)loadView
{
    
    switch (self.creativeType)
    {
        case QuysAdviceCreativeTypeVideo:
        {
            QuysAdOpenScreenVideoView *view = [[QuysAdOpenScreenVideoView alloc] initWithFrame:[UIScreen mainScreen].bounds viewModel:self.vm];
              self.view = view;
              view.quysAdviceClickEventBlockItem = self.quysAdviceClickEventBlockItem;
              view.quysAdviceCloseEventBlockItem = self.quysAdviceCloseEventBlockItem;
              view.quysAdviceStatisticalCallBackBlockItem = self.quysAdviceStatisticalCallBackBlockItem;
        }
            break;
        default:
        {
            QuysAdOpenScreenDefaultView *view = [[QuysAdOpenScreenDefaultView alloc] initWithFrame:[UIScreen mainScreen].bounds viewModel:self.vm];
            self.view = view;
            view.quysAdviceClickEventBlockItem = self.quysAdviceClickEventBlockItem;
            view.quysAdviceCloseEventBlockItem = self.quysAdviceCloseEventBlockItem;
            view.quysAdviceStatisticalCallBackBlockItem = self.quysAdviceStatisticalCallBackBlockItem;
        }
            break;
    }


    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //    self.navigationController.navigationBarHidden = YES;
    [self vhl_setStatusBarHidden:YES];
    [self vhl_setNavBarShadowImageHidden:YES];
    [self vhl_setNavBarHidden:YES];
    
    // Do any additional setup after loading the view.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    //    self.view.frame = CGRectMake(0, 0, 0, 330);
    
    
}

@end
