//
//  QuysAdSplashService.h
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved. 
//

#import "QuysAdBaseService.h"
#import "QuysAdviceOpeenScreenDelegate.h"
NS_ASSUME_NONNULL_BEGIN
/// 开屏广告服务
@interface QuysAdOpenScreenService : QuysAdBaseService
@property (nonatomic,weak) id <QuysAdviceOpeenScreenDelegate> delegate;//!<  服务代理
@property (nonatomic,strong) UIWindow *adviceView;//!<  广告

#warning:建议在初始化之后立即设置，以便准确控制加载adviceView的时机。
@property (nonatomic,assign) NSTimeInterval bgShowDuration;//!< 开屏启动图展示时间（eg：默认1s），结束时展示adviceView



#warning 建议在点击关闭回调中，释放service服务。
/// 创建弹窗广告
/// @param businessID 业务ID
/// @param bussinessKey 业务Key
/// @param cgFrame 弹窗frame
/// @param imgReplace 弹窗背景视图
/// @param delegate 回调代理
- (instancetype)initWithID:businessID key:bussinessKey cgRect:(CGRect)cgFrame  backgroundImage:(UIImage*)imgReplace eventDelegate:(nonnull id<QuysAdviceOpeenScreenDelegate>)delegate  ;


@end

NS_ASSUME_NONNULL_END
