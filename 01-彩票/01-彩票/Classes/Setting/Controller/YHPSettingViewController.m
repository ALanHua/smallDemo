//
//  YHPSettingViewController.m
//  01-彩票
//
//  Created by yhp on 16/6/7.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPSettingViewController.h"
#import "YHPSettingItem.h"
#import "YHPArrowSettingItem.h"
#import "YHPSwitchSettingItem.h"
#import "YHPSettingGroup.h" 
#import "YHPSettingCell.h"
// 第三方框架
#import "YHPBlurView.h"
#import "MBProgressHUD+XMG.h"
// 跳转界面
#import "YHPPushViewController.h"
#import "YHPHelpViewController.h"

@interface YHPSettingViewController ()

@end

@implementation YHPSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    //  添加常见问题按钮
    UIBarButtonItem* item = [[UIBarButtonItem alloc]initWithTitle:@"常见问题" style:UIBarButtonItemStylePlain target:self action:@selector(help)];
    item.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = item;
    
    //  添加第一组
    [self setUpGroup0];
    [self setUpGroup1];
    [self setUpGroup2];
}

-(void)help
{
    YHPHelpViewController* help = [[YHPHelpViewController alloc]init];
    help.title = @"帮助"; 
    [self.navigationController pushViewController:help animated:YES];
}

-(void)setUpGroup0
{
    YHPArrowSettingItem* redeemCode = [YHPArrowSettingItem itemWithImage:[UIImage imageNamed:@"RedeemCode"] tittle:@"使用兑换码"];
    redeemCode.destVc = [UIViewController class];
    YHPSettingGroup* group = [YHPSettingGroup groupWithItem:@[redeemCode]];
    group.headTittle = @"RedeemCode";
    [self.groups addObject:group];
}

-(void)setUpGroup1
{
    YHPArrowSettingItem* morePush = [YHPArrowSettingItem itemWithImage:[UIImage imageNamed:@"MorePush"] tittle:@"推送和提醒"];
    morePush.destVc = [YHPPushViewController class];
    
    YHPSwitchSettingItem* homeshake = [YHPSwitchSettingItem itemWithImage:[UIImage imageNamed:@"more_homeshake"] tittle:@"使用摇一摇机选"];
    YHPSwitchSettingItem* sound = [YHPSwitchSettingItem itemWithImage:[UIImage imageNamed:@"sound_Effect"] tittle:@"声音效果"];
    YHPSwitchSettingItem* recommend = [YHPSwitchSettingItem itemWithImage:[UIImage imageNamed:@"More_LotteryRecommend"] tittle:@"购彩小助手"];
    
    
    
    YHPSettingGroup* group = [YHPSettingGroup groupWithItem:@[morePush,homeshake,sound,recommend]];
    
    [self.groups addObject:group];
}

-(void)setUpGroup2
{
    YHPArrowSettingItem* version = [YHPArrowSettingItem itemWithImage:[UIImage imageNamed:@"RedeemCode"] tittle:@"检测当前版本"];
   
    version.itemOpertion = ^(NSIndexPath* indexPath){
        YHPBlurView* blurView = [[YHPBlurView alloc]initWithFrame:YHPScreenBounds];
        [YHPKeyWindow addSubview:blurView];
        [MBProgressHUD showSuccess:@"当前没有最新的版本"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [blurView removeFromSuperview];
        });
    };
    
    YHPArrowSettingItem* share = [YHPArrowSettingItem itemWithImage:[UIImage imageNamed:@"MoreShare"] tittle:@"分享"];
    YHPArrowSettingItem* item1 = [YHPArrowSettingItem itemWithImage:[UIImage imageNamed:@"MoreNetease"] tittle:@"产品推荐"];
    YHPArrowSettingItem* item2 = [YHPArrowSettingItem itemWithImage:[UIImage imageNamed:@"MoreAbout"] tittle:@"关于"];
    
    YHPSettingGroup* group = [YHPSettingGroup groupWithItem:@[version,share,item1,item2]];
    
    [self.groups addObject:group];
}

@end