//
//  QuysVideoContentView.m
//  quysAdvice
//
//  Created by quys on 2020/3/3.
//  Copyright © 2020 Quys. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import "QuysVideoContentView.h"
#import "QuysVideoCoverView.h"
@interface QuysVideoContentView()
@property (nonatomic,strong) AVPlayer *quysAvPlayer;
@property (nonatomic,strong) AVPlayerLayer *quysAvPalyerLayer;
@property (nonatomic,strong) AVPlayerItem *quysAvPlayerItem;

@property (nonatomic,strong) QuysVideoCoverView *coverView;


@end


@implementation QuysVideoContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        self.hlj_viewVisible = YES;
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    kWeakSelf(self)
    [self.layer addSublayer:self.quysAvPalyerLayer];

    QuysVideoCoverView *coverView = [[QuysVideoCoverView alloc] initWithFrame:CGRectZero];
    coverView.quysAdviceClickEventBlockItem = ^(CGPoint cp) {
        [weakself clickEvent:cp];
    };
    
    coverView.quysAdviceCloseEventBlockItem = ^{
        [weakself quys_remove];
        [weakself closeEvent];
    };
    
    coverView.quysAdviceVoiceEventBlockItem = ^(BOOL voiceEnable) {
    voiceEnable? (weakself.quysAvPlayer.volume = 1):(weakself.quysAvPlayer.volume = 0);
    };
    coverView.quysAdviceStatisticalCallBackBlockItem = ^{
        [weakself statisticalEvent];
    };

    self.coverView = coverView;
    [self addSubview:coverView];
    
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)updateConstraints
{
    [self.coverView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
     }];
    
    [super updateConstraints];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.quysAvPalyerLayer.frame = self.bounds;

    
}


#pragma mark - Event

- (void)quys_play
{
    if (self.quysAvPlayer.rate)
    {
        [self.quysAvPlayer pause];
    }else
    {
        [self.quysAvPlayer play];

    }
}

- (void)quys_remove
{
    if (self.quysAvPlayer)
    {
        [self.quysAvPlayer pause];
        [self.quysAvPalyerLayer removeFromSuperlayer];
        self.quysAvPalyerLayer = nil;
    }
}

#pragma mark - Blocks
- (void)clickEvent:(CGPoint)cp
{
    if (self.quysAdviceClickEventBlockItem)
    {
        self.quysAdviceClickEventBlockItem(cp);
    }
}

- (void)closeEvent
{
    self.frame = CGRectZero;
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    if (self.quysAdviceCloseEventBlockItem)
    {
        self.quysAdviceCloseEventBlockItem();
    }
}

- (void)statisticalEvent
{
    if (self.quysAdviceStatisticalCallBackBlockItem)
    {
        self.quysAdviceStatisticalCallBackBlockItem();
    }
}


- (void)setShowDuration:(NSInteger)showDuration
{
    _showDuration = showDuration;
    self.coverView.showDuration = showDuration;
}



#pragma mark - Init

- (AVPlayer *)quysAvPlayer
{
    if (_quysAvPlayer == nil) {
        _quysAvPlayer = [[AVPlayer alloc] init];
    }return _quysAvPlayer;
}

- (AVPlayerLayer *)quysAvPalyerLayer
{
    if (_quysAvPalyerLayer == nil) {
        _quysAvPalyerLayer = [AVPlayerLayer playerLayerWithPlayer:self.quysAvPlayer];
    }return _quysAvPalyerLayer;
}

- (AVPlayerItem *)quysAvPlayerItem
{
    if (_quysAvPlayerItem == nil) {
        _quysAvPlayerItem = [AVPlayerItem playerItemWithURL:self.quysPlayUrl];
    }return _quysAvPlayerItem;
}

- (void)setQuysPlayUrl:(NSURL *)quysPlayUrl
{
    _quysPlayUrl = quysPlayUrl;
    [self.quysAvPlayer replaceCurrentItemWithPlayerItem:self.quysAvPlayerItem];
    [self.quysAvPlayer play];
}




@end
