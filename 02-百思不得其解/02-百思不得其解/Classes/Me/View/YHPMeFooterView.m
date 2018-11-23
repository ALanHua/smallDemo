//
//  YHPMeFooterView.m
//  02-百思不得其解
//
//  Created by yhp on 2017/2/9.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "YHPMeFooterView.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "YHPSquare.h"
#import "YHPSquareButton.h"
#import "YHPWebViewController.h"

@implementation YHPMeFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        // 向服务器请求数据
        NSString* urlString = @"http://api.budejie.com/api/api_open.php";
        NSMutableDictionary* params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        
        [[AFHTTPSessionManager manager] GET:urlString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            // 模型解析
            NSArray* squares = [YHPSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            [self createSquares:squares];
    
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
        
    }
    
    return self;
}

/**
 创建方块
 @param squares 模型数组
 */
-(void)createSquares:(NSArray*)squares
{
    // 一行显示4列
    int maxCols = 4;
    CGFloat buttonW = YHPScreenW / maxCols;
    CGFloat buttonH = buttonW;
    
    for (int i = 0; i < squares.count; i++) {
        YHPSquareButton* button = [YHPSquareButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.square = squares[i];
        [self addSubview:button];
        // 设置frame
        int col = i % maxCols;
        int row = i / maxCols;
        button.x = col * buttonW;
        button.y = row * buttonH;
        button.width  = buttonW;
        button.height = buttonH;
        // 计算整个foot的高度
//
    }
    // 计算整个foot的高度
    /*
      1, NSUInteger rows = squares.count / maxCols;
        if (squares.count % maxCols) {
            rows++;
        }
     2,  self.height = CGRectGetMaxY(button.frame);
     */
    NSUInteger rows = (squares.count + maxCols - 1) / maxCols;
    self.height = rows * buttonH;
    // 重绘
    [self setNeedsDisplay];
}

-(void)buttonClick:(YHPSquareButton*)button
{
    if (![button.square.url hasPrefix:@"http"]) {
        return;
    }
    YHPWebViewController* webVc = [[YHPWebViewController alloc]init];
    webVc.url   = button.square.url;
    webVc.title = button.square.name;
    // 取出当前的导航控制器
    UITabBarController* tabVc = (UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController* nav = (UINavigationController*)tabVc.selectedViewController;
    [nav pushViewController:webVc animated:YES];
    
}

/**
 设置背景图片
 NOTE: 默认系统只调用一次
 @param rect 图片区域
 */
//-(void)drawRect:(CGRect)rect
//{
//    [[UIImage imageNamed:@"mainCellBackground"] drawInRect:rect];
//}


@end
