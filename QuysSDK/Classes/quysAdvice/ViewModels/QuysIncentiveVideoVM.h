//
//  QuysAdSplashVM.h
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuysIncentiveVideoDelegate.h"
#import "QuysIncentiveVideoDataModel.h"

@class QuysIncentiveVideoService;
NS_ASSUME_NONNULL_BEGIN
///插屏广告viewModel
@interface QuysIncentiveVideoVM : NSObject
//输出字段
@property (nonatomic,strong) NSString *strImgUrl;//!<  显示的icon
@property (nonatomic,assign) NSInteger showDuration;//!<  播放时长

@property (nonatomic,strong) NSString *videoUrl;//!< 视频播放地址
@property (nonatomic,assign) BOOL isClickable;//!<  播放过程是否可以点击
@property (nonatomic,strong) NSString *strTitle;//!<  视频title
@property (nonatomic,strong) NSString *desc;//!<  视频详情


@property (nonatomic,assign) QuysAdviceVideoEndShowType videoEndShowType;
@property (nonatomic,strong) NSString *videoEndShowValue;
@property (nonatomic,strong) NSString *videoAlternateEndShowValue;//!< videoEndShowValue为空时，尾帧显示该字段

- (instancetype)initWithModel:(QuysIncentiveVideoDataModel*)model delegate:(id<QuysIncentiveVideoDelegate>)delegate frame:(CGRect)cgFrame ;


- (UIWindow *)createAdviceView;

/// 更新宏替换键&值
/// @param replaceKey key
/// @param replaceVlue value
- (void)updateReplaceDictionary:(NSString*)replaceKey value:(NSString*)replaceVlue;





@end

NS_ASSUME_NONNULL_END
