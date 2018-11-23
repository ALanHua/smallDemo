//
//  YHPHtmlViewController.m
//  01-彩票
//
//  Created by yhp on 16/6/19.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPHtmlViewController.h"

@interface YHPHtmlViewController ()<UIWebViewDelegate>

@end

@implementation YHPHtmlViewController

- (void)loadView
{
    self.view = [[UIWebView alloc]initWithFrame:YHPScreenBounds];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem* item = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    item.tintColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = item;
    self.view.backgroundColor = [UIColor whiteColor];
    //  取出webview加载网页
    UIWebView* webView = (UIWebView*)self.view;
#if 0  // 方式1 创建URL
    NSString* filePath = [[NSBundle mainBundle]pathForResource:@"help.html" ofType:nil];
    filePath = [filePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //  创建URL,如果路径中有中文，转换成URL会失败
    NSURL* url = [NSURL URLWithString:filePath];
#endif
    NSURL* url = [[NSBundle mainBundle] URLForResource:_htmlItem.html withExtension:nil];
    //  创建请求
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];
    
    webView.delegate = self;
}

- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// webView加载完成时候调用
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
//    执行javasript语言
    NSString* javaStr = [NSString stringWithFormat:@"window.location.href = '#%@';",_htmlItem.ID];
    
    [webView stringByEvaluatingJavaScriptFromString:javaStr];
}

@end
