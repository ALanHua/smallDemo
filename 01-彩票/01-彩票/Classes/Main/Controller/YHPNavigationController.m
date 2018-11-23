//
//  YHPNavigationController.m
//  01-彩票
//
//  Created by yhp on 16/5/27.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPNavigationController.h"
#import "UIImage+YHPImage.h"

#import <objc/runtime.h>

//@interface YHPNavigationController () <UINavigationControllerDelegate>
@interface YHPNavigationController () <UIGestureRecognizerDelegate>
/** poP手势代理 */
@property(nonatomic,strong)id poPDelegate;

@end

@implementation YHPNavigationController


// 程序一起启动的时候调用
+(void)load
{
    
}

// 类或者它的子类初始化的时候调用，调用一次
+ (void)initialize
{
    // 设置应用下的所有UINavigationBar背景样式
//    UINavigationBar* bar = [UINavigationBar appearance];
//    [bar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
    //  获取那个类下面下的导航条，不会修改别人的导航控制器
    UINavigationBar* bar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    [bar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
    // 设置导航条标题颜色
    NSMutableDictionary* tittleAttr = [NSMutableDictionary dictionary];
    tittleAttr[NSForegroundColorAttributeName] = [UIColor whiteColor];
    tittleAttr[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    [bar setTitleTextAttributes:tittleAttr];
#if 0  // 方法 3
    //  调整返回按钮的偏移0
    [bar setTintColor:[UIColor whiteColor]];// 设置返回按钮颜色
    [[UIBarButtonItem appearance]setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -100) forBarMetrics:UIBarMetricsDefault];
#endif
    
#if 0  //方法 2
    //  获取UIBarButtonItem -- 一般不用
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[UIImage imageNamed:@"NavBack"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
#endif
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  还原滑动返回功能 // 方法1
    //  代理做了一个滑动返回的功能，而且做了一些列的判断
#if 0  // 系统自带手势
    self.poPDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
#endif
    
    self.poPDelegate = self.interactivePopGestureRecognizer.delegate;
//    防止手势冲突
    self.interactivePopGestureRecognizer.enabled = NO;
    
    //  自定义手势
    //  取出系统自带手势的target对象，取出某个对象的属性
//   遍历某个类里面的所有属性 Ivar表示
//    class_copyIvarList 只会获取那个类下面的属性，不会遍历父类的成员属性
//    CLASS 获取那个类的成员属性
//    count 告诉当前类的成员属性的总数
//   unsigned int count = 0;
//   Ivar* ivars = class_copyIvarList([UIGestureRecognizer class],&count);
//    for (int i = 0; i < count; i++) {
//        Ivar ivar = ivars[i];
//        //  获取属性名
//        NSString* ivaName = @(ivar_getName(ivar));
//        NSLog(@"%@",ivaName);
//    }
    // _targets 属性名 value
    NSArray* targets = [self.interactivePopGestureRecognizer valueForKeyPath:@"_targets"];
    id objc = [targets firstObject];
    id target = [objc valueForKeyPath:@"_target"];
//  target == self.interactivePopGestureRecognizer.delegate
    UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc]initWithTarget:target action:@selector(handleNavigationTransition:)];
    pan.delegate = self;
    
    [self.view addGestureRecognizer:pan];
    // 系统有滑动手势，系统实现了滑动功能(action)
    
}

#pragma mark -手势代理方法
// 是否触发手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //  判断当前控制器是否是根控制器
    return  self.topViewController != [self.viewControllers firstObject];
}

/*
 <UIScreenEdgePanGestureRecognizer: 0x7f9c22148dd0; state = Possible; delaysTouchesBegan = YES; view = <UILayoutContainerView 0x7f9c2213db80>; target= <(action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7f9c22148850>)>>
 
 系统滑动手势类型：UIScreenEdgePanGestureRecognizer
 target：_UINavigationInteractiveTransition
 action：handleNavigationTransition:
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count != 0) {// 非根控制器,影藏buttonBar
        viewController.hidesBottomBarWhenPushed = YES;
        //  设置导航条左边按钮样式
#if 1   // 方法 1  这时候就没有了滑动返回功能
        UIImage* image = [UIImage imgaeWithOriRenderingImage:@"NavBack"];
        UIBarButtonItem* leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(back)];
        viewController.navigationItem.leftBarButtonItem = leftBarButtonItem;
#endif
#if 0  // 系统自带
        self.interactivePopGestureRecognizer.delegate = nil;
#endif
    }
    [super pushViewController:viewController animated:animated];
}

-(void)back
{
    [self popViewControllerAnimated:YES];
}


/***********废弃***************/

#pragma mark - 导航控制器代理方法
#if 0 // 该处存在潜在的bug，修改如上导航控制器代理方法
// 完全展示完的时候调用
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //  判断是否是根控制器
    if (viewController == [self.viewControllers firstObject]) {
        self.interactivePopGestureRecognizer.delegate = self.poPDelegate;
    }
}


// self -> 导航控制器
- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    UIViewController* vc = [super popViewControllerAnimated:animated];
    if (self.viewControllers.count == 1) {
        self.interactivePopGestureRecognizer.delegate = self.poPDelegate;
    }
    return vc;
}
#endif



@end
