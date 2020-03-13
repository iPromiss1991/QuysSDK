//
//  QuysIncentiveVideoDataModel.h
//  quysAdvice
//
//  Created by quys on 2019/12/31.
//  Copyright © 2019 Quys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuysUploadStatisticsModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface QuysVideoCheckPoint: NSObject
@property (nonatomic , strong) NSArray <NSString *>              * urls;
@property (nonatomic,assign) CGFloat checkPoint;
@property (nonatomic,assign) BOOL isReported;


@end




@interface QuysIncentiveVideoDataModel : NSObject
@property (nonatomic , copy) NSString              * channel;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , assign) NSInteger              createTime;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * pkgName;
@property (nonatomic , assign) NSInteger              clickPosition;
@property (nonatomic , copy) NSString              * videoUrl;
@property (nonatomic , assign) BOOL              isClickable;//!< *视频播放中是否可以点击上报 (true:可以，false:不可以)，false情况下播放中不允许点击上报
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , copy) NSString              * videoDuration;
@property (nonatomic , copy) NSString              * videoWidth;
@property (nonatomic , copy) NSString              * videoHeight;
@property (nonatomic , copy) NSString              * videoSize;
@property (nonatomic , assign) BOOL              isDownLoadType;
@property (nonatomic , assign) BOOL              isAutoLanding;
@property (nonatomic , copy) NSString              * fileUrl;
@property (nonatomic , copy) NSString              * landingPageUrl;
@property (nonatomic , assign) BOOL              isReportRepeatAble;
@property (nonatomic , assign) QuysAdviceVideoEndShowType              videoEndShowType;
@property (nonatomic , copy) NSString              * videoEndShowValue;

@property (nonatomic , strong) NSArray <NSString *>              * reportVideoShowUrl;
@property (nonatomic , strong) NSArray <NSString *>              * reportVideoClickUrl;
@property (nonatomic , strong) NSArray <NSString *>              * reportVideoStartUrl;
@property (nonatomic , strong) NSArray <NSString *>              * reportVideoCloseUrl;
@property (nonatomic , strong) NSArray <NSString *>              * reportVideoSkipUrl;
@property (nonatomic , strong) NSArray <NSString *>              * reportVideoEndUrl;
@property (nonatomic , strong) NSArray <NSString *>              * reportLandingPageShowUrl;
@property (nonatomic , strong) NSArray <NSString *>              * reportLandingPageClickUrl;
@property (nonatomic , strong) NSArray <NSString *>              * reportLandingPageCloseUrl;
@property (nonatomic , strong) NSArray <NSString *>              * reportDownBeginLoadUrl;
@property (nonatomic , strong) NSArray <NSString *>              * reportDownloadCompleteUrl;
@property (nonatomic , strong) NSArray <NSString *>              * reportInstallBeginLoadUrl;
@property (nonatomic , strong) NSArray <NSString *>              * reportInstallCompleteUrl;
@property (nonatomic , strong) NSArray <NSString *>              * reportVideoLoadSuccessUrl;
@property (nonatomic , strong) NSArray <NSString *>              * reportVideoLoadErrorUrl;
@property (nonatomic , strong) NSArray <NSString *>              * reportVideoMuteUrl;
@property (nonatomic , strong) NSArray <NSString *>              * reportVideoUnMuteUrl;
@property (nonatomic , strong) NSArray <NSString *>              * reportAppActivationUrl;
@property (nonatomic , strong) NSArray <QuysVideoCheckPoint *>              * videoCheckPointList;//
@property (nonatomic , strong) NSArray <NSString *>              * reportVideoPauseUrl;
@property (nonatomic , strong) NSArray <NSString *>              * reportVideoContinueUrl;
@property (nonatomic , strong) NSArray <NSString *>              * reportVideoFullScreenUrl;
@property (nonatomic , strong) NSArray <NSString *>              * reportVideoUnFullScreenUrl;
@property (nonatomic , strong) NSArray <NSString *>              * reportVideoInterruptUrl;
@property (nonatomic , strong) NSArray <NSString *>              * reportDeeplinkSuccessUrl;
@property (nonatomic , strong) NSArray <NSString *>              * reportDeeplinkFailUrl;
@property (nonatomic , copy) NSString              * icon;
@property (nonatomic , copy) NSString              * desc;
@property (nonatomic , copy) NSString              * dplnk;//!< 跳转app（ios：不需要实现）

@property (nonatomic,strong) QuysUploadStatisticsModel *statisticsModel;//!<上报统计模型
@property (nonatomic,assign) BOOL clickeUploadEnable;//!< 是否触上报事件
@property (nonatomic,assign) BOOL exposuredUploadEnable;

@property (nonatomic,assign) BOOL playStartUploadEnable;//!<  播放
@property (nonatomic,assign) BOOL playEndUploadEnable;

@property (nonatomic,assign) BOOL downloadStartUploadEnable;//!<  下载
@property (nonatomic,assign) BOOL downloadCompleteUploadEnable;

@property (nonatomic,assign) BOOL loadSucessUploadEnable;//!<  加载
@property (nonatomic,assign) BOOL loadFailUploadEnable;

@property (nonatomic,assign) BOOL closeMuteUploadEnable;//!< 静音
@property (nonatomic,assign) BOOL muteUploadEnable;



@property (nonatomic,assign) BOOL suspendMuteUploadEnable;//!< 暂停
@property (nonatomic,assign) BOOL resumUploadEnable;

@property (nonatomic,assign) BOOL interruptUploadEnable;//!< 跳过
 

//尾帧
@property (nonatomic,assign) BOOL endViewClickeUploadEnable;//!< 尾帧是否触上报事件
@property (nonatomic,assign) BOOL endViewExposuredUploadEnable;
@property (nonatomic,assign) BOOL endViewClosedUploadEnable;


@end

NS_ASSUME_NONNULL_END
