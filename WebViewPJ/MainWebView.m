//
//  MainWebView.m
//  Test
//
//  Created by wangxinxin on 15/11/18.
//  Copyright (c) 2015年 wangxinxin. All rights reserved.
//

#import "MainWebView.h"
#import "ATBaseWebViewVC.h"

@interface MainWebView ()<UIWebViewDelegate>
{
    UIWebView *_webView ;
    UIBarButtonItem *_reloadItem;
    UIButton *_reloadBtn;
    
}
@end

@implementation MainWebView

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self setUpNavigationBarRefresh];
//    [self rightBtnAction];
    [self setupNavigationBar:self.navigationController];
}

- (void)viewDidLoad
{
    self.title = self.navigationItemTitle;
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64+49)];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]];
    _webView.scalesPageToFit = YES;
    _webView.delegate = self;
    _webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_webView];
    [_webView loadRequest:request];

}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSLog(@"shouldStartLoadWithRequest－－－%@",request.URL);
    
    //判断是否是单击事件
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        
        if ([request.URL.absoluteString hasPrefix:@"tel"])
        {
            
        }else {
            
            ATBaseWebViewVC *webViewVC = [[ATBaseWebViewVC alloc] init];
            webViewVC.webUrl = request.URL.absoluteString;
//            self.webUrl = request.URL.absoluteString;
            DDLog(@"push新的控制器");
            [self.navigationController pushViewController:webViewVC animated:YES];
            
            return NO;
        }
   
     }
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"webViewDidStartLoad");
//    [MBProgressHUD showLoading];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSLog(@"title      = %@",title);
    
    if ([webView canGoBack]) {
        UIButton *gobackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        gobackBtn.frame = CGRectMake(0, 0, 20, 35);
        [gobackBtn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
        [gobackBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
        UIBarButtonItem *backBtn = [[UIBarButtonItem alloc]initWithCustomView:gobackBtn];
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -5;
        
        self.navigationItem.leftBarButtonItems = @[negativeSpacer,backBtn];

    }else{
        self.navigationItem.leftBarButtonItems = @[];
    }
//      [self stopAnimation];
//    [MBProgressHUD hideHUD];
    NSLog(@"------>>>    %@",webView.request.URL);
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSLog(@"title      = %@",title);
    
    if (!webView.canGoBack) {
        self.navigationItem.leftBarButtonItems = @[];
        
    }
    [self stopAnimation];
    NSLog(@"------>>>    %@",webView.request.URL);
    
}

- (void)goback
{
    [_webView goBack];
}

#pragma mark --刷新--
- (void)refreshRightbarbuttonAction
{
    DDLog(@"refreshRightbarbuttonAction");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self stopAnimation];
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]]];
    });
    
//    [MBProgressHUD showMessage:@"网络好像不太给力，请稍后再试" time:3];
}

@end
