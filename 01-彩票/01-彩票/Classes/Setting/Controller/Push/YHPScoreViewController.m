//
//  YHPScoreViewController.m
//  01-彩票
//
//  Created by yhp on 16/6/13.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPScoreViewController.h"


@interface YHPScoreViewController ()

@end

@implementation YHPScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpGroup0];
    [self setUpGroup1];
    [self setUpGroup1];
    [self setUpGroup1];
    [self setUpGroup1];
}

-(void)setUpGroup0
{
    YHPSettingItem* item = [YHPSwitchSettingItem itemWithImage:nil tittle:@"推送我关注的比赛"];
    YHPSettingGroup* group = [YHPSettingGroup groupWithItem:@[item]];
    group.footTittle = @"开启后，当我投注或关注的比赛开始、进球和结束时，会自动发送推送消息提醒我";
    
    [self.groups addObject:group];
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

-(void)setUpGroup1
{
    YHPSettingItem* item = [YHPSettingItem itemWithImage:nil tittle:@"起始时间"];
    item.subTittle = @"00:00";
    // block 会把代码里所有强指针全部引用
    __weak typeof(self) weakSelf = self;
//    在iOS7之后只要造cell上添加textfeil都自动做了键盘处理
    item.itemOpertion =  ^(NSIndexPath* indexPath){
        // 获取当前cell
        UITableViewCell* cell = [weakSelf.tableView cellForRowAtIndexPath:indexPath];
        
        UITextField* textField = [[UITextField alloc]init];
        [textField becomeFirstResponder];
        
        [cell addSubview:textField];
    };
    
    YHPSettingGroup* group = [YHPSettingGroup groupWithItem:@[item]];
    group.headTittle = @"只在以下时间段接收比分直播推送";
    
    [self.groups addObject:group];
}

@end
