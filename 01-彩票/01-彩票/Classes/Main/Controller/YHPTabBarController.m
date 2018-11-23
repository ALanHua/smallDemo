//
//  YHPVTabBarController.m
//  01-彩票
//
//  Created by yhp on 16/5/25.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPTabBarController.h"

// 子控件
#import "YHPHallViewController.h"
#import "YHPArenaViewController.h"
#import "YHPHistoryViewController.h"
#import "YHPDiscoverViewController.h"
#import "YHPMyLotteryViewController.h"

#import "YHPTableBar.h"
#import "YHPNavigationController.h"
#import "YHPArenaNavController.h"
@interface YHPTabBarController () <YHPTableBarDelegate>
/** 所有控制器对应按钮的内容 */
@property(nonatomic,strong)NSMutableArray* items;
@end

@implementation YHPTabBarController

-(NSMutableArray*)items
{
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    
    return _items;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    // 添加5子控件
    [self setUpChildViewController];
    // 自定义tabar
    [self setUpTabBar];
}

#pragma mark - 自定义tabar
-(void)setUpTabBar
{
    // 移除系统的tableBar,相当于把tablebar上的按钮移除
    // 要等下一个运行循环时才会被销毁
//    [self.tabBar removeFromSuperview];
    
    YHPTableBar* tabBar = [[YHPTableBar alloc]init];
    tabBar.items = self.items;
    tabBar.delegate = self;
    tabBar.backgroundColor = [UIColor orangeColor];
    tabBar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:tabBar];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //  把系统的tableBar干掉
    for (UIView* childView in self.tabBar.subviews) {
        if (![childView isKindOfClass:[YHPTableBar class]]) {
            [childView removeFromSuperview];
        }
    }
    
}

#pragma mark - YHPTableBarDelegate - 监听tableBar上的按钮
-(void)tabBar:(YHPTableBar *)tabBar didClickBtn:(NSInteger)index
{
    // 选择对应的tableBarController
    self.selectedIndex = index;
}

#pragma mark - 添加自控制器
// tableBar 上面的图片尺寸不能超过44
- (void)setUpChildViewController
{
    // 购彩大厅
    YHPHallViewController* hall = [[YHPHallViewController alloc]init];
    [self setUpOneChildController:hall image:[UIImage imageNamed:@"TabBar_LotteryHall_new"] selImage:[UIImage imageNamed:@"TabBar_LotteryHall_selected_new"] tittle:@"购彩大厅"];
    // 竞技场
    YHPArenaViewController* arena = [[YHPArenaViewController alloc]init];
    [self setUpOneChildController:arena image:[UIImage imageNamed:@"TabBar_Arena_new"] selImage:[UIImage imageNamed:@"TabBar_Arena_selected_new"] tittle:nil];
    // 发现
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([YHPDiscoverViewController class]) bundle:nil];
    YHPDiscoverViewController* discover = [storyboard instantiateInitialViewController];
    [self setUpOneChildController:discover image:[UIImage imageNamed:@"TabBar_Discovery_new"] selImage:[UIImage imageNamed:@"TabBar_Discovery_selected_new"]tittle:@"发现"];
    // 开奖信息
    YHPHistoryViewController* history = [[YHPHistoryViewController alloc]init];
    [self setUpOneChildController:history image:[UIImage imageNamed:@"TabBar_History_new"] selImage:[UIImage imageNamed:@"TabBar_History_selected_new"] tittle:@"开奖信息"];
    // 我的彩票
    YHPMyLotteryViewController* mylottery = [[YHPMyLotteryViewController alloc]init];
    [self setUpOneChildController:mylottery image:[UIImage imageNamed:@"TabBar_MyLottery_new"] selImage:[UIImage imageNamed:@"TabBar_MyLottery_selected_new"]tittle:@"我的彩票"];
}
#pragma mark - 添加一个子控制器
-(void)setUpOneChildController:(UIViewController*)vc
        image:(UIImage*)image selImage:(UIImage*)selImage
        tittle:(NSString*)tittle
{
    vc.navigationItem.title = tittle;
//    vc.view.backgroundColor = [self randomColor];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selImage;
    [self.items addObject:vc.tabBarItem];
    // 把控制器包装成导航控制器 注意vc 是懒加载的
    UINavigationController* nav = [[YHPNavigationController alloc]initWithRootViewController:vc];
    if ([vc isKindOfClass:[YHPArenaViewController class]]) {
        nav = [[YHPArenaNavController alloc]initWithRootViewController:vc];
    }

    //注意:UIBarMetricsDefault不能随便乱填
    //设置 导航条背景图片，一定要在导航条显示之前设置
//    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
    [self addChildViewController:nav];
}

#pragma mark - 随机颜色
-(UIColor*)randomColor
{
    CGFloat r = arc4random_uniform(256) / 255.0;
    CGFloat g = arc4random_uniform(256) / 255.0;
    CGFloat b = arc4random_uniform(256) / 255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
