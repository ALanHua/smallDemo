//
//  YHParenaNavController.m
//  01-彩票
//
//  Created by yhp on 16/6/1.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPArenaNavController.h"

@interface YHPArenaNavController ()

@end

@implementation YHPArenaNavController


+ (void)initialize
{
    //    设置导航条背景颜色
    
    UINavigationBar* bar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    
    UIImage* image = [UIImage imageWithstretchableImage:@"NLArenaNavBar64"];
    
    [bar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
