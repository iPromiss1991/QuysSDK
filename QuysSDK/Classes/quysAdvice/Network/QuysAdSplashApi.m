//
//  QuysAdSplashApi.m
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysAdSplashApi.h"
#import "UIDevice+Hardware.h"
#import "QuysMD5.h"
@implementation QuysAdSplashApi


- (NSString *)requestUrl
{
    //  NSString *strRequestUrl = @"http://adx.quyuansu.com/api/spread/detail";
    //    NSString *strRequestUrl = @"http://192.168.1.8:8086/spread/detail";
    //标准测试
    if (0)
    {
//        NSString *strRequestUrl = @"http://192.168.1.8:8086/spread/detail";
      NSString *strRequestUrl = @"http://adx.quyuansu.com/api/spread/detail";
        NSString *strTimestam = [NSDate quys_getNowTimeTimestamp];
        NSString *strApiToken = [NSString stringWithFormat:@"%@%@%@",self.businessID,self.bussinessKey,strTimestam];
        NSString *strMd5ApiToken = [QuysMD5 md5EncryptStr:strApiToken bateNum:32 isLowercaseStr:YES];
        NSMutableString *strUrl = [NSMutableString stringWithFormat:@"%@?id=%@&apiToken=%@&timestamp=%@",strRequestUrl,self.businessID,strMd5ApiToken,strTimestam];
        return strUrl;
        
//        return @"http://192.168.1.8:8086/spread/detail";

    }else
    {
        NSString *strRequestUrl = @"http://192.168.1.11/advert/sdktest.php";
        NSString *strTimestam = [NSDate quys_getNowTimeTimestamp];
        NSString *strApiToken = [NSString stringWithFormat:@"%@%@%@",self.businessID,self.bussinessKey,strTimestam];
        NSString *strMd5ApiToken = [QuysMD5 md5EncryptStr:strApiToken bateNum:32 isLowercaseStr:YES];
        NSMutableString *strUrl = [NSMutableString stringWithFormat:@"%@?id=%@&apiToken=%@&timestamp=%@",strRequestUrl,self.businessID,strMd5ApiToken,strTimestam];
        return strUrl;
        
    }
    
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}




- (id)requestArgument
{
    UIDevice *device = [[UIDevice alloc] init];
    NSMutableDictionary *dicM = [NSMutableDictionary new];
    [dicM setObject:kBundleID forKey:@"pkgName"];
    [dicM setObject:[device quys_appVersionByFloat] forKey:@"versionName"];
    [dicM setObject:@([[device quys_appVersionWithoutFloat] integerValue]) forKey:@"versionCode"];
    
    [dicM setObject:[[QuysAdviceManager shareManager] strIPAddress] forKey:@"ip"];
    [dicM setObject:[device quys_customMacAddress] forKey:@"mac"];
    [dicM setObject:[device quys_customImei] forKey:@"imei"];
//
    [dicM setObject:[device quys_customImsi] forKey:@"imsi"];
    [dicM setObject:[[device quys_platformString] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLUserAllowedCharacterSet]] forKey:@"Model"];
    [dicM setObject:[device quys_deviceBrand] forKey:@"brand"];
    [dicM setObject:[device quys_deviceManufacturer] forKey:@"manufacturer"];
    
    [dicM setObject:[device systemVersion] forKey:@"osv"];
    [dicM setObject:[device quys_serialno] forKey:@"serialno"];
    [dicM setObject:@([kStringFormat(@"%lf",kScreenWidth) integerValue]) forKey:@"sw"];

    [dicM setObject:[device quys_screenPixelDensity] forKey:@"dip"];

    [dicM setObject:@([kStringFormat(@"%lf",kScreenHeight) integerValue]) forKey:@"sh"];
    [dicM setObject:@([[device quys_screenOritation] integerValue]) forKey:@"so"];
    [dicM setObject:@([ [device quys_getNetconnType] integerValue]) forKey:@"net"];
    
    [dicM setObject:@([[device quys_carrierName] integerValue]) forKey:@"operatorType"];
    [dicM setObject:[[QuysAdviceManager shareManager] strUserAgent] forKey:@"ua"];
    [dicM setObject:@([[device quys_deviceType] integerValue]) forKey:@"deviceType"];
    [dicM setObject:@([[device quys_osType] integerValue]) forKey:@"osType"];
    [dicM setObject:[device quys_idFa] forKey:@"idFa"];
    
    [dicM setObject:@([[device quys_screenDensity] integerValue]) forKey:@"dpi"];
    [dicM setObject:[device quys_screenResolution] forKey:@"screenResolution"];
    [dicM setObject:[device quys_country] forKey:@"country"];
    
    [dicM setObject:[device quys_preferredLanguage] forKey:@"language"];
    
    return dicM;
}

@end
