//
//  QuysAdSplash.m
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysIncentiveVideo.h"
#import "QuysVideoPlayerView.h"
#import "QuysImgPlayendCoverView.h"
@interface QuysIncentiveVideo()<QuysVideoPlayerDelegate>
@property (nonatomic,strong) UIView *viewContain;

@property (nonatomic,strong) UIButton *btnCounntdown;//!< 倒计时
@property (nonatomic,strong) UIButton *btnClose;

@property (nonatomic,strong) QuysVideoPlayerView *playerView;
@property (nonatomic,strong) QuysImgPlayendCoverView *imgPlayendCover;


@property (nonatomic,strong) UIView *viewFootContain;
@property (nonatomic,strong) UILabel *lblTitle;
@property (nonatomic,strong) UIImageView *imgLogo;
@property (nonatomic,strong) UILabel *lblContent;
@property (nonatomic,strong) UIButton *btnVoice;//!< 声音

//倒计时
@property (nonatomic,assign) NSInteger countdownLeft;


@end

@implementation QuysIncentiveVideo

- (instancetype)initWithFrame:(CGRect)frame viewModel:(QuysIncentiveVideoVM *)viewModel
{
    if (self = [super initWithFrame:frame])
    {
        [self hlj_setTrackTag:kStringFormat(@"%lud",(unsigned long)[self hash]) position:0 trackData:@{}];
        [self createUI];
        self.viewContain.hlj_viewVisible = YES;
        self.vm = viewModel;
    }
    return self;
}

