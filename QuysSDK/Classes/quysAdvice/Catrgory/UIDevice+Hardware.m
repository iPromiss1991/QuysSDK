
#import "UIDevice+Hardware.h"

#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import <sys/utsname.h>
#import <SystemConfiguration/CaptiveNetwork.h>
// 下面是获取IP需要的头文件
#import <sys/ioctl.h>
#include <ifaddrs.h>
#import <arpa/inet.h>

//
#import "QuysSAMKeychain.h"
#import <AdSupport/Adsupport.h>
//
#import "Reachability.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

TT_FIX_CATEGORY_BUG(qys_Hardware)
@implementation UIDevice (Hardware)
#pragma mark sysctlbyname utils
- (NSString *)quys_getSysInfoByName:(char *)typeSpecifier
{
    size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    
    char *answer = malloc(size);
    sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
    
    NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];

    free(answer);
    return results;
}

- (NSString *)quys_platform
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];

    return deviceString;
}

#pragma mark sysctl utils
- (NSUInteger) getSysInfo: (uint) typeSpecifier
{
    size_t size = sizeof(int);
    int results;
    int mib[2] = {CTL_HW, typeSpecifier};
    sysctl(mib, 2, &results, &size, NULL, 0);
    return (NSUInteger) results;
}

- (NSUInteger) cpuFrequency
{
    return [self getSysInfo:HW_CPU_FREQ];
}

- (NSUInteger) busFrequency
{
    return [self getSysInfo:HW_BUS_FREQ];
}

- (NSUInteger) cpuCount
{
    return [self getSysInfo:HW_NCPU];
}

- (NSUInteger) totalMemory
{
    return [self getSysInfo:HW_PHYSMEM];
}

- (NSUInteger) userMemory
{
    return [self getSysInfo:HW_USERMEM];
}

- (NSUInteger) maxSocketBufferSize
{
    return [self getSysInfo:KIPC_MAXSOCKBUF];
}

/*
 extern NSString *NSFileSystemSize;
 extern NSString *NSFileSystemFreeSize;
 extern NSString *NSFileSystemNodes;
 extern NSString *NSFileSystemFreeNodes;
 extern NSString *NSFileSystemNumber;
*/

- (NSNumber *)quys_totalDiskSpace
{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [fattributes objectForKey:NSFileSystemSize];
}

- (NSNumber *)quys_freeDiskSpace
{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [fattributes objectForKey:NSFileSystemFreeSize];
}

- (NSString *)quys_platformString{
    
    NSString *platform = [self quys_platform];
    
    if([platform rangeOfString:@"iPhone"].location != NSNotFound){
        return [self quys_iPhonePlatform:platform];
    }
    if([platform rangeOfString:@"iPad"].location != NSNotFound){
        return [self quys_iPadPlatform:platform];
    }
    if([platform rangeOfString:@"iPod"].location != NSNotFound){
        return [self quys_iPodPlatform:platform];
    }
    
    if ([platform isEqualToString:@"i386"])             return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])        return @"Simulator";
    
    return @"Unknown iOS Device";
}

- (NSString *)quys_iPhonePlatform:(NSString *)platform{
    
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    //2017年9月发布，更新三种机型：iPhone 8、iPhone 8 Plus、iPhone X
    if ([platform isEqualToString:@"iPhone10,1"])  return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,4"])  return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,2"])  return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,5"])  return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,3"])  return @"iPhone X";
    if ([platform isEqualToString:@"iPhone10,6"])  return @"iPhone X";
    //2018年10月发布，更新三种机型：iPhone XR、iPhone XS、iPhone XS Max
    if ([platform isEqualToString:@"iPhone11,8"])  return  @"iPhone XR";
    if ([platform isEqualToString:@"iPhone11,2"])  return @"iPhone XS";
    if ([platform isEqualToString:@"iPhone11,4"])  return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone11,6"])  return @"iPhone XS Max";
    //2019年9月发布，更新三种机型：iPhone 11、iPhone 11 Pro、iPhone 11 Pro Max
    if ([platform isEqualToString:@"iPhone12,1"])  return  @"iPhone 11";
    if ([platform isEqualToString:@"iPhone12,3"])  return  @"iPhone 11 Pro";
    if ([platform isEqualToString:@"iPhone12,5"])  return  @"iPhone 11 Pro Max";
    
    return @"Unknown iPhone";
}

