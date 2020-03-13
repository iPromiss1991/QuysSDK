//
//  QuysAdviceBaseDelegate.h
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class QuysAdBaseService;

NS_ASSUME_NONNULL_BEGIN
///广告基础协议
@protocol QuysAdviceBaseDelegate <NSObject>
@optional
- (void)quys_requestStart:(QuysAdBaseService*)service;

- (void)quys_requestSuccess:(QuysAdBaseService*)service;

- (void)quys_requestFial:(QuysAdBaseService*)service error:(NSError*)error;

- (void)quys_interstitialOnExposure:(QuysAdBaseService*)service;

- (void)quys_interstitialOnClick:(CGPoint)cpClick service:(QuysAdBaseService*)service;

- (void)quys_interstitialOnAdClose:(QuysAdBaseService*)service;




@end

NS_ASSUME_NONNULL_END
