//
//  ViewController.m
//  XFThirdShareSDKDemo
//
//  Created by 许锋 on 2018/1/25.
//  Copyright © 2018年 许锋. All rights reserved.
//

#import "ViewController.h"
#import "XFShareManager.h"
#import "XFShareModel.h"

@interface ViewController () {
    XFShareModel * shareModel;
    NSString * shareTitle;
    NSString * shareDescription;
    UIImage * thumbImage;
}
@property (strong, nonatomic) IBOutlet UILabel *shareUrl;
@property (strong, nonatomic) IBOutlet UIImageView *shareImgView;

@property (strong, nonatomic) IBOutlet UIButton *wxFriendUrlBtn;

@property (strong, nonatomic) IBOutlet UIButton *wxFriendImgBtn;

@property (strong, nonatomic) IBOutlet UIButton *weCircleImgBtn;

@property (strong, nonatomic) IBOutlet UIButton *wxCircleUrlBtn;
@property (strong, nonatomic) IBOutlet UIButton *weiboUrlBtn;

@property (strong, nonatomic) IBOutlet UIButton *weiboImgBtn;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    shareTitle = @"分享标题";
    shareDescription = @"分享描述";
    thumbImage = [UIImage imageNamed:@"60"];
    
    shareModel = [[XFShareModel alloc]init];
    shareModel.title = shareTitle;
    shareModel.shareDescription = shareDescription;
    shareModel.thumbImage = thumbImage;
    shareModel.webpageUrl = _shareUrl.text;
    shareModel.shareType = XFShareTypeWebPage;
    // Do any additional setup after loading the view, typically from a nib.
}

//分享链接 微信好友
- (IBAction)shareWxFriendLink:(UIButton *)sender {
    shareModel.shareType = XFShareTypeWebPage;
    [XFShareManager sharedInstance].shareStatuBlcok = ^(BOOL isScuess) {
        if (isScuess) {
            NSLog(@"分享成功");
        } else {
            NSLog(@"分享失败");
        }
    };
    [[XFShareManager sharedInstance]shareToWX:shareModel scene:WXSceneSession];
}

//分享图片 微信好友
- (IBAction)shareWxFriendImage:(id)sender {
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
}

//分享链接 微信朋友圈
- (IBAction)shareWxLinkImage:(id)sender {
    shareModel.shareType = XFShareTypeWebPage;
    [XFShareManager sharedInstance].shareStatuBlcok = ^(BOOL isScuess) {
        if (isScuess) {
            NSLog(@"分享成功");
        } else {
            NSLog(@"分享失败");
        }
    };
    [[XFShareManager sharedInstance]shareToWX:shareModel scene:WXSceneTimeline];
}

//分享图片 微信朋友圈
- (IBAction)shareWxCircleImage:(id)sender {
    shareModel.shareType = XFShareTypeImage;
    shareModel.image = _shareImgView.image;
    [XFShareManager sharedInstance].shareStatuBlcok = ^(BOOL isScuess) {
        if (isScuess) {
            NSLog(@"分享成功");
        } else {
            NSLog(@"分享失败");
        }
    };
    [[XFShareManager sharedInstance]shareToWX:shareModel scene:WXSceneTimeline];
}

//分享链接 微博
- (IBAction)shareWeiboLink:(id)sender {
    shareModel.shareType = XFShareTypeWebPage;
    [XFShareManager sharedInstance].shareStatuBlcok = ^(BOOL isScuess) {
        if (isScuess) {
            NSLog(@"分享成功");
        } else {
            NSLog(@"分享失败");
        }
    };
    [[XFShareManager sharedInstance] shareToWeibo:shareModel];
}

//分享图片 微博
- (IBAction)shareWeiboImage:(id)sender {
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