- (void)createUI
{
    self.backgroundColor = [UIColor whiteColor];
    UIView *viewContain = [[UIView alloc]initWithFrame:CGRectZero];
    [self addSubview:viewContain];
    self.viewContain = viewContain;
    
    
    QuysVideoPlayerView *playerView = [[QuysVideoPlayerView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    playerView.delegate = self;
    [playerView hlj_setTrackTag:kStringFormat(@"%lud",[playerView hash]) position:0 trackData:@{}];
     UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageVIewEvent:)];
    [playerView addGestureRecognizer:tap];
    [self.viewContain addSubview:playerView];
    self.playerView = playerView;
    
    UIButton *btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnClose addTarget:self action:@selector(clickCloseBtEvent:) forControlEvents:UIControlEventTouchUpInside];
    [btnClose setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btnClose setImage:[UIImage imageNamed:@"guanbi" inBundle:MYBUNDLE compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    [btnClose setImage:[UIImage imageNamed:@"guanbi_press" inBundle:MYBUNDLE compatibleWithTraitCollection:nil] forState:UIControlStateHighlighted];
    [self.viewContain addSubview:btnClose];
    self.btnClose = btnClose;
    
    UIButton *btnCounntdown = [UIButton buttonWithType:UIButtonTypeCustom];
    btnCounntdown.userInteractionEnabled = NO;
    btnCounntdown.hidden = YES;
    [btnCounntdown setBackgroundColor:kRGB16(BackgroundColor1, .7)];
    [btnCounntdown setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.viewContain addSubview:btnCounntdown];
    self.btnCounntdown = btnCounntdown;
    
    //
    UIView *viewFootContain = [[UIView alloc]initWithFrame:self.frame];
    viewFootContain.backgroundColor = kRGB16(BackgroundColor1, .7);
     [self.viewContain addSubview:viewFootContain];
    self.viewFootContain = viewFootContain;
    
    UIImageView *imgLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    imgLogo.userInteractionEnabled = YES;
    [self.viewFootContain addSubview:imgLogo];
    self.imgLogo = imgLogo;
    
    UILabel *lblTitle = [[UILabel alloc] init];
       lblTitle.numberOfLines = 1;
    lblTitle.textAlignment =NSTextAlignmentCenter;
       lblTitle.text = @"文案";
       [lblTitle setFont:kScaleFont(17)];
       [lblTitle setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
       [lblTitle setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
       self.lblTitle = lblTitle;
       [self.viewFootContain addSubview:lblTitle];
    
    UILabel *lblContent = [[UILabel alloc] init];
    lblContent.numberOfLines = 3;
    lblContent.text = @"文案";
    [lblContent setFont:kScaleFont(15)];
    [lblContent setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [lblContent setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    self.lblContent = lblContent;
    [self.viewFootContain addSubview:lblContent];
    
    UIButton *btnVoice = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnVoice addTarget:self action:@selector(clickVoiceBtEvent:) forControlEvents:UIControlEventTouchUpInside];
    [btnVoice setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btnVoice setImage:[UIImage imageNamed:@"shengyin" inBundle:MYBUNDLE compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    [btnVoice setImage:[UIImage imageNamed:@"shengyin" inBundle:MYBUNDLE compatibleWithTraitCollection:nil] forState:UIControlStateHighlighted];
    [self.viewFootContain addSubview:btnVoice];
    self.btnVoice = btnVoice;
    
    QuysImgPlayendCoverView *imgPlayendCover = [[QuysImgPlayendCoverView alloc] init];
    [imgPlayendCover hlj_setTrackTag:kStringFormat(@"%lud",[imgPlayendCover hash]) position:0 trackData:@{}];
    imgPlayendCover.userInteractionEnabled = YES;
    imgPlayendCover.hidden = YES;
    [imgPlayendCover hlj_setTrackTag:kStringFormat(@"%lud",[imgPlayendCover hash]) position:0 trackData:@{}];
    [self.viewContain addSubview:imgPlayendCover];
    self.imgPlayendCover = imgPlayendCover;
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)updateConstraints
{
    [self.viewContain mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    [self.btnCounntdown mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.btnClose);
        make.left.mas_equalTo(self.viewContain).offset(kScale_W(20));
        make.width.height.mas_equalTo(kScale_W(40));
    }];
    
    [self.btnClose mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.viewContain).mas_offset(kScale_H(StatusBarHeight)).priorityHigh();
        make.left.mas_greaterThanOrEqualTo(self.btnCounntdown.mas_right);
        make.right.mas_equalTo(self.viewContain).mas_offset(kScale_W(-5));
        make.width.height.mas_equalTo(kScale_W(30));
    }];
    
    [self.playerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.viewContain).priorityHigh();
        make.left.right.mas_equalTo(self.viewContain);
    }];
    
    [self.imgPlayendCover mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.viewContain);
    }];
    
    [self.viewFootContain mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.playerView.mas_bottom).priorityHigh();
        make.left.right.bottom.mas_equalTo(self.viewContain);
        make.height.mas_equalTo(kScale_H(100)).priorityHigh();
    }];
    
    [self.lblTitle mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.viewFootContain).offset(2);
        make.right.mas_equalTo(self.viewFootContain).offset(-2);
        make.top.mas_equalTo(self.viewFootContain).offset(1);
    }];
    
    [self.imgLogo mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lblTitle.mas_bottom).offset(1);
        make.left.mas_equalTo(self.viewFootContain).mas_offset(kScale_W(5));
        make.width.height.mas_equalTo(kScale_W(60));
        make.bottom.mas_lessThanOrEqualTo(self.viewFootContain);
    }];
    
    [self.lblContent mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lblTitle.mas_bottom).mas_offset(kScale_H(5));
        make.left.mas_equalTo(self.imgLogo.mas_right).mas_offset(kScale_W(5));
        make.bottom.mas_equalTo(self.viewFootContain).mas_offset(kScale_H(-5));
    }];
    
    [self.btnVoice mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.imgLogo).priorityHigh();
        make.left.mas_equalTo(self.lblContent.mas_right).mas_offset(kScale_W(5)).priorityMedium();
        make.right.mas_equalTo(self.viewFootContain).mas_offset(kScale_W(-5)).priorityHigh();
        make.width.height.mas_equalTo(kScale_W(30));
    }];
    
    
    [super updateConstraints];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    kViewRadius(self.btnCounntdown, kScale_H(20));
    
}


