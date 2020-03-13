//
//  QuysUploadApiTaskManager.h
//  quysAdvice
//
//  Created by quys on 2019/12/16.
//  Copyright © 2019 Quys. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
///上报任务管理单例
@interface QuysUploadApiTaskManager : NSObject
+ (instancetype)shareManager;

- (void)addTaskUrls:(NSArray*)arrUrlArr;
@end

NS_ASSUME_NONNULL_END
