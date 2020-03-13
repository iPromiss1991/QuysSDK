//
//  QuysUploadApiTaskManager.m
//  quysAdvice
//
//  Created by quys on 2019/12/16.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysUploadApiTaskManager.h"

static const NSInteger AsyncThreadCount = 5;//线程同步最大并发数
@interface QuysUploadApiTaskManager()
@property (nonatomic,strong) dispatch_semaphore_t  semaphore;
@property (nonatomic,strong) dispatch_queue_t queue;


@end


@implementation QuysUploadApiTaskManager


+ (instancetype)shareManager
{
    static QuysUploadApiTaskManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[super allocWithZone:NULL] init];
        manager.semaphore = dispatch_semaphore_create(AsyncThreadCount);
        manager.queue = dispatch_queue_create("com.quys.advice", DISPATCH_QUEUE_CONCURRENT);
    });
    return manager;
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    return [QuysUploadApiTaskManager shareManager] ;
}
-(id) copyWithZone:(struct _NSZone *)zone
{
    return [QuysUploadApiTaskManager shareManager] ;
}

- (void)addTaskUrls:(NSArray *)arrUrlArr
{
    kWeakSelf(self);
    dispatch_async(self.queue, ^{
        {
            [arrUrlArr enumerateObjectsUsingBlock:^(NSString* obj, NSUInteger idx, BOOL * _Nonnull stop) {
                dispatch_semaphore_wait(self.semaphore, dispatch_time(DISPATCH_TIME_NOW, 5*NSEC_PER_SEC));//注意单位（NSEC_PER_SEC）：不设置NSEC_PER_SEC则可能无法实现同步
                //宏替换
                obj =  [weakself replaceSpecifiedString:obj];
                //发起网络请求
                NSURL *requestUrl = [NSURL URLWithString:kStringFormat(@"%@",obj)];
                NSURLSessionConfiguration *config= [NSURLSessionConfiguration defaultSessionConfiguration];
                NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
                NSURLSessionDataTask *task = [session dataTaskWithURL:requestUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                    NSLog(@"完成请求:%@==%@",obj,[NSThread currentThread]);
                    dispatch_semaphore_signal(self.semaphore);
                }];
                [task resume];
                NSLog(@"发起请求:%@==%@",obj,[NSThread currentThread]);
            }];
        }
    });
}

- (NSString*)replaceSpecifiedString:(NSString*)strForReplace
{
     
    return [[QuysAdviceManager shareManager] replaceSpecifiedString:strForReplace];
}

@end
