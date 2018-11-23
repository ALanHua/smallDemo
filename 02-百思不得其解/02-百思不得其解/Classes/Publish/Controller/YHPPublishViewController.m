//
//  YHPPublishView.m
//  02-百思不得其解
//
//  Created by yhp on 2016/11/14.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPPublishViewController.h"
#import "YHPVerticalButton.h"
#import "YHPPostWordViewController.h"
#import "YHPNavigationController.h"
#import <pop/POP.h>
#import "YHPLoginTool.h"

@interface YHPPublishViewController ()
/** 标语 */
@property(nonatomic,strong)UIImageView* sloganView;

@end

static CGFloat const YHPAnimationDelay = 0.1;
static CGFloat const YHPSpringFactor = 10;

@implementation YHPPublishViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.userInteractionEnabled = NO;
    // 数据
    NSArray* inages = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray* titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    // 中间六个按钮
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartY = (YHPScreenH - 2*buttonH) * 0.5;
    CGFloat buttonStartX = 15;
    CGFloat xMargin = (YHPScreenW - 2 * buttonStartX - buttonW * maxCols) / (maxCols - 1);
    for (int i = 0; i < inages.count; i++) {
        YHPVerticalButton* button = [[YHPVerticalButton alloc]init];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [self.view addSubview:button];
        // 设置内容
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:inages[i]] forState:UIControlStateNormal];
        // frame
        int row = i / maxCols;
        int col = i % maxCols;
        CGFloat buttonX = buttonStartX + col * (xMargin + buttonW);
        CGFloat buttonEndY = buttonStartY + row * buttonH;
        CGFloat buttonBeginY = buttonEndY - YHPScreenH;
        // 添加动画
        POPSpringAnimation* anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH)];
        anim.toValue =  [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];// 修改frame
        anim.springBounciness = YHPSpringFactor;
        anim.springSpeed = YHPSpringFactor;
        anim.beginTime = CACurrentMediaTime() + YHPAnimationDelay * i;
        [button pop_addAnimation:anim forKey:nil];
    }
    // 添加标语
    UIImageView* sloganView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self.view addSubview:sloganView];
    POPSpringAnimation* anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat centerX = YHPScreenW * 0.5;
    CGFloat centerEndY = YHPScreenH * 0.2;
    CGFloat centerBeginY = centerEndY - YHPScreenH;
    sloganView.centerY = centerBeginY;
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerBeginY)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
    anim.beginTime = CACurrentMediaTime() + inages.count * YHPAnimationDelay;
    anim.springBounciness = YHPSpringFactor;
    anim.springSpeed = YHPSpringFactor;
    [anim setCompletionBlock:^(POPAnimation * anim, BOOL finished) {
        // 动画执行完毕，恢复交互
        self.view.userInteractionEnabled = YES;
    }];
    [sloganView pop_addAnimation:anim forKey:nil];
}

-(void)cancelWithCompletionBlock:(void(^)())completionBlock
{
    // 加载过程屏蔽用户操作
    self.view.userInteractionEnabled = NO;
    int beginIndex = 1;
    // 添加动画
    for (int i = 1; i < self.view.subviews.count; i++) {
        UIView* subview = self.view.subviews[i];
        POPBasicAnimation* anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerY = subview.centerY + YHPScreenH;
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subview.centerX, centerY)];
        // 效果是一开始很慢，后面很快
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        anim.beginTime = CACurrentMediaTime() + (i - beginIndex) * YHPAnimationDelay;
        [subview pop_addAnimation:anim forKey:nil];
        // 监听最后一个动画
        if(i == self.view.subviews.count -1){
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
               [self dismissViewControllerAnimated:NO completion:nil];
                // 执行完成调用block
                !completionBlock ? : completionBlock();
            }];
        }
    }
}
/**
 监听按钮点击
 @param button 被点击按钮
 */
-(void)buttonClick:(UIButton*)button
{
    [self cancelWithCompletionBlock:^{
        if (button.tag == 2) {
            // 判断是否登录
            if ([YHPLoginTool getUid] == nil) {
                return;
            }
            YHPPostWordViewController* postWordVc = [[YHPPostWordViewController alloc]init];
            YHPNavigationController* nav = [[YHPNavigationController alloc]initWithRootViewController:postWordVc];
            // 不能使用self
            UIViewController* root = [UIApplication sharedApplication].keyWindow.rootViewController;
            [root presentViewController:nav animated:YES completion:nil];
        }//....
    }];
    
}

- (IBAction)cancel {
    [self cancelWithCompletionBlock:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self cancelWithCompletionBlock:nil];
}

/**
 pop 使用简介
 */
-(void)popDemo
{
    /*
     pop和Core Animation的区别
     1，Core Animation 添加到layer上
     2，pop动画能添加到任何对象
     3，pop的底层实现基于CADisplayLink
     4,Core Animation 仅仅是表象，并不会修改frame 的frame size 只是表象
     5,pop 会实时修改对象属性，真正修改对象的属性
     */
    POPSpringAnimation* anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    anim.springSpeed = 20;
    anim.beginTime = CACurrentMediaTime() + 1.0;
    anim.springBounciness = 20;
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
    anim.completionBlock = ^(POPAnimation* anim,BOOL finished) {
        YHPLog(@"----动画完成");
    };
    [self.sloganView pop_addAnimation:anim forKey:nil];// key 主要是为了方便查找这个动画
}
@end
