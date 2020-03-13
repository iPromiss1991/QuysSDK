//
//  QuysAdSplashVM.h
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuysAdSplashDelegate.h"
@class QuysAdviceModel,QuysAdBannerService;
NS_ASSUME_NONNULL_BEGIN
///插屏广告viewModel
@interface QuysAdBannerVM : NSObject<QuysAdSplashDelegate>
//输出字段
@property (nonatomic,strong) NSString *strImgUrl;




- (instancetype)initWithModel:(QuysAdviceModel*)model delegate:(id<QuysAdSplashDelegate>)delegate frame:(CGRect)cgFrame;


- (UIView *)createAdviceView;

/// 更新宏替换键&值
/// @param replaceKey key
/// @param replaceVlue value
- (void)updateReplaceDictionary:(NSString*)replaceKey value:(NSString*)replaceVlue;





@end

NS_ASSUME_NONNULL_END
