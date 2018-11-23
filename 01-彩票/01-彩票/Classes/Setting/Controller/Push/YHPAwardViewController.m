//
//  YHPAwardViewController.m
//  01-彩票
//
//  Created by yhp on 16/6/14.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPAwardViewController.h"
#import "YHPSettingCell.h"

@interface YHPAwardViewController ()

@end

@implementation YHPAwardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpGroup0];
}

- (void)setUpGroup0
{
    YHPSwitchSettingItem *item = [YHPSwitchSettingItem itemWithImage:nil tittle:@"双色球"];
    item.subTittle = @"每周二、四、日开奖";
    YHPSwitchSettingItem *item1 = [YHPSwitchSettingItem itemWithImage:nil tittle:@"大乐透"];
    item1.subTittle = @"每周一、三、六开奖";
    YHPSwitchSettingItem *item2 = [YHPSwitchSettingItem itemWithImage:nil tittle:@"3D"];
    item2.subTittle = @"每天开奖、包括试机号提醒";
    YHPSwitchSettingItem *item3 = [YHPSwitchSettingItem itemWithImage:nil tittle:@"七乐彩"];
    item3.subTittle = @"每周一、三、五开奖";
    YHPSwitchSettingItem *item4 = [YHPSwitchSettingItem itemWithImage:nil tittle:@"七星彩"];
    item4.subTittle = @"每周二、五、日开奖";
    YHPSwitchSettingItem *item5 = [YHPSwitchSettingItem itemWithImage:nil tittle:@"排列3"];
    item5.subTittle = @"每天开奖";
    YHPSwitchSettingItem *item6 = [YHPSwitchSettingItem itemWithImage:nil tittle:@"排列5"];
    item6.subTittle = @"每天开奖";
    
    YHPSettingGroup *group = [[YHPSettingGroup alloc] init];
    group.item = @[item,item1,item2,item3,item4,item5,item6];
    
    [self.groups addObject:group];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YHPSettingCell* cell = [YHPSettingCell cellWithTableView:tableView style:UITableViewCellStyleSubtitle];
    //    取出哪一组
    YHPSettingGroup* group = self.groups[indexPath.section];
    //    取出哪一行
    YHPSettingItem* item = group.item[indexPath.row];
    //   给cell 传递模型
    cell.item = item;
    
    return cell;
}

@end
