//
//  QuysAdviceManager.m
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import <AFNetworking.h>

#import "QuysAdviceManager.h"
#import "QuysAdviceConfigModel.h"

static  NSString *kGetNetworkIpUrl = @"http://pv.sohu.com/cityjson?ie=utf-8";
static  NSString *kGetNetworkIpKey = @"cip";

static  NSString *kNetworkIp = @"quys_kNetworkIp";
static  NSString *kUserAgent = @"quys_kUserAgent";

@interface QuysAdviceManager()

@property (nonatomic,strong) NSMapTable *mapTable;
@property (nonatomic,strong) UIView *webViewTarget;


#pragma mark - 辅助字段

@property (nonatomic,assign) BOOL searchIpEnable;//!< 能否查询ip
@property (nonatomic,assign) BOOL searchUser_AgentEnable;//!< 能否查询User_Agent



@end


@implementation QuysAdviceManager

+ (instancetype)shareManager
{
    static QuysAdviceManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[super allocWithZone:NULL] init];
    });
    return manager;
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    return [QuysAdviceManager shareManager] ;
}
-(id) copyWithZone:(struct _NSZone *)zone
{
    return [QuysAdviceManager shareManager] ;
}





#pragma mark - PrivateMethod



/// 每次启动App需要做的配置事件
- (void)configSettings
{
    self.searchUser_AgentEnable = YES;
    self.searchIpEnable = YES;
    
    [self quys_UserAgent];
    [self quys_getIPAdderss];
    
    [self monitorNetworkStatus];
    [self addMainObserver];
}


/// 获取userAgent并保存本地
- (void)quys_UserAgent
{
    self.searchUser_AgentEnable = NO;
    kWeakSelf(self)
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *strUserAgent =@"" ;
        NSString *strStored = [[QuysFileManager shareManager] getFormUserdefaultWithKey:kUserAgent];
           if (!kISNullString(strStored))
           {
               strUserAgent = strStored;
               weakself.strUserAgent = strUserAgent;
               [weakself configUserAgent];
           }else
           {
               [weakself configUserAgent];
           }
    });
}


- (void)configUserAgent
{
    kWeakSelf(self)
    if (kIOS8Later)
    {
        WKWebView *wkWebview = [[WKWebView alloc] initWithFrame:CGRectZero configuration:[[WKWebViewConfiguration alloc]init]];
        [wkWebview evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id result, NSError * _Nullable error) {
            [[QuysFileManager shareManager] saveToUserdefault:kUserAgent contents:result];
            weakself.strUserAgent = result;
            weakself.searchUser_AgentEnable = NO;
        }];
        self.webViewTarget = wkWebview;
    }else
    {
        UIWebView* webView = [[UIWebView alloc]initWithFrame:CGRectZero];
        weakself.strUserAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
        weakself.webViewTarget = webView;
        [[QuysFileManager shareManager] saveToUserdefault:kUserAgent contents:weakself.strUserAgent];
        weakself.searchUser_AgentEnable = NO;
    }
}


- (NSMutableDictionary*)combineReplaceKeyAndValues
{
    
    NSMutableDictionary *dicM = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                 kResponeAdWidth,@"",
                                 kResponeAdHeight,@"",
                                 kRealAdWidth,@"",
                                 kRealAdHeight,@"",
                                 kClickInsideDownX,@"",
                                 kClickInsideDownY,@"",
                                 kClickUPX,@"",
                                 kClickUPY,@"",
                                 kVideoScene,@"1",
                                 nil];
    return dicM;
}


/// 网络ip地址
- (void)quys_getIPAdderss
{
    self.searchIpEnable = NO;
    kWeakSelf(self)
    __block  NSString *strIPAddress  ;
    NSString *strStored = [[QuysFileManager shareManager] getFormUserdefaultWithKey:kNetworkIp];
    if (!kISNullString(strStored))
    {
        strIPAddress = strStored;
    }
    if (!kISNullString(strStored))
    {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
             strIPAddress = [[self quys_deviceWANIPAdress] valueForKey:kGetNetworkIpKey];
             if (strIPAddress.length)
             {
                 [[QuysFileManager shareManager] saveToUserdefault:kNetworkIp contents:strIPAddress ];
                 weakself.strIPAddress = strIPAddress;
                 weakself.searchIpEnable = NO;
             }else
             {
                 weakself.searchIpEnable = YES;
             };
        });
    }else
    {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            strIPAddress = [[self quys_deviceWANIPAdress] valueForKey:kGetNetworkIpKey];
            if (strIPAddress.length)
            {
                [[QuysFileManager shareManager] saveToUserdefault:kNetworkIp contents:strIPAddress ];
                weakself.strIPAddress = strIPAddress;
                weakself.searchIpEnable = NO;
            }else
            {
                weakself.searchIpEnable = YES;
            };
        });
    }
}


