//
//  QuysAdviceModel.h
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuysUploadStatisticsModel.h"
NS_ASSUME_NONNULL_BEGIN
/*素材类型:
 1-图片 2-图文 3-文字 4-html  5-信息流多图  6-大规格插屏(大 图)   7-图文（小图）  8-视频
 
*/

typedef NS_ENUM(NSInteger,QuysAdviceCreativeType) {
    QuysAdviceCreativeTypeDefault = 0,
    QuysAdviceCreativeTypePictureOnly = 1,
    QuysAdviceCreativeTypeImageAndText = 2,
    QuysAdviceCreativeTypeTextOnly = 3,
    QuysAdviceCreativeTypeHtml = 4,
    QuysAdviceCreativeTypeMultiPicture = 5,
    QuysAdviceCreativeTypeBigPicture = 6,
    QuysAdviceCreativeTypeSmallPicture = 7,
    QuysAdviceCreativeTypeVideo = 8
};

/*广告行为类型:
 1-html(源码)  2-图片url（web）  3-文字链*(html)  4-下载app*(下载地址)   5-android 应用市场下载  6-ios:appstore(下载地址)   8-请求下载地址，见4.8 请求下载类型处理方式
*/

typedef NS_ENUM(NSInteger,QuysAdviceActiveType) {
    QuysAdviceActiveTypeHtmlSourceCode = 1,
    QuysAdviceActiveTypeImageUrl = 2,
    QuysAdviceActiveTypeHtmlLink = 3,
    QuysAdviceActiveTypeDownAppAppstore = 4,
    QuysAdviceActiveTypeDownAppAppstoreSecond = 6,
    QuysAdviceActiveTypeDownAppWebUrl = 8,
};



///广告模型
@interface QuysAdviceModel : NSObject
@property (nonatomic , copy) NSString            * title;
@property (nonatomic , strong) NSArray <NSString *>              * clkTracking;
@property (nonatomic , strong) NSArray <NSString *>              * impTracking;
@property (nonatomic , strong) NSArray <NSString *>              * downStart;
@property (nonatomic , strong) NSArray <NSString *>              * downSuccess;
@property (nonatomic , strong) NSArray <NSString *>              * installStart;
@property (nonatomic , strong) NSArray <NSString *>              * installSuccess;
@property (nonatomic , strong) NSArray <NSString *>              * appStart;
@property (nonatomic , strong) NSArray <NSString *>              * videoStart;
@property (nonatomic , strong) NSArray <NSString *>              * videoSuccess;
@property (nonatomic , copy) NSString              * downUrl;
@property (nonatomic , assign) NSInteger              width;
@property (nonatomic , assign) NSInteger              height;
@property (nonatomic , copy) NSString              * channel;
@property (nonatomic , assign) NSInteger              channelWeight;
@property (nonatomic , copy) NSString              * iconUrl;
@property (nonatomic , copy) NSString              * intro;
@property (nonatomic , assign) NSInteger              adType;
@property (nonatomic , assign) QuysAdviceCreativeType              creativeType;
@property (nonatomic , copy) NSString              * desc;
@property (nonatomic , assign) NSInteger              clickPosition;
@property (nonatomic , strong) NSArray <NSString *>              * reportDeeplinkSuccessUrl;
@property (nonatomic , strong) NSArray <NSString *>              * reportDeeplinkFailUrl;
@property (nonatomic , assign) NSInteger              showDuration;
@property (nonatomic , copy) NSString              * materialUrl;
@property (nonatomic , copy) NSString              * videoCoverUrl;
@property (nonatomic , assign) NSInteger              videoDuration;
@property (nonatomic , copy) NSString              * appName;
@property (nonatomic , assign) QuysAdviceActiveType              ctype;
@property (nonatomic , assign) BOOL              isReportRepeatAble;

@property (nonatomic , copy) NSString              * imgUrl;
@property (nonatomic , copy) NSString              * ldp;
@property (nonatomic , strong) NSArray <NSString *>              * imgUrlList;

@property (nonatomic,strong) QuysUploadStatisticsModel *statisticsModel;//!<上报统计模型
@property (nonatomic , copy) NSString              * htmStr;

@property (nonatomic,assign) BOOL clickeUploadEnable;//!< 是否触上报事件
@property (nonatomic,assign) BOOL exposuredUploadEnable;

@end

NS_ASSUME_NONNULL_END
