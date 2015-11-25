//
//  LoadingIndicatorView.h
//  WebViewPJ
//
//  Created by wangxinxin on 15/11/25.
//  Copyright © 2015年 wangxinxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingIndicatorView : UIView

@property (nonatomic, assign) NSString *loadtext;
@property (nonatomic, readonly) BOOL isAnimating;


//use this to init
- (id)initWithFrame:(CGRect)frame;
-(void)setLoadText:(NSString *)text;

- (void)startAnimation;
- (void)stopAnimationWithLoadText:(NSString *)text withType:(BOOL)type;
@end