/// 获取网络信息
/*返回字段如下：{
    area = "";
    "area_id" = "";
    city = "\U53a6\U95e8";
    "city_id" = 350200;
    country = "\U4e2d\U56fd";
    "country_id" = CN;
    county = XX;
    "county_id" = xx;
    ip = "183.250.89.75";
    isp = "\U79fb\U52a8";
    "isp_id" = 100025;
    region = "\U798f\U5efa";
    "region_id" = 350000;
}*/
-(NSDictionary *)quys_deviceWANIPAdress
{
   __block NSMutableDictionary *ipDic = [NSMutableDictionary new] ;
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
//         NSURL *ipURL = [NSURL URLWithString:@"http://ip.taobao.com/service/getIpInfo2.php?ip=myip"];//http://pv.sohu.com/cityjson
            NSURL *ipURL = [NSURL URLWithString:kGetNetworkIpUrl];//
        NSError *error;
            NSMutableString *ip = [NSMutableString stringWithContentsOfURL:ipURL encoding:NSUTF8StringEncoding error:&error];
           //判断返回字符串是否为所需数据
           if ([ip hasPrefix:@"var returnCitySN = "])
           {
               NSLog(@"<<<<<<<<<<<<<%@   %@ ",error ,ip);
               //对字符串进行处理，然后进行json解析
               //删除字符串多余字符串
               NSRange range = NSMakeRange(0, 19);
               [ip deleteCharactersInRange:range];
               NSString * nowIp =[ip substringToIndex:ip.length-1];
               //将字符串转换成二进制进行Json解析
               NSData * data = [nowIp dataUsingEncoding:NSUTF8StringEncoding];
               ipDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
           }else
           {
                ipDic = [[NSMutableDictionary alloc]initWithDictionary:@{kGetNetworkIpKey:@""}];
           }
    });
    return ipDic;
}


- (NSString*)replaceSpecifiedString:(NSString*)strForReplace
{
    __block NSString *strTemp = strForReplace;
    [[self dicMReplace] enumerateKeysAndObjectsUsingBlock:^(NSString* key, NSString *obj, BOOL * _Nonnull stop) {
        if ([strTemp containsString:key])
        {
            strTemp = [strTemp stringByReplacingOccurrencesOfString:key withString:obj];
        }
    }];
    return strTemp;
}


#pragma mark - 网络状态
- (void)monitorNetworkStatus
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];//sharedManager：之前误写为manager，导致不能按预期运行
   [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        /*
         AFNetworkReachabilityStatusUnknown          = -1,
         AFNetworkReachabilityStatusNotReachable     = 0,
         AFNetworkReachabilityStatusReachableViaWWAN = 1,
         AFNetworkReachabilityStatusReachableViaWiFi = 2,
         */
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            {
                NSLog(@"未知");
                self.networkReachabilityStatus = QuysNetworkReachabilityStatusUnknown;
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            {
                NSLog(@"没有网络");
                self.networkReachabilityStatus = QuysNetworkReachabilityStatusNotReachable;
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                NSLog(@"3G|4G");
                [[self dicMReplace] setObject:@(2) forKey:kVideoBeavior];;
                self.networkReachabilityStatus = QuysNetworkReachabilityStatusReachableViaWWAN;
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                NSLog(@"WiFi");
                [[self dicMReplace] setObject:@(1) forKey:kVideoBeavior];;
                self.networkReachabilityStatus = QuysNetworkReachabilityStatusReachableViaWiFi;
            }
                break;
            default:
                break;
        }
    }];

    [manager startMonitoring];
}


#pragma mark - Runloop闲时获取数据
- (void)addMainObserver
{
      CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {

      switch (activity) {

            case kCFRunLoopEntry:
//            NSLog(@"###cmm###进入kCFRunLoopEntry");
            break;

            case kCFRunLoopBeforeTimers:
//            NSLog(@"###cmm###即将处理Timer事件");
            break;

            case kCFRunLoopBeforeSources:
//            NSLog(@"###cmm###即将处理Source事件");
            break;

            case kCFRunLoopBeforeWaiting:
          {
//              NSLog(@"###cmm###即将休眠");

              if (kISNullString(self.strIPAddress) && self.searchIpEnable)
              {
                  NSLog(@"######查询ip");
                  [self quys_getIPAdderss];
              }
              if (kISNullString(self.strUserAgent) && self.searchUser_AgentEnable)
              {
                  NSLog(@"######查询user_agent");
                  [self quys_UserAgent];
              }
          }
            break;

            case kCFRunLoopAfterWaiting:
//            NSLog(@"###cmm###被唤醒");
            break;

            case kCFRunLoopExit:
//            NSLog(@"###cmm###退出RunLoop");
            break;

            default:
            break;
           }
      });

      CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopDefaultMode);

 
}



#pragma mark - Init


- (NSMapTable *)mapTable
{
    if (_mapTable == nil) {
        _mapTable = [[NSMapTable alloc] initWithKeyOptions:NSMapTableStrongMemory valueOptions:NSMapTableStrongMemory capacity:6];
    }
    return _mapTable;
}


-(NSMutableDictionary *)dicMReplace
{
    if (_dicMReplace == nil)
    {
      _dicMReplace = [self combineReplaceKeyAndValues];
    }
    return _dicMReplace;
}

#warning     runloop闲时获取相关数据(ip & userAgent)
- (NSString *)strUserAgent
{
    if (_strUserAgent == nil || [_strUserAgent isEqualToString:@""])
    {
        NSString *strTemp = [[QuysFileManager shareManager] getFormUserdefaultWithKey:kUserAgent];
        _strUserAgent = strTemp?strTemp:@"" ;//获取本地存储的
    }
    return _strUserAgent;
}

-(NSString *)strIPAddress

{
    if (_strIPAddress == nil || [_strIPAddress isEqualToString:@""])
    {
        NSString *strTemp = [[QuysFileManager shareManager] getFormUserdefaultWithKey:kNetworkIp];
        _strIPAddress = strTemp?strTemp:@"" ;//获取本地存储的
    }
    return _strIPAddress;
}

- (BOOL)loadAdviceEnable
{
    if (self.strIPAddress.length && self.strUserAgent.length) {
        return YES;
    }else
    {
        return NO;
    }
}
@end
