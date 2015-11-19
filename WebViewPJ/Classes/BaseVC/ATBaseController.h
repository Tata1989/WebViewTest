//
//  ATBaseController.h
//  Test
//
//  Created by wangxinxin on 15/11/18.
//  Copyright (c) 2015年 wangxinxin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RefreshBlock)();

@interface ATBaseController : UIViewController

@property (nonatomic, strong) RefreshBlock refreshBlock;

- (void)setupNavigationBar:(UINavigationController *)naviController;

- (void)rightBtnAction;


- (void)setUpNavigationBarLeftBack;

- (void)setUpNavigationBarRefresh;

- (void)refreshRightbarbuttonAction;

- (void)stopAnimation;

@end
