//
//  FB_WebViewController.m
//  XiuZhuoYing
//
//  Created by qianyuan on 2020/8/17.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "FB_WebViewController.h"
#import <WebKit/WebKit.h>

@interface FB_WebViewController ()<WKNavigationDelegate,WKUIDelegate>

@property (nonatomic,strong) WKWebView *wkWebView;
@property (nonatomic ,strong) WKWebViewConfiguration *wkConfig;

@end

@implementation FB_WebViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden =NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.nav_title;
    if (self.webUrl !=nil) {
       [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]]];
    }else{
        [self.wkWebView loadHTMLString:[NSString stringWithFormat:@"<html><body>%@</body></html>",self.html] baseURL:nil];
    }
   

}

#pragma mark -- 懒加载
- (WKWebView *)wkWebView {
    
    if (!_wkWebView) {
       
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0,0,MainScreenWidth,MainScreenHeight-SafeAreaBottom)  configuration:self.wkConfig];
     
        _wkWebView.navigationDelegate = self;
        _wkWebView.UIDelegate = self;
        
        // 这行代码可以是侧滑返回webView的上一级，而不是根控制器（*只针对侧滑有效）
        [_wkWebView setAllowsBackForwardNavigationGestures:YES];
        
        _wkWebView.scrollView.showsVerticalScrollIndicator = NO;
        
        [self.view addSubview:_wkWebView];
    }
    
    return _wkWebView;
}

- (WKWebViewConfiguration *)wkConfig {
    
    if (!_wkConfig) {
        
        _wkConfig = [[WKWebViewConfiguration alloc] init];
        _wkConfig.allowsInlineMediaPlayback = YES;
        
        if (@available(iOS 9.0, *)) {
            _wkConfig.allowsPictureInPictureMediaPlayback = YES;
        } else {
            // Fallback on earlier versions
        }
        
        //自适应屏幕宽度js
        NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";

        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
        [wkUController addUserScript:wkUScript];

        _wkConfig.userContentController = wkUController;
    }
    
    return _wkConfig;
}


@end
