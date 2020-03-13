//
//  QuysUploadStatisticsModel.h
//  quysAdvice
//
//  Created by quys on 2019/12/16.
//  Copyright © 2019 Quys. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
///上报统计模型
@interface QuysUploadStatisticsModel : NSObject
@property (nonatomic,assign) BOOL exposured;//!<是否已经曝光
@property (nonatomic,assign) BOOL clicked;//!<是否已经点击

@property (nonatomic,assign) BOOL playStart;//!<播放
@property (nonatomic,assign) BOOL playEnd;


@property (nonatomic,assign) BOOL downloadStart;//!<下载
@property (nonatomic,assign) BOOL downloadComplete;


@property (nonatomic,assign) BOOL loadSucess;//!<加载
@property (nonatomic,assign) BOOL loadFail;

@property (nonatomic,assign) BOOL closeMute;//!< 静音
@property (nonatomic,assign) BOOL mute;


@property (nonatomic,assign) BOOL suspend;//!< 暂停
@property (nonatomic,assign) BOOL resume;

@property (nonatomic,assign) BOOL interrupt;//!< 中途关闭


//落地页
@property (nonatomic,assign) BOOL endViewExposured;//!<是否已经曝光
@property (nonatomic,assign) BOOL endViewClicked;//!<是否已经点击
@property (nonatomic,assign) BOOL endViewClosed;//!<是否已经关闭



@end

NS_ASSUME_NONNULL_END