#pragma mark - PrivateMethod

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)tapImageVIewEvent:(UITapGestureRecognizer*)sender
{
    //当播放时点击触发playStatesChanged，弹出QuysVidoePlayButtonView会拦截点击事件，所以该方法仅需要处理播放时的点击事件，即可。
    if (self.playerView.player.rate)
    {
         if (self.vm.isClickable )
         {
             //获取触发触摸的点
             CGPoint cpBegain = [sender locationInView:self];
             CGPoint cpBegainResult = [self convertPoint:cpBegain toView:[UIApplication sharedApplication].keyWindow];//相对于屏幕的坐标
             if (self.quysAdviceClickEventBlockItem)
             {
                 self.quysAdviceClickEventBlockItem(cpBegainResult);
             }
         }
        [self playStatesChanged];
    }else
    {
        
    }
}


/// 关闭广告
/// @param sender UIButton
- (void)clickCloseBtEvent:(UIButton*)sender
{
    [self closeAndRemovePlayer];
    if (self.quysAdviceCloseEventBlockItem)
    {
        self.quysAdviceCloseEventBlockItem();
    }
}

- (void)closeAndRemovePlayer
{
    [[NSNotificationCenter defaultCenter ] postNotificationName:kAVPlayerItemDidRemoveNotification object:nil];
    [[NSNotificationCenter defaultCenter ] postNotificationName:kRemoveIncentiveBackgroundImageViewNotify object:nil];
}

