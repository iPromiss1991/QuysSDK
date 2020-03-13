//
//  QuysAdviceConfigModel.m
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysAdviceConfigModel.h"

@implementation QuysAdviceConfigModel

- (instancetype)initWithKey:(NSString *)replaceKey value:(NSString *)replaceValue
{
    if (self = [super init])
    {
        self.replaceKey = replaceKey;
        self.replaceValue = replaceValue;
    }
    return self;
}
@end
