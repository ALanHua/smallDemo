//
//  YHPHallViewController.m
//  01-彩票
//
//  Created by yhp on 16/5/25.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPHallViewController.h"
#import "YHPCover.h"
#import "YHPActiveMenu.h"
#import "YHPMenuItem.h"
#import "YHPDropDownMenu.h"

@interface YHPHallViewController ()<YHPActiveMenuDelegate>

@property(nonatomic,weak)YHPDropDownMenu* dropDownMenu;
@property(nonatomic,assign)BOOL isPopMenu;
@end

@implementation YHPHallViewController


-(YHPDropDownMenu*)dropDownMenu
{
    if (_dropDownMenu == nil) {
        // 弹出黑色菜单
        YHPMenuItem* item = [YHPMenuItem itemWithImage:[UIImage imageNamed:@"Development"] tittle:nil];
        YHPMenuItem* item1 = [YHPMenuItem itemWithImage:[UIImage imageNamed:@"Development"] tittle:nil];
        YHPMenuItem* item2 = [YHPMenuItem itemWithImage:[UIImage imageNamed:@"Development"] tittle:nil];
        YHPMenuItem* item3 = [YHPMenuItem itemWithImage:[UIImage imageNamed:@"Development"] tittle:nil];
        YHPMenuItem* item4 = [YHPMenuItem itemWithImage:[UIImage imageNamed:@"Development"] tittle:nil];
        YHPMenuItem* item5 = [YHPMenuItem itemWithImage:[UIImage imageNamed:@"Development"] tittle:nil];
        NSArray* items = @[item,item1,item2,item3,item4,item5];
        _dropDownMenu = [YHPDropDownMenu showshowInView:self.view items:items oriY:0];
    }
    
    return _dropDownMenu;
}

// 知识点: 不能设置导航条的背景颜色
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  左边按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imgaeWithOriRenderingImage:@"CS50_activity_image"] style:UIBarButtonItemStylePlain target:self action:@selector(active)];
    //  添加右边按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imgaeWithOriRenderingImage:@"Development"] style:UIBarButtonItemStylePlain target:self action:@selector(popMenu)];
}

#pragma mark - 点击活动
-(void)active
{
//    NSLog(@"点击活动");
//    弹出蒙版，蒙版上有关活动菜单
    [YHPCover show];
//    弹出活动菜单
    YHPActiveMenu* menu = [YHPActiveMenu showInPoint:self.view.center];
    menu.delegate = self;
}

#pragma mark - YHPActiveMenuDelegate
-(void)activeMenuDidClickCloseBtn:(YHPActiveMenu*)menu
{
    [YHPActiveMenu hideInPoint:CGPointMake(44, 44) completion:^{
         [YHPCover hide];
    }];
}

#pragma mark - 点击菜单
-(void)popMenu
{
    if (_isPopMenu == NO) {
        [self dropDownMenu];
    }else{
        //  影藏菜单
        [self.dropDownMenu hide];
    }
    
    _isPopMenu = !_isPopMenu;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
