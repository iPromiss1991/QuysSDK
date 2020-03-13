//
//  QuysAdSplash.m
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysAdOpenScreenDefaultView.h"
@interface QuysAdOpenScreenDefaultView()
@property (nonatomic,strong) UIView *viewContain;
@property (nonatomic,strong) UIImageView *imgView;

@property (nonatomic,strong) UIButton *btnClose;

@property (nonatomic,strong) UIView *viewBottomContain;
@property (nonatomic,strong) UIImageView *imgSmallIcon;
@property (nonatomic,strong) UILabel *lblContent;
@property (nonatomic,strong) UIImageView *imgLogo;

@property (nonatomic,assign) NSInteger countdownLeft;
@property (nonatomic,strong) dispatch_source_t source_t;


@end


@implementation QuysAdOpenScreenDefaultView

- (instancetype)initWithFrame:(CGRect)frame viewModel:(QuysAdOpenScreenVM *)viewModel
{
    if (self = [super initWithFrame:frame])
    {
        [self hlj_setTrackTag:kStringFormat(@"%lud",[self hash]) position:0 trackData:@{}];
        [self createUI];
        self.vm = viewModel;
    }
    return self;
}

- (void)createUI
{
    UIView *viewContain = [[UIView alloc]initWithFrame:self.frame];
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageVIewEvent:)];
    [viewContain addGestureRecognizer:tap];
    [self addSubview:viewContain];
    self.viewContain = viewContain;
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"" ]];
    imgView.userInteractionEnabled = YES;
    [self.viewContain addSubview:imgView];
    self.imgView = imgView;
    
    UIButton *btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnClose setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    btnClose.backgroundColor = kRGB16(BackgroundColor1, .7);
    [btnClose addTarget:self action:@selector(clickCloseBtEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewContain addSubview:btnClose];
    self.btnClose = btnClose;
    
    
    UIView *viewBottomContain = [[UIView alloc] init];
    viewBottomContain.backgroundColor = kRGB16(MaskColor1, .4);
    [self.viewContain addSubview:viewBottomContain];
    self.viewBottomContain = viewBottomContain;
    
    UIImageView *imgSmallIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    [imgSmallIcon setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    imgSmallIcon.userInteractionEnabled = YES;
    [self.viewBottomContain addSubview:imgSmallIcon];
    self.imgSmallIcon = imgSmallIcon;
    
    UILabel *lblContent = [[UILabel alloc] init];
    lblContent.numberOfLines = 0;
    lblContent.text = @"文案";
    [lblContent setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
    [lblContent setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    self.lblContent = lblContent;
    [self.viewBottomContain addSubview:lblContent];
    
    
    UIImageView *imgLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    imgLogo.userInteractionEnabled = YES;
    [self.viewBottomContain addSubview:imgLogo];
    self.imgLogo = imgLogo;
    
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)updateConstraints
{
    [self.viewContain mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    [self.imgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.viewContain);
    }];
    
    [self.btnClose mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.viewContain).mas_offset(kScale_H(StatusBarHeight)).priorityHigh();
        make.left.mas_greaterThanOrEqualTo(self.viewContain);
        make.right.mas_equalTo(self.viewContain).mas_offset(kScale_W(-20));
        make.width.mas_greaterThanOrEqualTo(kScale_W(60)).priorityHigh();
        make.height.mas_equalTo(kScale_W(22)).priorityHigh();
        make.bottom.mas_lessThanOrEqualTo(self.viewContain).priorityHigh();
    }];
    
    
    [self.viewBottomContain mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.viewContain);
        make.top.mas_greaterThanOrEqualTo(self.viewContain.mas_bottom).offset(-kScale_H(200));
    }];
    
    [self.imgSmallIcon mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_greaterThanOrEqualTo(self.viewBottomContain).offset(kScale_H(5));
        make.left.mas_equalTo(self.viewBottomContain).mas_offset(kScale_W(20)).priorityHigh();
        make.bottom.mas_equalTo(self.viewBottomContain).mas_offset(kScale_H(-20));
        make.width.height.mas_equalTo(kScale_W(60));
    }];
    
    [self.lblContent mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_greaterThanOrEqualTo(self.viewBottomContain).offset(kScale_H(5));
        make.left.mas_equalTo(self.imgSmallIcon.mas_right).mas_offset(kScale_W(5));
        make.bottom.mas_lessThanOrEqualTo(self.viewBottomContain).mas_offset(kScale_H(-10));
    }];
    
    
    [self.imgLogo mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.imgSmallIcon).priorityHigh();
        make.left.mas_equalTo(self.lblContent.mas_right).mas_offset(kScale_W(5));
        make.right.mas_equalTo(self.viewBottomContain).mas_offset(kScale_W(-20)).priorityHigh();
        make.width.height.mas_equalTo(kScale_W(60));
    }];
    
    
    [super updateConstraints];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    kViewRadius(self.btnClose, kScale_H(10));
    
    
}


#pragma mark - PrivateMethod

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

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
            weakself.btnClose.titleLabel.attributedText = nil;
            if (self.vm.closeWindowEnable)
            {
                 [[NSNotificationCenter defaultCenter ] postNotificationName:kRemoveOpenScreenBackgroundImageViewNotify object:nil];
            }
        }
        
    });
    dispatch_resume(timer);
    self.source_t = timer;
}

- (void)setVm:(QuysAdOpenScreenVM *)vm
{
    _vm = vm;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:vm.strImgUrl]];
    [self.imgSmallIcon sd_setImageWithURL:[NSURL URLWithString:vm.strImgUrl]];
    [self.imgLogo sd_setImageWithURL:[NSURL URLWithString:vm.strImgUrl]];
    [self.lblContent setText:vm.title];
    self.countdownLeft = vm.showDuration;
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)dealloc
{
    
}

@end
