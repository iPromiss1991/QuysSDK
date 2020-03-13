//
//  QuysVideoContentView.m
//  quysAdvice
//
//  Created by wxhmbp on 2020/3/3.
//  Copyright © 2020年 Quys. All rights reserved.
//

#import "QuysVideoContentView.h"
#import <AVFoundation/AVFoundation.h>
@interface QuysVideoContentView()
@property (nonatomic, strong) NSURL *playUrl;//!< <#Explement #>
@property (nonatomic, strong) AVPlayer *avPlayer;//!< <#Explement #>
@property (nonatomic, strong) AVPlayerLayer *avPlayerLayer;//!< <#Explement #>
@end
@implementation QuysVideoContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    };
    return self;
}

- (void)createUI
{
    
}

- (void)setPlayUrl:(NSURL *)playUrl
{
    
}

@end
