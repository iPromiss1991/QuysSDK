//
//  QuysIncentiveVideoDataModel.m
//  quysAdvice
//
//  Created by quys on 2019/12/31.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysIncentiveVideoDataModel.h"


@implementation QuysVideoCheckPoint



@end


@implementation QuysIncentiveVideoDataModel
////替换字符：
+ (NSDictionary *)modelCustomPropertyMapper {
    return
  @{
        @"desc" : @"description"
    };
}



+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"videoCheckPointList":[QuysVideoCheckPoint class]};
}

-(QuysUploadStatisticsModel *)statisticsModel
{
    if (_statisticsModel == nil) {
        _statisticsModel = [QuysUploadStatisticsModel new];
    }return _statisticsModel;
}


-(BOOL)clickeUploadEnable
{
    if (self.statisticsModel.clicked)
    {
        if (self.isReportRepeatAble)
        {
            return YES;
        }else
        {
            return NO;
        }
    }else
    {
        return YES;
    }
}

-(BOOL)exposuredUploadEnable
{
    if (self.statisticsModel.exposured)
    {
        if (self.isReportRepeatAble)
        {
            return YES;
        }else
        {
            return NO;
        }
    }else
    {
        return YES;
    }
}

- (BOOL)playStartUploadEnable
{
    if (self.statisticsModel.playStart)
    {
        if (self.isReportRepeatAble)
        {
            return YES;
        }else
        {
            return NO;
        }
    }else
    {
        return YES;
    }
}

- (BOOL)playEndUploadEnable
{
    if (self.statisticsModel.playEnd)
    {
        if (self.isReportRepeatAble)
        {
            return YES;
        }else
        {
            return NO;
        }
    }else
    {
        return YES;
    }
}


-(BOOL)downloadStartUploadEnable
{
    if (self.statisticsModel.downloadStart)
    {
        if (self.isReportRepeatAble)
        {
            return YES;
        }else
        {
            return NO;
        }
    }else
    {
        return YES;
    }
}


-(BOOL)downloadCompleteUploadEnable
{
    if (self.statisticsModel.downloadComplete)
    {
        if (self.isReportRepeatAble)
        {
            return YES;
        }else
        {
            return NO;
        }
    }else
    {
        return YES;
    }
}


-(BOOL)loadSucessUploadEnable
{
    if (self.statisticsModel.loadSucess)
    {
        if (self.isReportRepeatAble)
        {
            return YES;
        }else
        {
            return NO;
        }
    }else
    {
        return YES;
    }
}

-(BOOL)loadFailUploadEnable
{
    if (self.statisticsModel.loadFail)
    {
        if (self.isReportRepeatAble)
        {
            return YES;
        }else
        {
            return NO;
        }
    }else
    {
        return YES;
    }
}


-(BOOL)closeMuteUploadEnable
{
    if (self.statisticsModel.closeMute)
    {
        if (self.isReportRepeatAble)
        {
            return YES;
        }else
        {
            return NO;
        }
    }else
    {
        return YES;
    }
}

-(BOOL)muteUploadEnable
{
    if (self.statisticsModel.mute)
    {
        if (self.isReportRepeatAble)
        {
            return YES;
        }else
        {
            return NO;
        }
    }else
    {
        return YES;
    }
}

-(BOOL)suspendMuteUploadEnable
{
    if (self.statisticsModel.suspend)
    {
        if (self.isReportRepeatAble)
        {
            return YES;
        }else
        {
            return NO;
        }
    }else
    {
        return YES;
    }
}

-(BOOL)resumUploadEnable
{
    if (self.statisticsModel.resume)
    {
        if (self.isReportRepeatAble)
        {
            return YES;
        }else
        {
            return NO;
        }
    }else
    {
        return YES;
    }
}

-(BOOL)interruptUploadEnable
{
    if (self.statisticsModel.interrupt)
    {
        if (self.isReportRepeatAble)
        {
            return YES;
        }else
        {
            return NO;
        }
    }else
    {
        return YES;
    }
}

-(BOOL)endViewClickeUploadEnable
{
    if (self.statisticsModel.endViewClicked)
    {
        if (self.isReportRepeatAble)
        {
            return YES;
        }else
        {
            return NO;
        }
    }else
    {
        return YES;
    }
}


-(BOOL)endViewExposuredUploadEnable
{
    if (self.statisticsModel.endViewExposured)
    {
        if (self.isReportRepeatAble)
        {
            return YES;
        }else
        {
            return NO;
        }
    }else
    {
        return YES;
    }
}


-(BOOL)endViewClosedUploadEnable
{
    if (self.statisticsModel.endViewClosed)
    {
        if (self.isReportRepeatAble)
        {
            return YES;
        }else
        {
            return NO;
        }
    }else
    {
        return YES;
    }
}


@end