- (NSString *)quys_iPadPlatform:(NSString *)platform{
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad";
    if ([platform isEqualToString:@"iPad1,2"])   return @"iPad 3G";
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (Cellular)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2 (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2 (Cellular)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2";
    if ([platform isEqualToString:@"iPad4,7"])   return @"iPad Mini 3";
    if ([platform isEqualToString:@"iPad4,8"])   return @"iPad Mini 3";
    if ([platform isEqualToString:@"iPad4,9"])   return @"iPad Mini 3";
    if ([platform isEqualToString:@"iPad5,1"])   return @"iPad Mini 4 (WiFi)";
    if ([platform isEqualToString:@"iPad5,2"])   return @"iPad Mini 4 (LTE)";
    if ([platform isEqualToString:@"iPad5,3"])   return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad5,4"])   return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad6,3"])   return @"iPad Pro 9.7";
    if ([platform isEqualToString:@"iPad6,4"])   return @"iPad Pro 9.7";
    if ([platform isEqualToString:@"iPad6,7"])   return @"iPad Pro 12.9";
    if ([platform isEqualToString:@"iPad6,8"])   return @"iPad Pro 12.9";
    if ([platform isEqualToString:@"iPad6,11"])  return @"iPad 5 (WiFi)";
    if ([platform isEqualToString:@"iPad6,12"])  return @"iPad 5 (Cellular)";
    if ([platform isEqualToString:@"iPad7,1"])   return @"iPad Pro 12.9 inch 2nd gen (WiFi)";
    if ([platform isEqualToString:@"iPad7,2"])   return @"iPad Pro 12.9 inch 2nd gen (Cellular)";
    if ([platform isEqualToString:@"iPad7,3"])   return @"iPad Pro 10.5 inch (WiFi)";
    if ([platform isEqualToString:@"iPad7,4"])   return @"iPad Pro 10.5 inch (Cellular)";
    if ([platform isEqualToString:@"iPad7,5"])   return @"iPad (6th generation)";
    if ([platform isEqualToString:@"iPad7,6"])   return @"iPad (6th generation)";
    if ([platform isEqualToString:@"iPad8,1"])   return @"iPad Pro (11-inch)";
    if ([platform isEqualToString:@"iPad8,2"])   return @"iPad Pro (11-inch)";
    if ([platform isEqualToString:@"iPad8,3"])   return @"iPad Pro (11-inch)";
    if ([platform isEqualToString:@"iPad8,4"])   return @"iPad Pro (11-inch)";
    if ([platform isEqualToString:@"iPad8,5"])   return @"iPad Pro (12.9-inch) (3rd generation)";
    if ([platform isEqualToString:@"iPad8,6"])   return @"iPad Pro (12.9-inch) (3rd generation)";
    if ([platform isEqualToString:@"iPad8,7"])   return @"iPad Pro (12.9-inch) (3rd generation)";
    if ([platform isEqualToString:@"iPad8,8"])   return @"iPad Pro (12.9-inch) (3rd generation)";
    //2019年3月发布:
    if ([platform isEqualToString:@"iPad11,1"])   return @"iPad mini (5th generation)";
    if ([platform isEqualToString:@"iPad11,2"])   return @"iPad mini (5th generation)";
    if ([platform isEqualToString:@"iPad11,3"])   return @"iPad Air (3rd generation)";
    if ([platform isEqualToString:@"iPad11,4"])   return @"iPad Air (3rd generation)";

    return @"Unknown iPad";
}

- (NSString *)quys_iPodPlatform:(NSString *)platform{
    
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch (5th generation)";
    if ([platform isEqualToString:@"iPod7,1"])      return @"iPod touch (6th generation)";
    //2019年5月发布，更新三种机型：iPod touch (7th generation)
    if ([platform isEqualToString:@"iPod9,1"])      return @"iPod touch (7th generation)";

    return @"Unknown iPod";
}



