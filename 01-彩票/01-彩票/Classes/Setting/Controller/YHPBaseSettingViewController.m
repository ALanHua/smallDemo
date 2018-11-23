//
//  YHPBaseSettingViewController.m
//  01-彩票
//
//  Created by yhp on 16/6/13.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPBaseSettingViewController.h"
#import "YHPSettingCell.h"

@interface YHPBaseSettingViewController ()

@end

@implementation YHPBaseSettingViewController
#pragma mark - 懒加载
-(NSMutableArray*)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    
    return _groups;
}

- (instancetype)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setUpGroup1];
}
#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    YHPSettingGroup* group = self.groups[section];
    return group.item.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    YHPSettingCell* cell = [YHPSettingCell cellWithTableView:tableView style:UITableViewCellStyleDefault];
    //    取出哪一组
    YHPSettingGroup* group = self.groups[indexPath.section];
    //    取出哪一行
    YHPSettingItem* item = group.item[indexPath.row];
    //   给cell 传递模型
    cell.item = item;
    
    return cell;
}

// 返回头部标题
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    YHPSettingGroup* group = self.groups[section];
    return group.headTittle;
}

// 返回尾部标题
-(NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    YHPSettingGroup* group = self.groups[section];
    return group.footTittle;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 取出模型
    YHPSettingGroup* group = self.groups[indexPath.section];
    YHPSettingItem* item = group.item[indexPath.row];
    
    if (item.itemOpertion) {
        item.itemOpertion(indexPath);
        return;
    }
    
    if ([item isKindOfClass:[YHPArrowSettingItem class]]) {
        YHPArrowSettingItem* arrowItem = (YHPArrowSettingItem*)item;
        if (arrowItem) {
            UIViewController* vc = [[arrowItem.destVc alloc]init];
            vc.title = item.tittle;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
}
@end