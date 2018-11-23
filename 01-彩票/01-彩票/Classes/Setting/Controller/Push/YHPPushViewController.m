//
//  YHPPushViewController.m
//  01-彩票
//
//  Created by yhp on 16/6/13.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPPushViewController.h"
#import "YHPScoreViewController.h"
#import "YHPAwardViewController.h"

@interface YHPPushViewController ()

@end

@implementation YHPPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpGroup1];
}

-(void)setUpGroup1
{
    YHPArrowSettingItem* morePush = [YHPArrowSettingItem itemWithImage:nil tittle:@"开奖推送"];
    morePush.destVc = [YHPAwardViewController class];
    
    YHPArrowSettingItem* homeshake = [YHPArrowSettingItem itemWithImage:nil tittle:@"比分直播"];
    homeshake.destVc = [YHPScoreViewController class];
    
    YHPArrowSettingItem* sound = [YHPArrowSettingItem itemWithImage:nil tittle:@"使用兑换码"];
    YHPArrowSettingItem* recommend = [YHPArrowSettingItem itemWithImage:nil tittle:@"使用兑换码"];
    
    YHPSettingGroup* group = [YHPSettingGroup groupWithItem:@[morePush,homeshake,sound,recommend]];
    
    [self.groups addObject:group];
}

@end