//
//  QuysVidoePlayButtonView.m
//  quysAdvice
//
//  Created by quys on 2020/1/6.
//  Copyright © 2020 Quys. All rights reserved.
//

#import "QuysVidoePlayButtonView.h"
@interface QuysVidoePlayButtonView()
@property (nonatomic,strong) UIView *viewContain;
@property (nonatomic,strong) CAShapeLayer *shapeLayer;
@property (nonatomic,assign) BOOL circleEnable;//!< 是否转圈

@end


@implementation QuysVidoePlayButtonView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        self.circleEnable = YES;
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageVIewEvent:)];
    [self addGestureRecognizer:tap];
    
    UIView *viewContain = [[UIView alloc]initWithFrame:CGRectZero];
    viewContain.backgroundColor = [UIColor grayColor];
    viewContain.alpha = .7;
    [self addSubview:viewContain];
    self.viewContain = viewContain;
    
    UIButton *btnPlay = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnPlay addTarget:self action:@selector(clickPlayBtEvent:) forControlEvents:UIControlEventTouchUpInside];
    [btnPlay setTitle:@"" forState:UIControlStateNormal];
    [btnPlay setTitle:@"" forState:UIControlStateHighlighted];
    [btnPlay setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btnPlay setImage:[UIImage imageNamed:@"play" inBundle:MYBUNDLE compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    [btnPlay setImage:[UIImage imageNamed:@"play" inBundle:MYBUNDLE compatibleWithTraitCollection:nil] forState:UIControlStateHighlighted];
    [self.viewContain addSubview:btnPlay];
    self.btnPlay = btnPlay;
    
    
    
}

- (void)updateConstraints
{
    [self.viewContain mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.width.height.mas_equalTo(kScale_W(100));
    }];
    
    [self.btnPlay mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.viewContain);
        make.width.height.mas_equalTo(kScale_W(60));
    }];
    [super updateConstraints];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.circleEnable)
    {
        self.circleEnable = NO;
        if (!self.shapeLayer.superlayer)
        {
            [self.viewContain.layer addSublayer: self.shapeLayer];
        }
     }else
    {
         [self.shapeLayer removeFromSuperlayer];
    }
    
}


- (void)hiddenView
{
    [UIView animateWithDuration:.5 animations:^{
        self.alpha = 0;
    }];
 
}


- (void)showView
{
    self.alpha = 1;
    self.shapeLayer.hidden = YES;
    
}


- (void)clickPlayBtEvent:(UIButton*)sender
{
    [self clickEvent];
}


- (void)tapImageVIewEvent:(UITapGestureRecognizer*)sender
{
    [self clickEvent];
}

#pragma mark - PrivateMethod

- (void)clickEvent
{
    if (self.quysAdviceClickPlayButtonBlockItem)
    {
        self.quysAdviceClickPlayButtonBlockItem();
    }
}


 
#pragma mark - Init

- (void)setCircleEnable:(BOOL)circleEnable
{
    _circleEnable = circleEnable;
    if (!circleEnable)
    {
        [self.shapeLayer removeFromSuperlayer];
    }
}



- (CAShapeLayer *)shapeLayer
{
    if (_shapeLayer == nil)
    {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
         shapeLayer.fillColor = [UIColor clearColor].CGColor;//填充颜色为ClearColor
        
        //设置线条的宽度和颜色
        shapeLayer.lineWidth = 1.0f;
        shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, CGRectGetWidth(self.viewContain.bounds) - kScale_W(5), CGRectGetHeight(self.viewContain.bounds) - kScale_W(5))];
        shapeLayer.path = bezierPath.CGPath;
        _shapeLayer = shapeLayer;
        
        CABasicAnimation *animation = [CABasicAnimation animation];
        animation.fromValue = @(-.7);
        animation.toValue = @(1);
        animation.duration = 1;
        animation.repeatCount = CGFLOAT_MAX;
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        [shapeLayer addAnimation:animation forKey:@"strokeStart"];
        
        
        CABasicAnimation *animationEnd = [CABasicAnimation animation];
        animationEnd.fromValue = @(0);
        animationEnd.toValue = @(1);
        animationEnd.duration = 1;
        animationEnd.repeatCount = CGFLOAT_MAX;
        animationEnd.removedOnCompletion = NO;
        animationEnd.fillMode = kCAFillModeForwards;
        [shapeLayer addAnimation:animationEnd forKey:@"strokeEnd"];
    }
    return _shapeLayer;
}

@end
