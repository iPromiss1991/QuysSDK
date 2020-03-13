//
//  QuysAdviceConfigModel.h
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QuysAdviceConfigModel : NSObject
@property (nonatomic,strong) NSString *replaceKey;//!<替换的key
@property (nonatomic,strong) NSString *replaceValue;//!<替换的value

- (instancetype)initWithKey:(NSString*)replaceKey value:(NSString*)replaceValue;


@end

NS_ASSUME_NONNULL_END