/// 获取屏幕尺寸
/// @param platform 设备名称
- (NSString *)quys_iPhoneDiagonalByPlatform:(NSString *)platform{
    
    if ([platform isEqualToString:@"iPhone1,1"])    return @"3.5";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"3.5";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"3.5";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"3.5";
    if ([platform isEqualToString:@"iPhone3,2"])    return @"3.5";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"3.5";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"3.5";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"4.0";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"4.0";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"4.0";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"4.0";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"4.0";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"4.0";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"4.7";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"5.5";
    if ([platform isEqualToString:@"iPhone8,1"])    return @"4.7";
    if ([platform isEqualToString:@"iPhone8,2"])    return @"5.5";
    if ([platform isEqualToString:@"iPhone8,4"])    return @"4.0 ";
    if ([platform isEqualToString:@"iPhone9,1"])    return @"4.7";
    if ([platform isEqualToString:@"iPhone9,3"])    return @"4.7";
    if ([platform isEqualToString:@"iPhone9,2"])    return @"5.5";
    if ([platform isEqualToString:@"iPhone9,4"])    return @"5.5";
    //2017年9月发布，更新三种机型：iPhone 8、iPhone 8 Plus、iPhone X
    if ([platform isEqualToString:@"iPhone10,1"])  return @"4.7";
    if ([platform isEqualToString:@"iPhone10,4"])  return @"4.7";
    if ([platform isEqualToString:@"iPhone10,2"])  return @"5.5";
    if ([platform isEqualToString:@"iPhone10,5"])  return @"5.5";
    if ([platform isEqualToString:@"iPhone10,3"])  return @"5.8";
    if ([platform isEqualToString:@"iPhone10,6"])  return @"5.8";
    //2018年10月发布，更新三种机型：iPhone XR、iPhone XS、iPhone XS Max
    if ([platform isEqualToString:@"iPhone11,8"])  return  @"6.1";
    if ([platform isEqualToString:@"iPhone11,2"])  return @"5.8";
    if ([platform isEqualToString:@"iPhone11,4"])  return @"6.5";
    if ([platform isEqualToString:@"iPhone11,6"])  return @"6.5";
    //2019年9月发布，更新三种机型：iPhone 11、iPhone 11 Pro、iPhone 11 Pro Max
    if ([platform isEqualToString:@"iPhone12,1"])  return  @"6.1";
    if ([platform isEqualToString:@"iPhone12,3"])  return  @"5.8";
    if ([platform isEqualToString:@"iPhone12,5"])  return  @"6.5";
    
    return @"6.5";
}

- (float)quys_iOSVersion{
    
    return [[self systemVersion] floatValue];
}

#pragma mark MAC addy
- (NSString *)quys_macAddress{
    
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Error: Memory allocation error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2\n");
        free(buf); // Thanks, Remy "Psy" Demerest
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];

    free(buf);
    return outstring;
}

- (NSString *)quys_ipAddresses{
    
    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    
    NSMutableArray *ips = [NSMutableArray array];
    
    int BUFFERSIZE = 4096;
    
    struct ifconf ifc;
    
    char buffer[BUFFERSIZE], *ptr, lastname[IFNAMSIZ], *cptr;
    
    struct ifreq *ifr, ifrcopy;
    
    ifc.ifc_len = BUFFERSIZE;
    ifc.ifc_buf = buffer;
    
    if (ioctl(sockfd, SIOCGIFCONF, &ifc) >= 0){
        
        for(ptr = buffer; ptr < buffer + ifc.ifc_len; ){
            
            ifr = (struct ifreq *)ptr;
            int len = sizeof(struct sockaddr);
            
            if(ifr->ifr_addr.sa_len > len) {
                len = ifr->ifr_addr.sa_len;
            }
            
            ptr += sizeof(ifr->ifr_name) + len;
            if(ifr->ifr_addr.sa_family != AF_INET) continue;
            if((cptr = (char *)strchr(ifr->ifr_name, ':')) != NULL) *cptr = 0;
            if(strncmp(lastname, ifr->ifr_name, IFNAMSIZ) == 0) continue;
            
            memcpy(lastname, ifr->ifr_name, IFNAMSIZ);
            ifrcopy = *ifr;
            ioctl(sockfd, SIOCGIFFLAGS, &ifrcopy);
            
            if((ifrcopy.ifr_flags & IFF_UP) == 0) continue;
            
            NSString *ip = [NSString stringWithFormat:@"%s", inet_ntoa(((struct sockaddr_in *)&ifr->ifr_addr)->sin_addr)];
            [ips addObject:ip];
        }
    }
    
    close(sockfd);
    NSString *deviceIP = @"";
    
    for(int i=0; i < ips.count; i++) {
        if(ips.count > 0) {
            deviceIP = [NSString stringWithFormat:@"%@",ips.lastObject];
        }
    }
    return deviceIP;
}


#pragma mark - 广告


/// 获取app版本:eg:3.0.1
- (NSString*)quys_appVersionByFloat
{
   return  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}



/// 获取app版本号:eg:301
- (NSString*)quys_appVersionWithoutFloat
{
   return  [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] stringByReplacingOccurrencesOfString:@"." withString:@""];
}


///自定义mac
- (NSString*)quys_customMacAddress
{
    return [self quys_getUniqueID];
}


///自定义Imei
- (NSString*)quys_customImei
{
    return [self quys_getUniqueID];
}


