# FT Mobile SDK iOS

**FTMobileAgent**

![Cocoapods platforms](https://img.shields.io/cocoapods/p/FTMobileAgent)
![Cocoapods](https://img.shields.io/cocoapods/v/FTMobileAgent)
![Cocoapods](https://img.shields.io/cocoapods/v/FTAutoTrack)
![Cocoapods](https://img.shields.io/cocoapods/l/FTAutoTrack)


## 安装
-  **通过源码集成**
   - 获取源码。  
     配置下载链接：将想获取的 SDK 版本的版本号替换下载链接中的 VERSION。  
	 含全埋点的下载链接：https://zhuyun-static-files-production.oss-cn-hangzhou.aliyuncs.com/ft-sdk-package/ios/FTAutoTrack/VERSION.zip   
	 
	 无全埋点的下载链接：https://zhuyun-static-files-production.oss-cn-hangzhou.aliyuncs.com/ft-sdk-package/ios/FTMobileAgent/VERSION.zip
   - 将 SDK 源代码导入 App 项目，并选中 Copy items if needed;
   - 添加依赖库：项目设置 "Build Phase" -> "Link Binary With Libraries" 添加：libicucore、libsqlite3 和 libz。
-  **通过 CocoaPods 集成**

  - 配置 Podfile 文件。
     如果需要全埋点功能，在 Podfile 文件中添加  `pod 'FTAutoTrack'`，不需要则
	 `pod 'FTMobileAgent'`
  - 在 Podfile 目录下执行 pod install 安装 SDK。
 
## 配置
- 添加头文件
请将 `#import <FTMobileAgent/FTMobileAgent.h>
` 添加到 AppDelegate.m 引用头文件的位置。

- 添加初始化代码
  请将以下代码添加到 `-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions`
  eg:
  ```objective-c
    FTMobileConfig *config = [FTMobileConfig new];
    config.enableRequestSigning = YES;
    config.akSecret = akSecret;
    config.akId = akId;
    config.isDebug = YES;
    config.metricsUrl = 写入地址;
	config.enableAutoTrack = YES; 
    config.autoTrackEventType = FTAutoTrackEventTypeAppStart|FTAutoTrackEventTypeAppClick|FTAutoTrackEventTypeAppViewScreen; 
	config.monitorInfoType =FTMonitorInfoTypeAll;
	config.whiteViewClass = @[UIButton.class,UIImageView.class]; 
	config.whiteVCList = @["HomeViewController"]; 
    [FTMobileAgent startWithConfigOptions:config];
  ``` 

### SDK 可配置参数
| 字段 | 类型 |说明|是否必须|
|:--------:|:--------:|:--------:|:--------:|
|  enableRequestSigning      |  BOOL      |配置是否需要进行请求签名  |是|
|metricsUrl|NSString|FT-GateWay metrics 写入地址|是|
|akId|NSString|access key ID| enableRequestSigning 为 true 时，必须要填|
|akSecret|NSString|access key Secret|enableRequestSigning 为 true 时，必须要填|
|isDebug|BOOL|设置是否允许打印日志|否（默认NO）|
|enableAutoTrack|BOOL|设置是否开启全埋点|否（默认NO）|
|autoTrackEventType|NS_OPTIONS|全埋点抓取事件枚举|否（默认FTAutoTrackTypeNone）|
|whiteViewClass|NSArray|UI控件白名单|否|
|blackViewClass|NSArray|UI控件黑名单|否|
|whiteVCList|NSArray|控制器白名单|否|
|blackVCList|NSArray|控制器黑名单|否|
|monitorInfoType|NS_OPTIONS|采集数据|否|

## 方法
### 用户的绑定与注销
 1、FT SDK 提供了绑定用户和注销用户的方法，只有在用户登录的状态下，进行数据的传输。
 - 用户绑定：
 
```
  /**
绑定用户信息
 @param name     用户名
 @param Id       用户Id
 @param exts     用户其他信息
*/
- (void)bindUserWithName:(NSString *)name Id:(NSString *)Id exts:(nullable NSDictionary *)exts;
```

- 用户注销：

```
/**
 注销当前用户
*/
- (void)logout;
```

2、方法使用示例

```
//登录后 绑定用户信息
    [[FTMobileAgent sharedInstance] bindUserWithName:userName Id:userId exts:nil];
```

```
//登出后 注销当前用户
    [[FTMobileAgent sharedInstance] logout];
```


### 埋点方法
 1、FT SDK 公开了2个埋点方法，用户通过这两个方法可以在需要的地方实现埋点，然后将数据上传到服务端。

-  方法一：

```objective-c
  /**
追踪自定义事件。
 @param field      指标（必填）
 @param values     指标值（必填）
*/ 
 - (void)track:( NSString *)field  values:(NSDictionary *)values;
```
 
-  方法二：

```objective-c
/**
 追踪自定义事件。
 
 @param field      指标（必填）
 @param tags       标签（选填）
 @param values     指标值（必填）
 */
 - (void)track:( NSString *)field tags:(nullable NSDictionary*)tags values:( NSDictionary *)values;
```

2、方法使用示例

```objective-c
   
[[FTMobileAgent sharedInstance] track:@"home.operation" tags:@{@"pushVC":@"SecondViewController"} values:@{@"event":@"BtnClick"}];
   
```


## 常见问题
**1.关于查询指标 IMEI**
- IMEI
   因为隐私问题，苹果用户在 iOS5 以后禁用代码直接获取 IMEI 的值。所以 iOS sdk 中不支持获取 IMEI。
   


