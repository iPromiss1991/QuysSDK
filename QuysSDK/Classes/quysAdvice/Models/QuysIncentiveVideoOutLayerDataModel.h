//
//  QuysIncentiveVideoOutLayerDataModel.h
//  quysAdvice
//
//  Created by quys on 2019/12/31.
//  Copyright © 2019 Quys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuysIncentiveVideoDataModel.h"
NS_ASSUME_NONNULL_BEGIN

///数据外层模型
@interface QuysIncentiveVideoOutLayerDataModel : NSObject
@property (nonatomic , copy) NSString              * msg;
@property (nonatomic , strong) NSArray <QuysIncentiveVideoDataModel *>              * data;
@property (nonatomic , assign) NSInteger              code;

@end


NS_ASSUME_NONNULL_END
