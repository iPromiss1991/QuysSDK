
//
//  QuysVideoCoverView.m
//  quysAdvice
//
//  Created by quys on 2020/3/3.
//  Copyright © 2020 Quys. All rights reserved.
//

#import "QuysVideoCoverView.h"
@interface QuysVideoCoverView()
@property (nonatomic,strong) UIView *viewContain;
@property (nonatomic,strong) UIButton *btnVoice;
@property (nonatomic,strong) UIButton *btnClose;



@property (nonatomic,assign) NSInteger countdownLeft;
@property (nonatomic,strong) dispatch_source_t source_t;


@end


@implementation QuysVideoCoverView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self hlj_setTrackTag:kStringFormat(@"%lud",[self hash]) position:0 trackData:@{}];
        [self createUI];
     }
    return self;
}


- (void)createUI
{
    UIView *viewContain = [[UIView alloc]initWithFrame:self.frame];
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageVIewEvent:)];
    [self addGestureRecognizer:tap];
    [self addSubview:viewContain];
    self.viewContain = viewContain;
    
    UIButton *btnVoice = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnVoice addTarget:self action:@selector(clickVoiceBtEvent:) forControlEvents:UIControlEventTouchUpInside];
    [btnVoice setImage:[UIImage imageNamed:@"shengyin" inBundle:MYBUNDLE compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    [btnVoice setImage:[UIImage imageNamed:@"shengyin" inBundle:MYBUNDLE compatibleWithTraitCollection:nil] forState:UIControlStateHighlighted];    [btnVoice setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.viewContain addSubview:btnVoice];
    self.btnVoice = btnVoice;
    
    UIButton *btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnClose setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    btnClose.backgroundColor = kRGB16(BackgroundColor1, .7);
    [btnClose addTarget:self action:@selector(clickCloseBtEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewContain addSubview:btnClose];
    self.btnClose = btnClose;
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)updateConstraints
{
    [self.viewContain mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
        make.height.mas_equalTo(kScale_H(100));
    }];
    
    [self.btnVoice mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.viewContain).offset(kScale_H(20));
        make.left.mas_equalTo(self.viewContain).offset(kScale_W(20));
        make.height.mas_equalTo(kScale_H(44));
        make.width.mas_equalTo(kScale_W(60));
    }];
    
    [self.btnClose mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.viewContain).offset(kScale_H(20));
        make.left.mas_equalTo(self.btnVoice.mas_right).offset(kScale_W(20)).priorityMedium();
        make.height.mas_equalTo(kScale_H(44));
        make.width.mas_greaterThanOrEqualTo(kScale_W(60));
        make.right.mas_equalTo(self.viewContain).offset(-kScale_W(20)).priorityHigh();
    }];
    
    [super updateConstraints];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    kViewRadius(self.btnClose, kScale_H(10));
    
    
}


#pragma mark - Category覆写


//根据：runtime消息传递机制，子类先找到function的selector，然后直接调用实现（覆盖了：父类以及父类的类别）
- (void)hlj_viewStatisticalCallBack
{
    //倒计时
    [self countdownEvevt];
    if (self.quysAdviceStatisticalCallBackBlockItem)
    {
        self.quysAdviceStatisticalCallBackBlockItem();
    }
}



#pragma mark - event

- (void)tapImageVIewEvent:(UITapGestureRecognizer*)sender
{
    //获取触发触摸的点
    CGPoint cpBegain = [sender locationInView:self];
    CGPoint cpBegainResult = [self convertPoint:cpBegain toView:[UIApplication sharedApplication].keyWindow];//相对于屏幕的坐标
    if (self.quysAdviceClickEventBlockItem)
    {
        self.quysAdviceClickEventBlockItem(cpBegainResult);
    }
}

- (void)clickCloseBtEvent:(UIButton*)sender
{
    [[NSNotificationCenter defaultCenter ] postNotificationName:kRemoveOpenScreenBackgroundImageViewNotify object:nil];
    if (self.quysAdviceCloseEventBlockItem)
    {
        self.quysAdviceCloseEventBlockItem();
    }
}

- (void)clickVoiceBtEvent:(UIButton*)sender
{
    sender.selected = !sender.selected;
    if (sender.selected)
    {
        [sender setImage:[UIImage imageNamed:@"jingyin" inBundle:MYBUNDLE compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"jingyin" inBundle:MYBUNDLE compatibleWithTraitCollection:nil] forState:UIControlStateHighlighted];
    }else
    {
        [sender setImage:[UIImage imageNamed:@"shengyin" inBundle:MYBUNDLE compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"shengyin" inBundle:MYBUNDLE compatibleWithTraitCollection:nil] forState:UIControlStateHighlighted];
    }
    if (self.quysAdviceVoiceEventBlockItem)
    {
        self.quysAdviceVoiceEventBlockItem(!sender.selected);
    }
}

- (void)countdownEvevt
{
    
    kWeakSelf(self)
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if (self.countdownLeft >= 1)
        {
            weakself.countdownLeft--;
            NSString *strCountdownLeft = kStringFormat(@"%lds",weakself.countdownLeft);
            NSString *strDesc = kStringFormat(@"%@",@"跳过");
            NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:kStringFormat(@"%@%@",strCountdownLeft,strDesc)];
            [attr addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:20]} range:NSMakeRange(0, strCountdownLeft.length)];
            [attr addAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:10]} range:NSMakeRange(strCountdownLeft.length, strDesc.length)];
            [weakself.btnClose setAttributedTitle:attr forState:UIControlStateNormal];
        }else
        {
            dispatch_source_cancel(weakself.source_t );
            [weakself.btnClose setAttributedTitle:nil forState:UIControlStateNormal];
            [weakself clickCloseBtEvent:nil];
            [[NSNotificationCenter defaultCenter ] postNotificationName:kRemoveOpenScreenBackgroundImageViewNotify object:nil];
        }
        
    });
    dispatch_resume(timer);
    self.source_t = timer;
    
}


- (void)setShowDuration:(NSInteger)showDuration
{
    _showDuration = showDuration;
    self.countdownLeft = showDuration;
}

@end
