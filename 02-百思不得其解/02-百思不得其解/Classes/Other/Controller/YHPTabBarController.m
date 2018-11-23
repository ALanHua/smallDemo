//
//  YHPTabBarController.m
//  02-百思不得其解
//
//  Created by yhp on 16/9/4.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPTabBarController.h"
#import "YHPEssenceViewController.h"
#import "YHPNewViewController.h"
#import "YHPFriendTrendsViewController.h"
#import "YHPMeViewCrontroller.h"
#import "YHPTabBar.h"
#import "YHPNavigationController.h"

@implementation YHPTabBarController
/**
 *  颜色;
 24位 R G B
 *#ff0000  红色
 *#ffff00  黄色
 *#000000  黑色
 *#ffffff  白色
 *#0000ff  蓝色
 *#111111  灰色---rgb值一样的都是灰色
 32位 A R G B
 *#ff0000ff
 
 1024 * 1024 的图片  32位颜色
 内存 1024 * 1024 * 32 / 8 = 1024 * 1024 * 4 字节
 */

+ (void)initialize
{
    // 通过appearance对象统一设置文字属性
    // 后面带有UI_APPEARANCE_SELECTO的对象都可以通过appearance对象设置
    NSMutableDictionary* selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    NSMutableDictionary* attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = selectedAttrs[NSFontAttributeName];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    // 获取全局对象
    UITabBarItem* item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //    2,1 添加子控制器
    [self setUpChildVc:[[YHPEssenceViewController alloc]init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    [self setUpChildVc:[[YHPNewViewController alloc]init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    [self setUpChildVc:[[YHPFriendTrendsViewController alloc]init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    [self setUpChildVc:[[YHPMeViewCrontroller alloc]initWithStyle:UITableViewStyleGrouped] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_icon"];
    //    3,修改TabBar
    [self setValue:[[YHPTabBar alloc]init] forKey:@"tabBar"];
}

/**
 *  初始化子控制器
 *  @param vc            控制器
 *  @param title         标题
 *  @param image         未选中图片
 *  @param selectedImage 选择图片
 */
-(void)setUpChildVc:(UIViewController*)vc title:(NSString*)title image:(NSString*)image selectedImage:(NSString*)selectedImage
{
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    //  包装一个导航控制器，添加导航控制器为tabBarController子控制器
    YHPNavigationController* nav = [[YHPNavigationController alloc]initWithRootViewController:vc];
    [self addChildViewController:nav];
    
}

@end
