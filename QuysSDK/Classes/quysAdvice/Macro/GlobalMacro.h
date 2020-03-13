//
//  GlobalMacro.h
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#ifndef GlobalMacro_h
#define GlobalMacro_h
#import <UIKit/UIKit.h>

#pragma mark - 屏幕宽高
#define kAdviceServiceIdentifier @"com.quys.advice"
#define kAdviceDeviceIdentifier  @"com.quys.DeviceID"
#define kAdviceVenderIdentifier  @"com.quys.VenderID"
#define kAdviceAdvertisingIdentifier  @"com.quys.kAdviceAdvertisingID"

#pragma mark - 屏幕宽高
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height


#pragma mark -手机型号
#define kISiPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kScreenMaxLength (MAX(kScreenWidth, kScreenHeight))
#define kScreenMinLength (MIN(kScreenWidth, kScreenHeight))
#define kISiPhone5 (kISiPhone && kScreenMaxLength == 568.0)
#define kISiPhone6 (kISiPhone && kScreenMaxLength == 667.0)
#define kISiPhone6P (kISiPhone && kScreenMaxLength == 736.0)
#define kISiPhoneX (kISiPhone && kScreenMaxLength == 812.0)
#define kISiPhoneXr (kISiPhone && kScreenMaxLength == 896.0)
#define kISiPhoneXX (kISiPhone && kScreenMaxLength > 811.0)
#define kIOS8Later ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0)


#pragma mark -适配相关
//6为标准适配的,如果需要其他标准可以修改
#define kScale_W(w) ((kScreenWidth)/375) * (w)
#define kScale_H(h) (kScreenHeight/667) * (h)
//字体适配
#define kScaleFont(fontSize) [UIFont systemFontOfSize: fontSize*kScreenWidth/375]
//状态栏高度
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
//状态栏高度
#define StatusBarHeight (kISiPhoneXX?44:20)
//标签栏高度
#define kTabBarHeight (StatusBarHeight > 20 ? 83 : 49)
//导航栏高度
#define kNavBarHeight (StatusBarHeight + 44)
//安全区高度
#define kSafeAreaBottom (kISiPhoneXX ? 34 : 0)


#pragma mark -字体样式
#define kBoldFont(x) [UIFont boldSystemFontOfSize:x]
#define kFont(x) [UIFont systemFontOfSize:x]
#define kNameFont(x) [UIFont fontWithName:@"Heiti SC" size:x]


#pragma mark -颜色设置
//RGB格式
#define kRGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
//RGBA格式
#define kRGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
//随机颜色
#define kRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
//16进制颜色
#define kRGB16(rgbValue,alphaValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
                green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
                blue :((float)(rgbValue & 0xFF)) / 255.0 alpha:alphaValue]

#pragma mark -系统对象
//APP对象 （单例对象）
#define kApplication [UIApplication sharedApplication]
//主窗口 （keyWindow）
#define kKeyWindow [UIApplication sharedApplication].keyWindow
//delegate.window
#define kDelegateWindow [UIApplication sharedApplication].delegate.window
//NSUserDefaults实例化
#define kUserDefaults [NSUserDefaults standardUserDefaults]
//通知中心 （单例对象）
#define kNotificationCenter [NSNotificationCenter defaultCenter]
//发送通知
#define KPostNotification(name,obj,info) [[NSNotificationCenter defaultCenter]postNotificationName:name object:obj userInfo:info]
//APP版本号
#define kVersion [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"]
//系统版本号
#define kSystemVersion [[UIDevice currentDevice] systemVersion]
//APP BundleID 
#define kBundleID [[NSBundle mainBundle] bundleIdentifier]
//自定义bundle
#define MYBUNDLE [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"quysBundle" withExtension:@"bundle"]]


#pragma mark -简单调用
//加载图片
#define kGetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]
//弱引用
#define kWeakSelf(type)  __weak typeof(type) weak##type = type;
//强引用
#define kStrongSelf(type)  __strong typeof(type) type = weak##type
//安全调用Block
#define kSafeBlock(blockName,...) ({!blockName ? nil : blockName(__VA_ARGS__);})
//加载xib
#define kLoadNib(nibName) [UINib nibWithNibName:nibName bundle:[NSBundle mainBundle]]
//字符串拼接
#define kStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]
//属性快速声明（建议使用代码块）
#define kPropertyString(name) @property(nonatomic,copy)NSString *name
#define kPropertyStrong(type,name) @property(nonatomic,strong)type *name
#define kPropertyAssign(name) @property(nonatomic,assign)NSInteger name
// View 圆角和加边框
#define kViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]
// View 圆角
#define kViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]
//永久存储对象
#define kSetUserDefaults(object, key)                                                                                                 \
({                                                                                                                                             \
NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];                                                                         \
[defaults setObject:object forKey:key];                                                                                                    \
[defaults synchronize];                                                                                                                    \
})
//获取对象
#define kGetUserDefaults(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]
//删除某一个对象
#define kRemoveUserDefaults(key)                                         \
({                                                                          \
NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];       \
[defaults removeObjectForKey:_key];                                     \
[defaults synchronize];                                                 \
})
//清除 NSUserDefaults 保存的所有数据
#define kRemoveAllUserDefaults  [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]]


