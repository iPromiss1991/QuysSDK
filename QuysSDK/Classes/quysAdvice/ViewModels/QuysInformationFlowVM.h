//
//  QuysInformationFlowVM.h
//  quysAdvice
//
//  Created by quys on 2019/12/16.
//  Copyright © 2019 Quys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuysAdSplashDelegate.h"
 @class QuysAdviceModel,QuysInformationFlowService;
NS_ASSUME_NONNULL_BEGIN
///插屏广告viewModel
@interface QuysInformationFlowVM : NSObject
//输出字段
@property (nonatomic,strong) NSString *strTitle;
@property (nonatomic,strong) NSString *strImgUrl;//!> 单图展示
@property (nonatomic,strong) NSArray *arrImgUrl;//!> 多图展示





- (instancetype)initWithModel:(QuysAdviceModel *)model delegate:( id<QuysAdSplashDelegate>)delegate frame:(CGRect)cgFrame service:(QuysInformationFlowService*)service;

- (UIView *)createAdviceView;


/// 更新宏替换键&值
/// @param replaceKey key
/// @param replaceVlue value
- (void)updateReplaceDictionary:(NSString*)replaceKey value:(NSString*)replaceVlue;


@end
NS_ASSUME_NONNULL_END
