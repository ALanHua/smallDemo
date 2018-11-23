 //
//  YHPHelpViewController.m
//  01-彩票
//
//  Created by yhp on 16/6/14.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPHelpViewController.h"
#import "YHPHtmlItem.h"

#import "YHPNavigationController.h"
#import "YHPHtmlViewController.h"

@interface YHPHelpViewController ()

/** 保存json数据的数组 */
@property(nonatomic,strong)NSMutableArray* htmls;

@end

@implementation YHPHelpViewController


- (instancetype)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

#pragma mark - 懒加载
- (NSMutableArray *)htmls
{
    if (_htmls == nil) {
        _htmls = [NSMutableArray array];
        
        NSString* filePath = [[NSBundle mainBundle] pathForResource:@"help.json" ofType:nil];
        NSData* data = [NSData dataWithContentsOfFile:filePath];
         //  解析json数据
       NSArray* dictArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        for (NSDictionary* dict in dictArr) {
            YHPHtmlItem* item = [YHPHtmlItem itemWithDict:dict];
            [_htmls addObject:item];
        }
        
    }
    return _htmls;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpGroup];
}

-(void)setUpGroup
{
    
    [self htmls];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.htmls.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* ID = @"cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    YHPHtmlItem* item = self.htmls[indexPath.row];
    
    cell.textLabel.text = item.title;
    
    
    return cell;
}

// 点击cell的时候调用
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YHPHtmlItem* item = self.htmls[indexPath.row];
//    modeal 出一个导航控制器
    YHPHtmlViewController* htmlVc = [[YHPHtmlViewController alloc]init];
    htmlVc.title = item.title;
    htmlVc.htmlItem = item;
    YHPNavigationController  * nav = [[YHPNavigationController alloc]initWithRootViewController:htmlVc];
   
    [self presentViewController:nav animated:YES completion:nil];
    
}


@end
