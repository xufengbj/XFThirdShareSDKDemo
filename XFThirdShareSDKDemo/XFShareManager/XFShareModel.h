//
//  XFShareModel.h
//  XFThirdShareSDKDemo
//
//  Created by 许锋 on 2018/1/25.
//  Copyright © 2018年 许锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XFShareType) {
    XFShareTypeImage      = 0, //图片
    XFShareTypeWebPage,        //链接
    XFShareTypeMusic,          //音乐
};

@interface XFShareModel : NSObject

//标题
@property(nonatomic ,copy)NSString * title;

//描述内容
@property(nonatomic ,copy)NSString * shareDescription;

//缩略图
@property(nonatomic ,strong)UIImage * thumbImage;

//微信分享图片对象
@property(nonatomic ,strong)UIImage * image;

//网页的url地址
@property (nonatomic, copy) NSString * webpageUrl;

//音频URL
@property (nonatomic, copy) NSString * musicUrl;

//分享类型
@property(nonatomic , assign)XFShareType shareType;

@end
