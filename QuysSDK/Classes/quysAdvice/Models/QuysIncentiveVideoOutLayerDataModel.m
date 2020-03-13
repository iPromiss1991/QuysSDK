//
//  QuysIncentiveVideoOutLayerDataModel.m
//  quysAdvice
//
//  Created by quys on 2019/12/31.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysIncentiveVideoOutLayerDataModel.h"

@implementation QuysIncentiveVideoOutLayerDataModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data":[QuysIncentiveVideoDataModel class]};
}
@end
