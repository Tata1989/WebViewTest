//
//  ATBaseWebViewVC.m
//  Test
//
//  Created by wangxinxin on 15/11/18.
//  Copyright (c) 2015年 wangxinxin. All rights reserved.
//

#import "ATBaseWebViewVC.h"

@interface ATBaseWebViewVC ()<UIWebViewDelegate>

{
    UIButton *_closeBtn;
    UIButton *_button;
    UIButton *_button0;
    UILabel *_titleLabel;
    //_statues = 1,返回按钮是返回到根目录；否则返回上一级页面
    NSInteger _statues;
    NSInteger _myPageCount;
    NSInteger _myBackCount;
    BOOL _myStatues;
    
}

@property (nonatomic, strong)     NSString *beforeUrl;
@property (nonatomic, strong)     UIWebView *webView;


@end

@implementation ATBaseWebViewVC

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self setUpNavigationBarRefresh];
//    [self rightBtnAction];
    
    [self setupNavigationBar:self.navigationController];
    [self setUpNavigationBarLeftBack];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = self.navigationItemTitle ? self.navigationItemTitle : @"亚洲旅游";
   
        self.navigationController.navigationBar.hidden = NO;
    self.view.exclusiveTouch = YES;

    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64)];
    _webView.backgroundColor = UIColorFromRGB(0xcccccc);
    _webView.delegate = self;
    if (!self.webUrl) {
        return;
    }
     [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]]];
    [self.view addSubview:_webView];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    }

#pragma mark - private methods
- (void)leftbarbuttonAction
{
    if(_webView.canGoBack){
        
        [_webView goBack];
        
    }
    else{
         [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"webViewDidStartLoad");
    [MBProgressHUD showLoading];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUD];
    NSLog(@"webViewDidFinishLoad");
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //判断是不是tel也就是打电话按钮被点击
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
//        self.webUrl = request.URL.absoluteString;

    }
    return YES;
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"err0r =%@",error);
    [MBProgressHUD hideHUD];
}

#pragma mark --刷新--
- (void)refreshRightbarbuttonAction
{
    DDLog(@"refreshRightbarbuttonAction");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self stopAnimation];
        
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]]];
 
        
    });
    
}


@end
