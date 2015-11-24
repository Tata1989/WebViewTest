//
//  ATTabBarController.m
//  Test
//
//  Created by wangxinxin on 15/11/18.
//  Copyright (c) 2015年 wangxinxin. All rights reserved.
//

#import "ATTabBarController.h"
#import "ATNavigationController.h"
#import "ATBaseWebViewVC.h"
#import "MainWebView.h"

@interface ATTabBarController ()<UITabBarControllerDelegate>
{
//    UIButton *button;
    UITabBar *mayTabBar;
    
}
@property (nonatomic, strong) UIButton *button;
@end

@implementation ATTabBarController

- (void)viewWillAppear:(BOOL)animated
{
//    [self setup];
 
}

//- (void)loadView{
//    
//    [self setupAllChildViewControllers];
//}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // 初始化所有的子控制器
    
    [self setupAllChildViewControllers];
}

- (void)setupAllChildViewControllers
{

    //首页
    MainWebView *homeVC = [[MainWebView alloc] init];
    homeVC.navigationItemTitle = @"首页";
    homeVC.webUrl = [NSString stringWithFormat:@"%@",kBaseURL];
    [self setupChildViewController:homeVC title:@"首页" imageName:@"tabbar_mine_normal"  selectedImageName:@"tabbar_mine_selected"];
    
    //订单
    MainWebView *orderVC = [[MainWebView alloc] init];
    orderVC.navigationItemTitle = @"订单";
    orderVC.webUrl = [NSString stringWithFormat:@"%@order.html",kBaseURL];
    [self setupChildViewController:orderVC title:@"订单" imageName:@"tabbar_mine_normal"  selectedImageName:@"tabbar_mine_selected"];
    
    //客服
    MainWebView *customerServiceVC = [[MainWebView alloc] init];
    customerServiceVC.navigationItemTitle = @"客服";
    customerServiceVC.webUrl = [NSString stringWithFormat:@"%@service.html",kBaseURL];
    [self setupChildViewController:customerServiceVC title:@"客服" imageName:@"tabbar_mine_normal" selectedImageName:@"tabbar_mine_selected"];
    
    //我的
    MainWebView *mineVC = [[MainWebView alloc] init];
    mineVC.navigationItemTitle = @"我的";
    mineVC.webUrl = [NSString stringWithFormat:@"%@user.html",kBaseURL];
    [self setupChildViewController:mineVC title:@"我的" imageName:@"tabbar_mine_normal"  selectedImageName:@"tabbar_mine_selected"];
    
}
/**
 *  初始化一个子控制器
 *
 *  @param childVc           需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 1.设置控制器的属性
    childVc.title = title;
    
    [childVc.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromRGB(0x666666),NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromRGB(0x32b4c2),NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [childVc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, 0)];
    
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    [childVc.tabBarItem setImageInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    // 设置选中的图标
    UIImage *selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = selectedImage;
    
    // 2.包装一个导航控制器
    ATNavigationController *nav = [[ATNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
   
 }
@end
