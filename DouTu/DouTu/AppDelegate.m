//
//  AppDelegate.m
//  DouTu
//
//  Created by yuepengfei on 17/3/14.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "AppDelegate.h"
#import "DTBaseTabbarController.h"
#import "HcdGuideView.h"
@interface AppDelegate ()<TencentSessionDelegate, HcdGuideViewDelegate>

@property (nonatomic, strong) HcdGuideView *guideView;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setUpBaseNetwork];
    [self setUpSDWebImage];
    [self setUpKeyWindow];
    [self setUpWecomeView];
    //向微信注册
    [WXApi registerApp:@"wxd930ea5d5a258f4f"];
    [[TencentOAuth alloc] initWithAppId:@"1106050546" andDelegate:self];
    [DTDBManager shareInstance];
    return YES;
}
#pragma mark - setUpBaseNetwork
- (void)setUpBaseNetwork
{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring]; //检测网络
    [HYBNetworking updateBaseUrl:kDTBaseHostUrl];                   //默认hostUrl
    [HYBNetworking configRequestType:kHYBRequestTypePlainText       //请求类型 数据类型 Encode Url
                        responseType:kHYBResponseTypeJSON
                 shouldAutoEncodeUrl:YES
             callbackOnCancelRequest:NO];
    [HYBNetworking enableInterfaceDebug:NO];                        //是否开启debug模式
    [HYBNetworking obtainDataFromLocalWhenNetworkUnconnected:YES];  //网络异常时本地获取数据
    [HYBNetworking cacheGetRequest:YES shoulCachePost:YES];         //数据缓存
    [HYBNetworking setTimeout:20.f];//超时回调
}
#pragma mark - setUpSDWebImage
- (void)setUpSDWebImage
{
    [[SDImageCache sharedImageCache] setShouldDecompressImages:NO];
    [[SDImageCache sharedImageCache] setMaxCacheAge:60 * 60 * 24 * 7 * 12]; //三个月清除
    [[SDWebImageDownloader sharedDownloader] setShouldDecompressImages:NO];
}
#pragma mark - setUpKeyWindow
- (void)setUpKeyWindow
{
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.rootViewController = [[DTBaseTabbarController alloc] init];
    [_window makeKeyAndVisible];
}
#pragma mark - setUpWecomeView
- (void)setUpWecomeView
{
    NSMutableArray *images = [NSMutableArray new];
    
    [images addObject:[UIImage imageNamed:@"dt_wecome_00"]];
    [images addObject:[UIImage imageNamed:@"dt_wecome_01"]];
    [images addObject:[UIImage imageNamed:@"dt_wecome_02"]];
    
    _guideView = [[HcdGuideView alloc] init];
    _guideView.delegate = self;
    _guideView.window = self.window;
    [_guideView showGuideViewWithImages:images
                         andButtonTitle:@"立即体验"
                    andButtonTitleColor:[UIColor whiteColor]
                       andButtonBGColor:[UIColor clearColor]
                   andButtonBorderColor:[UIColor whiteColor]];
}
- (void)hcdGuideViewEndShow
{
    _guideView = nil;
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    [TencentOAuth HandleOpenURL:url];
    [WXApi handleOpenURL:url delegate:self];
    return YES;
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    BOOL isSuc = [WXApi handleOpenURL:url delegate:self];
    NSLog(@"url %@ isSuc %d",url,isSuc == YES ? 1 : 0);
    return  isSuc;
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [TencentOAuth HandleOpenURL:url];
}

-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        NSString *strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
        NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
