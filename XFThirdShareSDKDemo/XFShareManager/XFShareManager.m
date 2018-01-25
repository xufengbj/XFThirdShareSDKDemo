//
//  XFShareManager.m
//  XFThirdShareSDKDemo
//
//  Created by 许锋 on 2018/1/25.
//  Copyright © 2018年 许锋. All rights reserved.
//

#import "XFShareManager.h"
#import <WeiboSDK.h>

static NSString * const kRedirectURI = @"https://www.sina.com";


@implementation XFShareManager

/*
 *获取分享管理单例
 */
+ (instancetype)sharedInstance {
    static XFShareManager *shareManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[self alloc] init];
    });
    return shareManager;
}

/**
 分享到微信平台
 WXSceneSession  = 0,
 WXSceneTimeline = 1,
 */
- (void)shareToWX:(XFShareModel *)shareModel scene:(int)scene {
    
    if ([WXApi isWXAppInstalled]) {
        WXMediaMessage *message =  [WXMediaMessage message];
        
        //分享标题
        if (shareModel.title && ![shareModel.title isEqualToString:@""]) {
            message.title = shareModel.title;
        }
        
        //分享描述
        if (shareModel.shareDescription && ![shareModel.shareDescription isEqualToString:@""]) {
            message.description = shareModel.shareDescription;
        }
        
        //分享缩略图
        if (shareModel.thumbImage) {
            [message setThumbData:UIImageJPEGRepresentation(shareModel.thumbImage, 0.2)];
          }
        switch (shareModel.shareType) {
            case XFShareTypeImage: {
                WXImageObject *imageObj = [WXImageObject object];
                
                imageObj.imageData = UIImageJPEGRepresentation(shareModel.image, 1);
                
                message.mediaObject = imageObj;
            }
                break;
                
            case XFShareTypeWebPage: {
                WXWebpageObject *obj = [WXWebpageObject object];
                //网页的url地址
                if (shareModel.webpageUrl && ![shareModel.webpageUrl isEqualToString:@""]) {
                    obj.webpageUrl = shareModel.webpageUrl;
                }
                message.mediaObject = obj;
            }
                break;
                
            case XFShareTypeMusic: {
                
                
                WXMusicObject * musicObj =  [WXMusicObject object];
                if (scene == WXSceneSession) { //分享微信好友
                    musicObj.musicUrl = @"";
                } else if (scene == WXSceneTimeline) {//分享微信朋友圈
                    musicObj.musicUrl = shareModel.musicUrl;
                }
                musicObj.musicLowBandUrl = shareModel.musicUrl;
                musicObj.musicDataUrl = shareModel.musicUrl;
                message.mediaObject = musicObj;
            }
                break;
                
            default:
                break;
        }
        
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        
        
        
        if (scene == WXSceneSession) { //分享微信好友
            req.scene = WXSceneSession;
            [WXApi sendReq:req];
        } else if (scene == WXSceneTimeline) {//分享微信朋友圈
            req.scene = WXSceneTimeline;
            [WXApi sendReq:req];
        }
    } else {//未安装微信
        NSLog(@"未安装微信");
    }
}

/**
 分享到微博
 */
- (void)shareToWeibo:(XFShareModel *)shareModel {
    WBMessageObject *message = [WBMessageObject message];
    switch (shareModel.shareType) {
        case XFShareTypeImage: {
            WBImageObject *imageObj = [WBImageObject object];
            imageObj.imageData = UIImageJPEGRepresentation(shareModel.image, 1.0);
            message.imageObject = imageObj;
        }
            break;
            
        case XFShareTypeWebPage: {
            WBWebpageObject *obj = [WBWebpageObject object];
            obj.objectID = shareModel.webpageUrl;
            obj.title = shareModel.title;
            obj.description = shareModel.description;
            //缩略图
            obj.thumbnailData = UIImageJPEGRepresentation(shareModel.thumbImage, 0.2);
            //网页的url地址
            if (shareModel.webpageUrl && ![shareModel.webpageUrl isEqualToString:@""]) {
                obj.webpageUrl = shareModel.webpageUrl;
            }
            message.mediaObject = obj;
        }
            break;
            
        case XFShareTypeMusic: {
            WBMusicObject *musicObj = [WBMusicObject object];
            musicObj.objectID = shareModel.musicUrl;
            musicObj.title = shareModel.title;
            musicObj.description = shareModel.shareDescription;
            musicObj.thumbnailData = UIImageJPEGRepresentation(shareModel.thumbImage, 0.2);
            musicObj.musicUrl = shareModel.musicUrl;
            message.mediaObject = musicObj;
        }
            break;
            
        default:
            break;
    }
    
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = kRedirectURI;
    authRequest.scope = @"all";
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token:nil];
    [WeiboSDK sendRequest:request];
    
}

@end
