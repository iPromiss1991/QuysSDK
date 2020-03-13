//
//  QuysFileManager.m
//  quysAdvice
//
//  Created by quys on 2019/12/19.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysFileManager.h"

@implementation QuysFileManager


+ (instancetype)shareManager
{
    static QuysFileManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[super allocWithZone:NULL] init];
    });
    return manager;
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    return [QuysFileManager shareManager] ;
}
-(id) copyWithZone:(struct _NSZone *)zone
{
    return [QuysFileManager shareManager] ;
}

- (BOOL)isExsit:(NSString*)strPath
{
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isDirectory = NO;
    return   [fm fileExistsAtPath:strPath isDirectory:&isDirectory];
}

- (BOOL)isDirectory:(NSString*)strPath
{
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isDirectory = NO;
    BOOL isExist = [fm fileExistsAtPath:strPath isDirectory:&isDirectory];
    if (isExist)
    {
        return isDirectory;
    }else
    {
        return NO;
    }
}

- (BOOL)creatFile:(NSString*)filePath
{
    if (filePath.length==0)
    {
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath])
    {
        return YES;
    }
    NSError *error;
    NSString *dirPath = [filePath stringByDeletingLastPathComponent];
    BOOL isSuccess = [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:&error];
    if (error)
    {
        NSLog(@"creat File Failed:%@",[error localizedDescription]);
    }
    if (!isSuccess)
    {
        return isSuccess;
    }
    isSuccess = [fileManager createFileAtPath:filePath contents:nil attributes:nil];
    return isSuccess;
}


- (BOOL)creatDir:(NSString *)path
{
    if (path.length==0)
    {
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isSuccess = YES;
    BOOL isExist = [fileManager fileExistsAtPath:path];
    if (isExist==NO)
    {
        NSError *error;
        if (![fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error])
        {
            isSuccess = NO;
            NSLog(@"creat Directory Failed:%@",[error localizedDescription]);
        }
    }
    return isSuccess;
}


- (BOOL)writeToFile:(NSString*)filePath contents:(NSData *)data
{
    if (filePath.length == 0)
    {
        return NO;
    }
    BOOL result = [self creatFile:filePath];
    if (result)
    {
        if ([data writeToFile:filePath atomically:YES])
        {
            NSLog(@"write Success");
        }else{
            NSLog(@"write Failed");
        }
    }
    else
    {
        NSLog(@"write Failed");
    }
    return result;
}

- (BOOL)appendData:(NSData*)data withPath:(NSString *)filePath
{
    if (filePath.length == 0)
    {
        return NO;
    }
    BOOL result = [self creatFile:filePath];
    if (result)
    {
        NSFileHandle *handle = [NSFileHandle fileHandleForWritingAtPath:filePath];
        [handle seekToEndOfFile];
        [handle writeData:data];
        [handle synchronizeFile];
        [handle closeFile];
    }
    else
    {
        NSLog(@"appendData Failed");
    }
    return result;
}

- (NSData*)readFileData:(NSString *)path
{
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:path];
    NSData *fileData = [handle readDataToEndOfFile];
    [handle closeFile];
    return fileData;
}

- (BOOL)saveToUserdefault:(nonnull NSString *)objKey contents:(nullable id)objValue
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:objValue forKey:objKey];
  return   [ud synchronize];
}

- (id)getFormUserdefaultWithKey:(nonnull NSString *)objKey
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud valueForKey:objKey];
 }
@end
