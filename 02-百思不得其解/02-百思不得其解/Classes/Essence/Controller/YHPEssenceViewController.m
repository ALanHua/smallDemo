//
//  YHPEssenceViewController.m
//  02-百思不得其解
//
//  Created by yhp on 16/9/4.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPEssenceViewController.h"
#import "YHPRecommendTagsViewController.h"
#import "YHPTopicViewController.h"

@interface YHPEssenceViewController ()<UIScrollViewDelegate>
@property(nonatomic,weak)UIView* indicatorView;
@property(nonatomic,weak)UIButton* selectedButton;
@property(nonatomic,weak)UIView* titlesView;
@property(nonatomic,weak)UIScrollView* contentView;
@end

@implementation YHPEssenceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNav];
    [self setupChildVces];
    
    [self setupTittleView];
    [self setupContentView];

}

-(void)setupChildVces
{
    YHPTopicViewController* all = [[YHPTopicViewController alloc]init];
    all.title = @"全部";
    all.type = YHPTopicAllType;
    [self addChildViewController:all];
    YHPTopicViewController* video = [[YHPTopicViewController alloc]init];
    video.title = @"视频";
    video.type = YHPTopicVideoType;
    [self addChildViewController:video];
    YHPTopicViewController* voice = [[YHPTopicViewController alloc]init];
    voice.title = @"声音";
    voice.type = YHPTopicVoiceType;
    [self addChildViewController:voice];
    YHPTopicViewController* picture = [[YHPTopicViewController alloc]init];
    picture.title = @"图片";
    picture.type = YHPTopicPictureType;
    [self addChildViewController:picture];
    
    YHPTopicViewController* word = [[YHPTopicViewController alloc]init];
    word.title = @"段子";
    word.type = YHPTopicWordType;
    [self addChildViewController:word];
}
/**
 设置scrollView
 */
-(void)setupContentView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView* contentView = [[UIScrollView alloc]init];
    contentView.frame = self.view.bounds;
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    self.contentView = contentView;
    // 添加第一个控制器
    [self scrollViewDidEndScrollingAnimation:contentView];
}

/**
 * 设置标签栏
 */
-(void)setupTittleView
{
    // 添加标签栏
    UIView* tittleView = [[UIView alloc]init];
    tittleView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    tittleView.width = self.view.width;
    tittleView.height = YHPTitilesViewH;
    tittleView.y = YHPTitilesViewY;
    self.titlesView = tittleView;
    
    [self.view addSubview:tittleView];
    // 底部红色指示器
    UIView* indicatorView = [[UIView alloc]init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = tittleView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    // 添加子标签
//    NSArray* tittles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    CGFloat width = tittleView.width / self.childViewControllers.count;
    CGFloat height = tittleView.height;
    for (NSInteger i = 0; i < self.childViewControllers.count; i++) {
        UIButton* button = [[UIButton alloc]init];
        button.tag = i;
        button.height = height;
        button.width  = width;
        button.x = width * i;
        [button setTitle:self.childViewControllers[i].title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(tittleClick:) forControlEvents:UIControlEventTouchUpInside];
        [tittleView addSubview:button];
        // 默认点击第一个按钮
        if(i == 0){
            button.enabled = NO;
            self.selectedButton = button;
            [button.titleLabel sizeToFit];// 让按钮内部内容更新尺寸
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
        }
    }
    [tittleView addSubview:indicatorView];
}

-(void)tittleClick:(UIButton*)button
{
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    // 滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}

-(void)setupNav
{
    // 设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage: @"MainTagSubIcon"highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    self.view.backgroundColor = YHPGlobalBg;
}

-(void)tagClick
{
    YHPRecommendTagsViewController* tagsVc = [[YHPRecommendTagsViewController alloc]init];
    [self.navigationController pushViewController:tagsVc animated:YES];
}
#pragma mark - <UIScrollViewDelegate>
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 添加子控制器的view
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    UIViewController* vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0; // 设置控制器view的y值为0(默认是20)
    vc.view.height = scrollView.height; // 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self tittleClick:self.titlesView.subviews[index]];
    
}

@end