///自定义Imsi
- (NSString*)quys_customImsi
{
    return [self quys_getUniqueID];
}


///手机品牌
- (NSString*)quys_deviceBrand
{
    return @"Apple";
}


///手机厂商
- (NSString*)quys_deviceManufacturer
{
    return @"Apple";
}


///手机序列号
- (NSString*)quys_serialno
{
    return [self quys_getUniqueID];
}

///手机屏幕方向：1 竖屏，2 横屏
- (NSString*)quys_screenOritation
{
   __block NSString *screenOritation = @"";
    dispatch_sync(dispatch_get_main_queue(), ^{
         UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
            if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown)
            {
                screenOritation = @"1";
            }else
            {
                screenOritation = @"2";
            }
    });
    return screenOritation;
}


/// 网络类型
/*
0：没有网络, 1：WIFI，2：2G，3：3G，4：4G，5：未知移动网络
*/
- (NSString *)quys_getNetconnType
{

    NSString *netconnType = @"";

    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];

    switch ([reach currentReachabilityStatus])
    {
        case NotReachable:// 没有网络
        {

            netconnType = @"0";//no network
        }
            break;

        case ReachableViaWiFi:// Wifi
        {
            netconnType = @"1";
        }
            break;

        case ReachableViaWWAN:// 手机自带网络
        {
            // 获取手机网络类型
            CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];

            NSString *currentStatus = info.currentRadioAccessTechnology;

            if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyGPRS"]) {

                netconnType = @"2";//@"GPRS"
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyEdge"]) {

                netconnType = @"2";// @"2.75G EDGE"
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyWCDMA"]){

                netconnType = @"3";// @"3G"
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSDPA"]){

                netconnType = @"3";//@"3.5G HSDPA"
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSUPA"]){

                netconnType = @"3";//@"3.5G HSUPA";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMA1x"]){

                netconnType = @"2";//@"2G"
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORev0"]){

                netconnType = @"3";// @"3G"
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevA"]){

                netconnType = @"3";// @"3G"
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevB"]){

                netconnType = @"3";// @"3G"
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyeHRPD"]){

                netconnType = @"3";//@"HRPD"
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyLTE"]){

                netconnType = @"4";//@"4G"
            }else{
                netconnType = @"0";//@"未知"

            }
        }
            break;

        default:
            break;
    }

    return netconnType;
}


/// 网络类型
/*
0：没有网络, 1：WIFI，2：2G，3：3G，4：4G，5：未知移动网络
*/
- (NSString *)quys_getNetconnTypeForIncentiveVideo
{

    NSString *netconnType = @"";

    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];

    switch ([reach currentReachabilityStatus])
    {
        case NotReachable:// 没有网络
        {

            netconnType = @"0";//no network
        }
            break;

        case ReachableViaWiFi:// Wifi
        {
            netconnType = @"1";
        }
            break;

        case ReachableViaWWAN:// 手机自带网络
        {
            // 获取手机网络类型
            CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];

            NSString *currentStatus = info.currentRadioAccessTechnology;

            if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyGPRS"]) {

                netconnType = @"2";//@"GPRS"
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyEdge"]) {

                netconnType = @"2";// @"2.75G EDGE"
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyWCDMA"]){

                netconnType = @"3";// @"3G"
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSDPA"]){

                netconnType = @"3";//@"3.5G HSDPA"
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSUPA"]){

                netconnType = @"3";//@"3.5G HSUPA";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMA1x"]){

                netconnType = @"2";//@"2G"
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORev0"]){

                netconnType = @"3";// @"3G"
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevA"]){

                netconnType = @"3";// @"3G"
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevB"]){

                netconnType = @"3";// @"3G"
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyeHRPD"]){

                netconnType = @"3";//@"HRPD"
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyLTE"]){

                netconnType = @"4";//@"4G"
            }else{
                netconnType = @"999";//@"未知"

            }
        }
            break;

        default:
            break;
    }

    return netconnType;
}


/// 获取运营商
-(NSString*)quys_carrierName
{
    //获取本机运营商名称
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    //当前手机所属运营商名称
    NSString *mobile;
    //先判断有没有SIM卡，如果没有则不获取本机运营商
    if (!carrier.isoCountryCode)
    {
        //没有SIM卡
        mobile = @"0";//无运营商
    }else
    {
        mobile = [carrier carrierName];
    }
    if ([mobile containsString:@"移动"])
    {
        mobile= @"1";
    }
    if ([mobile containsString:@"电信"])
    {
        mobile= @"2";
    }
    if ([mobile containsString:@"联通"])
    {
        mobile= @"3";
    }else
    {
        mobile= @"0";
    }
    return mobile;
}


