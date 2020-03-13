//
//  QuysImgPlayendCoverView.m
//  quysAdvice
//
//  Created by quys on 2020/1/3.
//  Copyright © 2020 Quys. All rights reserved.
//

#import "QuysImgPlayendCoverView.h"

@interface QuysImgPlayendCoverView()
@property (nonatomic,strong) UIImageView *imgPlayendCover;
@property (nonatomic,strong) UIButton *btnClose;


@end


@implementation QuysImgPlayendCoverView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    UIImageView *imgPlayendCover = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    imgPlayendCover.userInteractionEnabled = YES;
    [self addSubview:imgPlayendCover];
    self.imgPlayendCover = imgPlayendCover;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickEvent:)];
    [imgPlayendCover addGestureRecognizer:tap];
    
    UIButton *btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnClose addTarget:self action:@selector(clickCloseBtEvent:) forControlEvents:UIControlEventTouchUpInside];

    [btnClose setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btnClose setImage:[UIImage imageNamed:@"guanbi" inBundle:MYBUNDLE compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    [btnClose setImage:[UIImage imageNamed:@"guanbi_press" inBundle:MYBUNDLE compatibleWithTraitCollection:nil] forState:UIControlStateHighlighted];
    [self.imgPlayendCover addSubview:btnClose];
    self.btnClose = btnClose;
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)updateConstraints
{
    [self.imgPlayendCover mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.btnClose mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imgPlayendCover).mas_offset(kScale_H(StatusBarHeight)).priorityHigh();
        make.left.mas_greaterThanOrEqualTo(self.imgPlayendCover);
        make.right.mas_equalTo(self.imgPlayendCover).mas_offset(kScale_W(-5)).priorityHigh();
        make.width.height.mas_equalTo(kScale_W(30));
    }];
    
    [super updateConstraints];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
}


#pragma mark - Event

- (void)clickEvent:(UITapGestureRecognizer*)sender
{
        //获取触发触摸的点
        CGPoint cpBegain = [sender locationInView:self];
        CGPoint cpBegainResult = [self convertPoint:cpBegain toView:[UIApplication sharedApplication].keyWindow];//相对于屏幕的坐标
        if (self.quysAdviceClickEventBlockItem)
        {
            self.quysAdviceClickEventBlockItem(cpBegainResult);
        }
}

/// 关闭广告
/// @param sender UIButton
- (void)clickCloseBtEvent:(UIButton*)sender
{
    if (self.quysAdviceCloseEventBlockItem)
    {
        self.quysAdviceCloseEventBlockItem();
    }
}


//根据：runtime消息传递机制，子类先找到function的selector，然后直接调用实现（覆盖了：父类以及父类的类别）
- (void)hlj_viewStatisticalCallBack
{
    
    if (self.quysAdviceStatisticalCallBackBlockItem)
           {
               self.quysAdviceStatisticalCallBackBlockItem();
           }
}

- (void)setStrImageUrl:(NSString *)strImageUrl
{
    _strImageUrl = strImageUrl;
    [self.imgPlayendCover sd_setImageWithURL:[NSURL URLWithString:strImageUrl] placeholderImage:nil];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
@end
