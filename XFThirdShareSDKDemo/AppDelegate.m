//
//  AppDelegate.m
//  XFThirdShareSDKDemo
//
//  Created by 许锋 on 2018/1/25.
//  Copyright © 2018年 许锋. All rights reserved.
//

#import "AppDelegate.h"
#import "WXApi.h"
#import "XFShareManager.h"
#import <WeiboSDK.h>

static NSString * const kWeChatAppID = @"wxf56d7d93bc226f2e";//WeChat
static NSString * const kWeiboAppID = @"3021556666";//Weibo


@interface AppDelegate ()<WeiboSDKDelegate,WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self configWeChat];
    [self configWeibo];
    return YES;
}

#pragma mark -
#pragma mark WeChat
- (void)configWeChat {
    [WXApi registerApp:kWeChatAppID];
}

#pragma mark -
#pragma mark Weibo
- (void)configWeibo {
    [WeiboSDK registerApp:kWeiboAppID];
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

#pragma mark -
#pragma mark openUrl
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    NSString *absoluteUrlStr = [url absoluteString];
    if ([absoluteUrlStr rangeOfString:kWeChatAppID].location != NSNotFound) {
        return [WXApi handleOpenURL:url delegate:self];

    } else if ([absoluteUrlStr rangeOfString:kWeiboAppID].location != NSNotFound) {
        return [WeiboSDK handleOpenURL:url delegate:self];
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    NSString *absoluteUrlStr = [url absoluteString];
    if ([absoluteUrlStr rangeOfString:kWeChatAppID].location != NSNotFound) {
        return [WXApi handleOpenURL:url delegate:self];
        
    } else if ([absoluteUrlStr rangeOfString:kWeiboAppID].location != NSNotFound) {
        return [WeiboSDK handleOpenURL:url delegate:self];
    }
    return YES;
}

#pragma mark -
#pragma mark WXApiDelegate
- (void)onResp:(BaseResp *)resp {
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {//微信分享
        if (resp.errCode == WXSuccess) {  //成功。
            //这里处理回调的方法 。 通过代理吧对应的登录消息传送过去。
            //[[NSNotificationCenter defaultCenter] postNotificationName:kWxShareNotification object:self userInfo:nil];
            if ([XFShareManager sharedInstance].shareStatuBlcok) {
                [XFShareManager sharedInstance].shareStatuBlcok(YES);
            }
            
        }else{ //失败
            if ([XFShareManager sharedInstance].shareStatuBlcok) {
                [XFShareManager sharedInstance].shareStatuBlcok(NO);
            }
        }
    }
}

#pragma mark -
#pragma mark WeiBoDelegate

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    if (response.statusCode == WeiboSDKResponseStatusCodeSuccess) {
        if ([XFShareManager sharedInstance].shareStatuBlcok) {
            [XFShareManager sharedInstance].shareStatuBlcok(YES);
        }
    }
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {
    
}


@end
