
//
//  QuysWindowViewController.m
//  quysAdviceTestDemo
//
//  Created by quys on 2019/12/20.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysIncentiveVideoWindowVC.h"
#import "QuysWebViewController.h"
@interface QuysIncentiveVideoWindowVC ()
@property (nonatomic,strong) QuysIncentiveVideoVM *vm;

@end

@implementation QuysIncentiveVideoWindowVC

-(instancetype)initWithVM:(QuysIncentiveVideoVM *)vm
{
    if (self == [super init])
    {
        self.vm = vm;
    }
    return self;
}
- (void)loadView
{
    kWeakSelf(self)
    QuysIncentiveVideo *view = [[QuysIncentiveVideo alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, kScreenHeight -100) viewModel:self.vm];
    self.view = view;
    view.quysAdviceCloseEventBlockItem = self.quysAdviceCloseEventBlockItem ;
    view.quysAdviceClickEventBlockItem   =  self.quysAdviceClickEventBlockItem ;
    view.quysAdviceStatisticalCallBackBlockItem = self.quysAdviceStatisticalCallBackBlockItem   ;
    
    view.quysAdvicePlayStartCallBackBlockItem = self.quysAdvicePlayStartCallBackBlockItem ;
    view.quysAdvicePlayEndCallBackBlockItem = self.quysAdvicePlayEndCallBackBlockItem;
    view.quysAdviceProgressEventBlockItem = self.quysAdviceProgressEventBlockItem;

    view.quysAdviceMuteCallBackBlockItem = self.quysAdviceMuteCallBackBlockItem ;
    view.quysAdviceCloseMuteCallBackBlockItem = self.quysAdviceCloseMuteCallBackBlockItem;

    view.quysAdviceEndViewCloseEventBlockItem = self.quysAdviceEndViewCloseEventBlockItem;
    view.quysAdviceEndViewClickEventBlockItem = self.quysAdviceEndViewClickEventBlockItem;
    view.quysAdviceEndViewStatisticalCallBackBlockItem = self.quysAdviceEndViewStatisticalCallBackBlockItem;
    
    
    view.quysAdviceSuspendCallBackBlockItem = self.quysAdviceSuspendCallBackBlockItem;
    view.quysAdvicePlayagainCallBackBlockItem = self.quysAdvicePlayagainCallBackBlockItem ;
    
    view.quysAdviceLoadSucessCallBackBlockItem = self.quysAdviceLoadSucessCallBackBlockItem;
    view.quysAdviceLoadFailCallBackBlockItem = self.quysAdviceLoadFailCallBackBlockItem ;
    [view updateBlockItemsAndPalyStart];//给block重新赋值,因为创建QuysIncentiveVideo的初始化方法内使用的block尚未有值。
    
    //:视频尾帧view在此回调加载
    view.quysAdvicePlayEndCallBackBlockItem = ^(QuysAdviceVideoEndShowType endType)
    {
        switch (endType)
        {
            case QuysAdviceVideoEndShowTypeHtmlCode:
            {
                QuysWebViewController *vc = [[QuysWebViewController alloc] initWithHtml:weakself.vm.videoEndShowValue];
                [weakself.navigationController pushViewController:vc animated:YES];
            }
                break;
            case QuysAdviceVideoEndShowTypeHtmlUrl:
            {
                QuysWebViewController *vc = [[QuysWebViewController alloc] initWithUrl:weakself.vm.videoEndShowValue];
                [weakself.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            default:
                break;
        }
        if (weakself.quysAdvicePlayEndCallBackBlockItem)
        {
            weakself.quysAdvicePlayEndCallBackBlockItem(endType);
        }
    };
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self vhl_setStatusBarHidden:YES];
    [self vhl_setNavBarShadowImageHidden:YES];
    [self vhl_setNavBarHidden:YES];
    
    //模仿nav推出效果
    CATransition * ani = [CATransition animation];
    ani.type = kCATransitionPush;
    ani.subtype = kCATransitionFromRight;
    ani.duration = .3;
    [self.view.layer addAnimation:ani forKey:@"transitionAni"];
    
 
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
