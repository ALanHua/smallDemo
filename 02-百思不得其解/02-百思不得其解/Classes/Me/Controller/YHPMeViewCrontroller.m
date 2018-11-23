//
//  YHPMeViewCrontroller.m
//  02-百思不得其解
//
//  Created by yhp on 16/9/4.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPMeViewCrontroller.h"
#import "YHPMeCell.h"
#import "YHPMeFooterView.h"
#import <AFNetworking.h>
#import "YHPSettingViewController.h"

@implementation YHPMeViewCrontroller

static NSString* YHPMeId = @"me";

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 设置导航栏标题
    [self setUpNav];
    [self setUpTableView];
    
}

-(void)setUpTableView
{
    self.tableView.backgroundColor = YHPGlobalBg;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[YHPMeCell class] forCellReuseIdentifier:YHPMeId];
    // 调整footer/header 内边距
    self.tableView.sectionFooterHeight = YHPTopicCellMargin;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    // 设置footerView
    self.tableView.tableFooterView = [[YHPMeFooterView alloc]init];
}

-(void)setUpNav
{
    self.navigationItem.title = @"我的";
    
    UIBarButtonItem* settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    
    UIBarButtonItem* nightModeItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(nightModeClick)];
    
    self.navigationItem.rightBarButtonItems =@[settingItem,nightModeItem];
}




-(void)settingClick
{
    YHPSettingViewController* vc = [[YHPSettingViewController alloc]initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)nightModeClick
{
    YHPLogFunc;
}

#pragma mark -- 数据源方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YHPMeCell* cell = [tableView dequeueReusableCellWithIdentifier:YHPMeId];
    
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
        cell.textLabel.text = @"登录/注册";
    }else if (indexPath.section == 1){
        cell.textLabel.text = @"离线下载";
    }
 
    return cell;
}



@end
