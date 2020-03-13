//
//  QuysFullScreenReplaceView.m
//  quysAdvice
//
//  Created by quys on 2019/12/23.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysFullScreenReplaceView.h"
@interface QuysFullScreenReplaceView()
@property (nonatomic,strong) UIImageView *imgReplace;
 
@end


@implementation QuysFullScreenReplaceView

- (instancetype)    initWithFrame:(CGRect)frame image:(UIImage*)img
{
    if (self == [super initWithFrame:frame])
    {
        [self createUI:img];
    }
    return self;
}

- (void)createUI:(UIImage*)img
{
    UIImageView *imgReplace = [[UIImageView alloc] initWithImage:img];
    [self addSubview:imgReplace];
    self.imgReplace = imgReplace;
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
}

- (void)updateConstraints
{
    
    [self.imgReplace mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    [super updateConstraints];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
}


@end
