//
//  YHPArenaViewController.m
//  01-彩票
//
//  Created by yhp on 16/5/25.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//  竞技场
//

#import "YHPArenaViewController.h"



@interface YHPArenaViewController ()

@end

@implementation YHPArenaViewController

// 自定义控制器的View,重写该方法后系统将不会给创建view
- (void)loadView
{
    UIImageView* imageView = [[UIImageView alloc]initWithFrame:YHPScreenBounds];
    imageView.image = [UIImage imageNamed:@"NLArenaBackground"];
    imageView.userInteractionEnabled = YES;
    [imageView sizeToFit];
    self.view = imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    UISegmentedControl* seg = [[UISegmentedControl alloc]initWithItems:@[@"足球",@"篮球"]];
    seg.width += 40;
    //  设置背景图片
    [seg setBackgroundImage:[UIImage imageNamed:@"CPArenaSegmentBG"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [seg setBackgroundImage:[UIImage imageNamed:@"CPArenaSegmentSelectedBG"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    seg.selectedSegmentIndex = 0;
    //  设置边宽颜色
    seg.tintColor = YHPColor(0,142,143);
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [seg setTitleTextAttributes:dict forState:UIControlStateSelected];
    
    self.navigationItem.titleView = seg;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
