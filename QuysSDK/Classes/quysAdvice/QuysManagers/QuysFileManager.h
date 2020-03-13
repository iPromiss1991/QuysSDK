//
//  QuysFileManager.h
//  quysAdvice
//
//  Created by quys on 2019/12/19.
//  Copyright © 2019 Quys. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QuysFileManager : NSObject

+ (instancetype)shareManager;

- (BOOL)isExsit:(NSString*)strPath;

- (BOOL)isDirectory:(NSString*)strPath;

-(BOOL)creatFile:(NSString*)filePath;

-(BOOL)creatDir:(NSString *)path;


-(BOOL)writeToFile:(NSString*)filePath contents:(NSData *)data;

-(BOOL)appendData:(NSData*)data withPath:(NSString *)filePath;

-(NSData*)readFileData:(NSString *)path;

- (BOOL)saveToUserdefault:(nonnull NSString *)objKey contents:(nullable id)objValue;

- (id)getFormUserdefaultWithKey:(nonnull NSString *)objKey;


@end

NS_ASSUME_NONNULL_END
