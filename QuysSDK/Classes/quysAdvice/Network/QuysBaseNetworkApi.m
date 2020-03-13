//
//  QuysNetworkApi.m
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysBaseNetworkApi.h"

@implementation QuysBaseNetworkApi
- (NSTimeInterval)requestTimeoutInterval
{
    return 3;
}

-(YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

@end
