 //
//  YHPFriendTrendsViewController.m
//  02-百思不得其解
//
//  Created by yhp on 16/9/4.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPFriendTrendsViewController.h"
#import "YHPRecommendViewController.h"
#import "YHPLoginRegisterViewController.h"

@implementation YHPFriendTrendsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 设置导航栏标题
    self.navigationItem.title = @"我的关注";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon"highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsButtonClick)];
    self.view.backgroundColor = YHPGlobalBg;
    
}

-(void)friendsButtonClick
{
    YHPRecommendViewController* vc = [[YHPRecommendViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 *  登录
 */
- (IBAction)loginRegister {
    YHPLoginRegisterViewController* login = [[YHPLoginRegisterViewController alloc]init];
    [self presentViewController:login animated:YES completion:nil];
}

@end
