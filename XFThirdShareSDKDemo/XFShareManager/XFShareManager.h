//
//  XFShareManager.h
//  XFThirdShareSDKDemo
//
//  Created by 许锋 on 2018/1/25.
//  Copyright © 2018年 许锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WXApi.h"
#import "XFShareModel.h"

typedef void(^ShareStatuBlock)(BOOL isScuess);


@interface XFShareManager : NSObject

/*
 *分享回调状态
 */
@property(nonatomic,copy)ShareStatuBlock shareStatuBlcok;

/*
 *获取分享管理单例
 */
+ (instancetype)sharedInstance;


/**
 分享到微信平台
 WXSceneSession  = 0,
 WXSceneTimeline = 1,
 */
- (void)shareToWX:(XFShareModel *)shareModel scene:(int)scene;

/**
 分享到微博
 */
- (void)shareToWeibo:(XFShareModel *)shareModel;

@end
