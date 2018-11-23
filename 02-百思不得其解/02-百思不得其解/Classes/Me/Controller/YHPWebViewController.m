//
//  YHPWebViewController.m
//  02-百思不得其解
//
//  Created by yhp on 2017/2/14.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "YHPWebViewController.h"
#import <NJKWebViewProgress.h>

@interface YHPWebViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForwardItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBackItem;
/** 进度代理对象 */
@property(nonatomic,strong)NJKWebViewProgress* progress;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation YHPWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.progress = [[NJKWebViewProgress alloc]init];
    self.webView.delegate = self.progress;
    // 解决循环引用
    __weak typeof(self) weakSelf = self;
    self.progress.progressBlock = ^(float progress) {
        weakSelf.progressView.progress = progress;
        weakSelf.progressView.hidden = (progress == 1.0);
    };
    // 监听webView 不影响webView的使用
    self.progress.webViewProxyDelegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}
- (IBAction)refresh:(UIBarButtonItem *)sender {
    [self.webView reload];
}
- (IBAction)goBack:(UIBarButtonItem *)sender {
    [self.webView goBack];
}
- (IBAction)goForward:(UIBarButtonItem *)sender {
    [self.webView goForward];
}

#pragma mark - <<UIWebViewDelegate>>
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.goBackItem.enabled    = webView.canGoBack;
    self.goForwardItem.enabled = webView.canGoForward;
}

@end
