//
//  ATBaseController.m
//  Test
//
//  Created by wangxinxin on 15/11/18.
//  Copyright (c) 2015年 wangxinxin. All rights reserved.
//

#import "ATBaseController.h"

@interface ATBaseController ()

{
    UIBarButtonItem *_reloadItem;
    UIButton *_reloadBtn;

}

@end

@implementation ATBaseController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(0xffffff);
    self.view.exclusiveTouch = YES;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    if([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)])
        self.automaticallyAdjustsScrollViewInsets = NO;
//
    
}

#pragma mark --返回按钮--
- (void)setUpNavigationBarLeftBack
{
    UIBarButtonItem *leftButtonItem = [UIBarButtonItem itemWithIcon:@"nav_back" highIcon:@"nav_back" target:self action:@selector(leftbarbuttonAction)];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = 10;
    self.navigationItem.leftBarButtonItems = @[negativeSpacer,leftButtonItem];
}

#pragma mark -- 刷新按钮 --
- (void)setUpNavigationBarRefresh
{
    _reloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _reloadBtn.frame = CGRectMake(0, 0, 40, 40);
    [_reloadBtn setImage:[UIImage imageNamed:@"nav_fresh"] forState:UIControlStateNormal];
    [_reloadBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    _reloadItem = [[UIBarButtonItem alloc]initWithCustomView:_reloadBtn];
    self.navigationItem.rightBarButtonItem = _reloadItem;
}


- (void)refreshAnimation
{
    [_reloadBtn setImage:[UIImage imageNamed:@"nav_loading"] forState:UIControlStateNormal];
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2 ];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = NO;
    rotationAnimation.repeatCount = 100000;
    [_reloadBtn.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];

}
//点击刷新按钮
- (void)rightBtnAction
{
    [self refreshAnimation];
    [self refreshRightbarbuttonAction];
}

- (void)refreshRightbarbuttonAction
{
  
    
}
//停止刷新动画
- (void)stopAnimation
{
    [MBProgressHUD hideHUD];
    [_reloadBtn.layer removeAllAnimations];
    [_reloadBtn setImage:[UIImage imageNamed:@"nav_fresh"] forState:UIControlStateNormal];
}


- (void)setupNavigationBar:(UINavigationController *)naviController {
    
    naviController.navigationBar.titleTextAttributes = @{
                                                         NSForegroundColorAttributeName : UIColorFromRGB(0xffffff), NSFontAttributeName : [UIFont fontWithName:@"TrebuchetMS-Bold"                                                                                                                size:NAVIGATION_TITLE_FONT_SIZE]
                                                         };
    
    //    if ([naviController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
    //        NSArray *list=naviController.navigationBar.subviews;
    //        for (id obj in list) {
    //            if ([obj isKindOfClass:[UIImageView class]]) {
    //                UIImageView *imageView=(UIImageView *)obj;
    //                imageView.hidden=YES;
    //            }
    //        }
    //        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, -20, 420, 64)];
    //        imageView.image=[UIImage imageWithColor:UIColorFromRGB(0xef1a0a)];
    //        [naviController.navigationBar addSubview:imageView];
    //        [naviController.navigationBar sendSubviewToBack:imageView];
    //    }
    
    [naviController.navigationBar setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0x63B8FF)] forBarMetrics:UIBarMetricsDefault];
    [naviController.navigationBar setBackgroundColor:UIColorFromRGB(0x63B8FF)]; // 设置导航栏背景颜色
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

- (void)leftbarbuttonAction
{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