#pragma mark -获取时间
//获得当前的年份
#define  kCurrentYear [[NSCalendar currentCalendar] component:NSCalendarUnitYear fromDate:[NSDate date]]
//获得当前的月份
#define  kCurrentMonth [[NSCalendar currentCalendar] component:NSCalendarUnitMonth fromDate:[NSDate date]]
//获得当前的日期
#define  kCurrentDay  [[NSCalendar currentCalendar] component:NSCalendarUnitDay fromDate:[NSDate date]]
//获得当前的小时
#define  kCurrentHour [[NSCalendar currentCalendar] component:NSCalendarUnitHour fromDate:[NSDate date]]
//获得当前的分
#define  kCurrentMin [[NSCalendar currentCalendar] component:NSCalendarUnitMinute fromDate:[NSDate date]]
//获得当前的秒
#define  kCurrentSec [[NSCalendar currentCalendar] component:NSCalendarUnitSecond fromDate:[NSDate date]]


#pragma mark -沙盒路径
//获取沙盒 temp
#define kPathTemp NSTemporaryDirectory()
//获取沙盒 Document
#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒 Cache
#define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
//Library/Caches 文件路径
#define kFilePath ([[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil])


#pragma mark -线程
//GCD - 在Main线程上运行
#define kMainThread(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);
//GCD - 开启异步线程
#define kGlobalThread(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlocl);


#pragma mark -判空
//字符串是否为空
#define kISNullString(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define kISNullArray(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0 ||[array isEqual:[NSNull null]])
//字典是否为空
#define kISNullDict(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0 || [dic isEqual:[NSNull null]])
//是否是空对象
#define kISNullObject(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))
//判断对象是否为空,为空则返回默认值
#define kGetNullDefaultObj(_value,_default) ([_value isKindOfClass:[NSNull class]] || !_value || _value == nil || [_value isEqualToString:@"(null)"] || [_value isEqualToString:@"<null>"] || [_value isEqualToString:@""] || [_value length] == 0)?_default:_value


#pragma mark -自定义Log(没作用)
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif


#pragma mark -解决category冲突
#define TT_FIX_CATEGORY_BUG(name) @interface TT_FIX_CATEGORY_BUG_##name: NSObject @end \
@implementation TT_FIX_CATEGORY_BUG_##name @end

#pragma mark -宏替换业务Key
#define kResponeAdWidth @"__REQ_WIDTH__"
#define kResponeAdHeight @"__REQ_HEIGHT__"

#define kRealAdWidth  @"__WIDTH__"
#define kRealAdHeight @"__HEIGHT__"

#define kClickInsideDownX @"__DOWN_X__"
#define kClickInsideDownY @"__DOWN_Y__"

#define kClickUPX @"__UP_X__"
#define kClickUPY @"__UP_Y__"

#define kClickClickID @"__CLICK_ID__"

//激励视频
#define kClientTimeStamp @"__TS__"
#define kVideoTotalTime @"__VIDEO_TIME__"
#define kVideoBeginTime @"__BEGIN_TIME__"
#define kVideoEndTime @"__END_TIME__"

#define kVideoIsFirstFrame @"__PLAY_FIRST_FRAME__"
#define kVideoIsLastFrame @"__PLAY_LAST_FRAME__"
#define kVideoScene @"__SCENE__" 

#define kVideoType @"__TYPE__"
#define kVideoBeavior @"__BEAVIOR__"
#define kVideoStatus @"__STATUS__"


#pragma mark - 业务通知

#define kRemoveOpenScreenBackgroundImageViewNotify  @"kRemoveOpenScreenBackgroundImageViewNotify"//移除开屏广告window
#define kRemoveIncentiveBackgroundImageViewNotify  @"kRemoveIncentiveBackgroundImageViewNotify"//移除激励视频广告window


#pragma mark - 业务枚举

///激励视频尾帧
typedef NS_ENUM(NSInteger,QuysAdviceVideoEndShowType) {
   QuysAdviceVideoEndShowTypeNone = 0,
  QuysAdviceVideoEndShowTypeImageUrl = 1,
   QuysAdviceVideoEndShowTypeHtmlCode = 2,
  QuysAdviceVideoEndShowTypeHtmlUrl = 3
};



#pragma mark - 事件回调

///广告
typedef void(^QuysAdviceCloseEventBlock)(void);//!< 关闭事件
typedef void(^QuysAdviceClickEventBlock)(CGPoint cp);//!< 点击事件
typedef void(^QuysAdviceStatisticalCallBackBlock)(void);//!< 曝光事件

typedef void(^QuysAdviceLoadSucessCallBackBlock)(void);//!< 加载成功事件
typedef void(^QuysAdviceLoadFailCallBackBlock)(NSError *error);//!< 加载失败事件

//视频
typedef void(^QuysAdvicePlayStartCallBackBlock)(void);//!< 播放开始事件
typedef void(^QuysAdvicePlayEndCallBackBlock)(QuysAdviceVideoEndShowType endType);//!< 播放完成事件
typedef void(^QuysAdviceProgressEventBlock)(NSInteger progress);//!< 进度事件

typedef void(^QuysAdviceSuspendCallBackBlock)(void);//!< 暂停事件
typedef void(^QuysAdvicePlayagainCallBackBlock)(void);//!< 再次播放事件

typedef void(^QuysAdviceCloseMuteCallBackBlock)(void);//!< 关闭静音事件
typedef void(^QuysAdviceMuteCallBackBlock)(void);//!< 静音事件


// 尾帧
typedef void(^QuysAdviceEndViewCloseEventBlock)(void);//!< 关闭事件
typedef void(^QuysAdviceEndViewClickEventBlock)(CGPoint cp);//!< 点击事件
typedef void(^QuysAdviceEndViewStatisticalCallBackBlock)(void);//!< 尾帧 曝光事件




#endif /* GlobalMacro_h */
