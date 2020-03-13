//
//  QuysIncentiveVideoApi.m
//  quysAdvice
//
//  Created by quys on 2019/12/30.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysIncentiveVideoApi.h"
#import "UIDevice+Hardware.h"
#import "QuysMD5.h"
@implementation QuysIncentiveVideoApi



- (NSString *)requestUrl
{
     if (0)
    {
//        NSString *strRequestUrl = @"http://192.168.1.30:8093/list";
  NSString *strRequestUrl = @"http://jl.quyuansu.com/pull/list";
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
//        NSMutableString *strUrl = [NSMutableString stringWithFormat:@"%@?tid=206&id=%@&apiToken=%@&timestamp=%@",strRequestUrl,self.businessID,strMd5ApiToken,strTimestam];
        NSMutableString *strUrl = [NSMutableString stringWithFormat:@"%@?id=%@&apiToken=%@&timestamp=%@",strRequestUrl,self.businessID,strMd5ApiToken,strTimestam];

        return strUrl;
        
    }
    
}


- (id)requestArgument
{

    /*
     1、组建请求参数:done
     2、创建数据响应模型:done
     3、创建上报事件回调delegate:done
     4、实现业务逻辑
     5、布局“激励视频”
*/
    UIDevice *device = [[UIDevice alloc] init];
    NSMutableDictionary *dicM = [NSMutableDictionary new];
    
    [dicM setObject:[device quys_customImei] forKey:@"Imei"];
    [dicM setObject:[device quys_customMacAddress] forKey:@"Mac"];
    [dicM setObject:[[QuysAdviceManager shareManager] strIPAddress] forKey:@"IP"];
    
    [dicM setObject:[[device quys_platformString] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLUserAllowedCharacterSet]] forKey:@"Model"];
    [dicM setObject:[device quys_deviceBrand] forKey:@"Brand"];
    [dicM setObject:[device quys_deviceManufacturer] forKey:@"Manufacturer"];

    [dicM setObject:[device quys_idFa] forKey:@"Idfa"];
    [dicM setObject:[device quys_idFv] forKey:@"Idfv"];
    [dicM setObject:[[QuysAdviceManager shareManager] strUserAgent] forKey:@"Ua"];

    [dicM setObject:kStringFormat(@"%@",[device systemVersion]) forKey:@"OsVersionMajor"];
    [dicM setObject:[device quys_deviceType] forKey:@"DeviceType"];
    [dicM setObject:[device quys_getNetconnTypeForIncentiveVideo] forKey:@"NetworkType"];

    [dicM setObject:[device quys_carrierName] forKey:@"OperatorType"];
    [dicM setObject:@"2" forKey:@"OsType"];//安卓= 1, IOS = 2,    WinPhone = 3,   塞班= 4,  黑莓 = 5, 其他 = 100

    [dicM setObject:@([kStringFormat(@"%lf",kScreenHeight) integerValue]) forKey:@"AdslotHeight"];
    [dicM setObject:@([kStringFormat(@"%lf",kScreenWidth) integerValue]) forKey:@"AdslotWidth"];
    [dicM setObject:[device quys_appVersionByFloat] forKey:@"AppVersionMajor"];
    
    [dicM setObject:@([kStringFormat(@"%lf",kScreenHeight) integerValue]) forKey:@"ScreenHeight"];
    [dicM setObject:@([kStringFormat(@"%lf",kScreenWidth) integerValue]) forKey:@"ScreenWidth"];
    [dicM setObject:[device quys_screenOritation] forKey:@"ScreenOrientation"];

    [dicM setObject:[device quys_screenPixelDensity] forKey:@"ScreenPixelDensity"];
    [dicM setObject:@([[device quys_screenResolution] integerValue]) forKey:@"ScreenResolution"];
    
    [dicM setObject:[device quys_country] forKey:@"Country"];
    [dicM setObject:[device quys_preferredLanguage] forKey:@"Language"];
    [dicM setObject:[device quys_customImsi] forKey:@"Imsi"];

    [dicM setObject:[device quys_screenDensity] forKey:@"Dpi"];
    return dicM;
}

@end