/// 获取设备类型

- (NSString *)quys_deviceType
{
    
    NSString *platform = [self quys_platform];
    
    if([platform rangeOfString:@"iPhone"].location != NSNotFound){
        return @"1";
    }
    if([platform rangeOfString:@"iPad"].location != NSNotFound){
        return @"2";
    }
    if([platform rangeOfString:@"iPod"].location != NSNotFound){
        return @"3";
    }
    
    if ([platform isEqualToString:@"i386"])             return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])        return @"Simulator";
    
    return @"Unknown iOS Device";
}



/// 获取设备类型
- (NSString*)quys_osType
{
   return  @"1";
}

    
/// 获取IDFA
- (NSString*)quys_idFa
{
    NSString *strUniqueID = @"";
    strUniqueID = [QuysSAMKeychain passwordForService:kBundleID account:kAdviceAdvertisingIdentifier];
    if (strUniqueID.length <= 0)
    {
        strUniqueID = [[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
        [QuysSAMKeychain setPassword:strUniqueID forService:kBundleID account:kAdviceAdvertisingIdentifier];
    }else
    {
        
    }
    return strUniqueID;
}

/// 获取IDFV
- (NSString*)quys_idFv
{
    NSString *strUniqueID = @"";
    strUniqueID = [QuysSAMKeychain passwordForService:kBundleID account:kAdviceVenderIdentifier];
    if (strUniqueID.length <= 0)
    {
        strUniqueID =[ [[[UIDevice currentDevice] identifierForVendor] UUIDString]stringByReplacingOccurrencesOfString:@"-" withString:@""];
        [QuysSAMKeychain setPassword:strUniqueID forService:kBundleID account:kAdviceVenderIdentifier];
    }else
    {
        
    }
    return strUniqueID;
}


/// 屏幕分辨率（像素）
- (NSString*)quys_screenResolution
{
    double dbScreenResolution = kScreenWidth * kScreenHeight*powf([UIScreen mainScreen].scale, 2);
    return  [NSString stringWithFormat:@"%.0f",dbScreenResolution];
}

/// 屏幕像素密度（该属性是按照android理解的，如：3.0）               相关资料：https://www.cnblogs.com/weekbo/p/9013388.html
- (NSString*)quys_screenPixelDensity
{
    float screenInch = [[self quys_iPhoneDiagonalByPlatform:[self quys_platformString]] floatValue];
    double dbScreenResolution = sqrtl(powf(kScreenWidth*[UIScreen mainScreen].nativeScale, 2) + powf(kScreenHeight*[UIScreen mainScreen].scale, 2))/screenInch/160.0;
    return  [NSString stringWithFormat:@"%lf",dbScreenResolution];
}

/// 屏幕密度（屏幕像素密度 * 标准dpi（160））
- (NSString*)quys_screenDensity
{
    CGFloat screenDensity = [[self quys_screenPixelDensity] floatValue]*160.0;
    return [NSString stringWithFormat:@"%.0f",screenDensity];
}

/// 国家，使用ISO-3166-1   Alpha-3
- (NSString*)quys_country
{
    // iOS 获取设备当前地区的代码
    NSString *localeIdentifier = [[NSLocale currentLocale] objectForKey:NSLocaleIdentifier];
    return  [NSString stringWithFormat:@"%@",localeIdentifier];
}


/// 设备的语言设置,使用   alpha-2/ISO 6391
- (NSString*)quys_preferredLanguage
{
    // iOS 获取设备当前语言的代码
    NSString *preferredLanguage = [[[NSBundle mainBundle] preferredLocalizations] firstObject];
    return  preferredLanguage;
}



/// 获取app名称
- (NSString*)quys_appName
{
   return  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}


#pragma mark - PrivateMethod



- (NSString*)quys_createUUID
{
    // 如果没有UUID 则保存设备号
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    return [[uuid lowercaseString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
}


/// 最大限度的唯一标识符
- (NSString*)quys_getUniqueID
{
    NSString *strUniqueID = @"";
    strUniqueID = [QuysSAMKeychain passwordForService:kBundleID account:kAdviceDeviceIdentifier];
    if (strUniqueID.length <= 0)
    {
        strUniqueID = [self quys_createUUID];
        [QuysSAMKeychain setPassword:strUniqueID forService:kBundleID account:kAdviceDeviceIdentifier];
    }else
    {
        
    }
    return strUniqueID;
}

@end
