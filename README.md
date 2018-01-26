该demo集成了微信SDK,新浪微博SDK,主要功能是：微信好友、微信朋友圈、新浪微博 分享 图片、链接、音频等的集成与封装。

使用方法: 
1:首先 cd到改目录下面 pod install 下载所需SDK 
2:具体调用方法如下:
 
    shareTitle = @"分享标题";
    shareDescription = @"分享描述";
    thumbImage = [UIImage imageNamed:@"60"];
    
    shareModel = [[XFShareModel alloc]init];
    shareModel.title = shareTitle;
    shareModel.shareDescription = shareDescription;
    shareModel.thumbImage = thumbImage;
    shareModel.webpageUrl = _shareUrl.text;
    shareModel.shareType = XFShareTypeWebPage;
    
    //分享链接 微信好友
    shareModel.shareType = XFShareTypeWebPage;
    [XFShareManager sharedInstance].shareStatuBlcok = ^(BOOL isScuess) {
        if (isScuess) {
            NSLog(@"分享成功");
        } else {
            NSLog(@"分享失败");
        }
    };
    [[XFShareManager sharedInstance]shareToWX:shareModel scene:WXSceneSession];
    
    
    //分享链接 微信朋友圈
    shareModel.shareType = XFShareTypeWebPage;
    [XFShareManager sharedInstance].shareStatuBlcok = ^(BOOL isScuess) {
        if (isScuess) {
            NSLog(@"分享成功");
        } else {
            NSLog(@"分享失败");
        }
    };
    [[XFShareManager sharedInstance]shareToWX:shareModel scene:WXSceneTimeline];
    
    //分享图片 微信好友
    shareModel.shareType = XFShareTypeImage;
    shareModel.image = _shareImgView.image;
    [XFShareManager sharedInstance].shareStatuBlcok = ^(BOOL isScuess) {
        if (isScuess) {
            NSLog(@"分享成功");
        } else {
            NSLog(@"分享失败");
        }
    };
    [[XFShareManager sharedInstance]shareToWX:shareModel scene:WXSceneSession];
    
    //分享图片 微博
    shareModel.shareType = XFShareTypeImage;
    shareModel.image = _shareImgView.image;
    [XFShareManager sharedInstance].shareStatuBlcok = ^(BOOL isScuess) {
        if (isScuess) {
            NSLog(@"分享成功");
        } else {
            NSLog(@"分享失败");
        }
    };
    [[XFShareManager sharedInstance] shareToWeibo:shareModel];
    
   3:优点：可扩展性强,使用起来方便代码简洁。

