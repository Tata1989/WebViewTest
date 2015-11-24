//
//  ATBaseWebViewVC.m
//  Test
//
//  Created by wangxinxin on 15/11/18.
//  Copyright (c) 2015年 wangxinxin. All rights reserved.
//

#import "ATBaseWebViewVC.h"

@interface ATBaseWebViewVC ()<UIWebViewDelegate>

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
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"webViewDidFinishLoad");
    
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSLog(@"title      = %@",title);
    self.navigationItem.title = title;
    
    NSString *hideHeaderJS = [webView stringByEvaluatingJavaScriptFromString:@"var header = document.getElementById('vlm-h-1');header.parentNode.removeChild(header);"];
    [webView stringByEvaluatingJavaScriptFromString:hideHeaderJS];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //判断是不是tel也就是打电话按钮被点击
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
//        self.webUrl = request.URL.absoluteString;
 
            if ([request.URL.absoluteString hasPrefix:@"tel"])
            {
                
            }else {
                
                ATBaseWebViewVC *webViewVC = [[ATBaseWebViewVC alloc] init];
                webViewVC.webUrl = request.URL.absoluteString;
                DDLog(@"push新的控制器");
                [self.navigationController pushViewController:webViewVC animated:YES];
                
                return NO;
            }

    }
    return YES;
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"err0r =%@",error);
}


@end