/// 静音设置
/// @param sender UIButton
- (void)clickVoiceBtEvent:(UIButton*)sender
{
    sender.selected = !sender.selected;
    if (sender.selected)
    {
        [self.btnVoice setImage:[UIImage imageNamed:@"jingyin" inBundle:MYBUNDLE compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
        [self.btnVoice setImage:[UIImage imageNamed:@"jingyin" inBundle:MYBUNDLE compatibleWithTraitCollection:nil] forState:UIControlStateHighlighted];
    }else
    {
        [self.btnVoice setImage:[UIImage imageNamed:@"shengyin" inBundle:MYBUNDLE compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
        [self.btnVoice setImage:[UIImage imageNamed:@"shengyin" inBundle:MYBUNDLE compatibleWithTraitCollection:nil] forState:UIControlStateHighlighted];
    }
    [self.playerView setMute];
}


//根据：runtime消息传递机制，子类先找到function的selector，然后直接调用实现（覆盖了：父类以及父类的类别）
- (void)hlj_viewStatisticalCallBack
{
    //倒计时
    if (self.quysAdviceStatisticalCallBackBlockItem)
    {
        self.quysAdviceStatisticalCallBackBlockItem();
    }
}


- (void)countdownEvevt
{
    kWeakSelf(self)
    if (self.countdownLeft >= 1)
    {
        weakself.btnCounntdown.hidden = NO;
        [weakself.btnCounntdown setTitle:kStringFormat(@"%lds",weakself.countdownLeft) forState:UIControlStateNormal];
        [weakself.btnCounntdown setTitle:kStringFormat(@"%lds",weakself.countdownLeft) forState:UIControlStateHighlighted];
    }else
    {
        weakself.btnCounntdown.hidden = YES;
        [weakself.btnCounntdown setTitle:kStringFormat(@"0s") forState:UIControlStateNormal];
        [weakself.btnCounntdown setTitle:kStringFormat(@"0s") forState:UIControlStateHighlighted];
        if (self.vm.videoEndShowValue)
        {
            switch (self.vm.videoEndShowType)
            {
                case QuysAdviceVideoEndShowTypeNone:
                {
                     self.imgPlayendCover.hidden = YES;
                }
                    break;
                case QuysAdviceVideoEndShowTypeImageUrl:
                {
                    self.imgPlayendCover.strImageUrl = self.vm.videoEndShowValue;
                    self.imgPlayendCover.hidden = NO;
                }
                    break;
                case QuysAdviceVideoEndShowTypeHtmlCode:
                {
                    if (self.quysAdvicePlayEndCallBackBlockItem) {
                        self.quysAdvicePlayEndCallBackBlockItem(QuysAdviceVideoEndShowTypeHtmlCode);
                    }
                }
                    break;
                case QuysAdviceVideoEndShowTypeHtmlUrl:
                {     if (self.quysAdvicePlayEndCallBackBlockItem) {
                    self.quysAdvicePlayEndCallBackBlockItem(QuysAdviceVideoEndShowTypeHtmlUrl);
                }
                    
                }
                    break;
                    
                default:
                    break;
            }
        }else
        {
            self.imgPlayendCover.strImageUrl = self.vm.videoAlternateEndShowValue;
            self.imgPlayendCover.hidden = NO;
        }
    }
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)playStatesChanged
{
    
    [self.playerView playStatesChanged];
    
}


 

#pragma mark -QuysVideoPlayerDelegate

//进度
- (void)quys_videoPlay:(NSDictionary *)playItemInfo isCorrectStatus:(BOOL)status
{
    if (status)
    {
        NSInteger totalTime = [self translateMediaTimeToSeconds:playItemInfo[kAVPlayerItemTotalTime]];
        NSInteger currentTime = [self translateMediaTimeToSeconds:playItemInfo[kAVPlayerItemCurrentTime]];
        self.countdownLeft = totalTime - currentTime;
        [self countdownEvevt];
        
        if (self.quysAdviceProgressEventBlockItem)
        {
            NSInteger progress = (currentTime/(CGFloat)totalTime)*100;
            self.quysAdviceProgressEventBlockItem(progress);
        }
    }
}

- (NSInteger)translateMediaTimeToSeconds:(NSString*)mediaTime
{
    NSArray *arrTimes = [mediaTime componentsSeparatedByString:@":"];
    NSInteger totalTime ;
    if (arrTimes.count == 2)
    {
        totalTime = [arrTimes[0] integerValue]*60 + [arrTimes[1] integerValue] ;
    }else
    {
        totalTime = [arrTimes[0] integerValue];
    }
    return totalTime;
}

- (void)setVm:(QuysIncentiveVideoVM *)vm
{
    _vm = vm;
    self.lblTitle.text = vm.strTitle;
    [self.lblContent setText:vm.desc];
    [self.imgLogo sd_setImageWithURL:[NSURL URLWithString:vm.strImgUrl]];
    
    if (kISNullString(vm.strTitle) & kISNullString(vm.strImgUrl))
    {
        self.viewFootContain.backgroundColor = [UIColor clearColor];
    }
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)updateBlockItemsAndPalyStart
{
    kWeakSelf(self)
    self.playerView.quysAdvicePlayStartCallBackBlockItem = ^{
        weakself.quysAdvicePlayStartCallBackBlockItem();
    };
    self.playerView.quysAdviceLoadSucessCallBackBlockItem = self.quysAdviceLoadSucessCallBackBlockItem;
    self.playerView.quysAdviceLoadFailCallBackBlockItem = self.quysAdviceLoadFailCallBackBlockItem;
    
    self.playerView.quysAdviceMuteCallBackBlockItem = self.quysAdviceMuteCallBackBlockItem;
    self.playerView.quysAdviceCloseMuteCallBackBlockItem = self.quysAdviceCloseMuteCallBackBlockItem;
    
    self.playerView.quysAdviceSuspendCallBackBlockItem = self.quysAdviceSuspendCallBackBlockItem;
    self.playerView.quysAdvicePlayagainCallBackBlockItem = self.quysAdvicePlayagainCallBackBlockItem;
    
    
    //
    self.imgPlayendCover.quysAdviceStatisticalCallBackBlockItem = ^{
        //尾帧曝光
        weakself.quysAdviceEndViewStatisticalCallBackBlockItem();
    };
    
    self.imgPlayendCover.quysAdviceCloseEventBlockItem = ^{
        //尾帧关闭
        weakself.imgPlayendCover.hidden = YES;
        weakself.quysAdviceEndViewCloseEventBlockItem();
    };
    
    self.imgPlayendCover.quysAdviceClickEventBlockItem = ^(CGPoint cp) {
        //尾帧点击
        weakself.quysAdviceEndViewClickEventBlockItem(cp);
    };
    
    self.playerView.urlVideo = kStringFormat(@"%@",self.vm.videoUrl);
    self.playerView.quysAdviceStatisticalCallBackBlockItem = ^{
        //曝光
        
    };
    
}



- (void)dealloc
{
    
}



@end
