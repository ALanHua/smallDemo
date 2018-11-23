//
//  YHPNewFreatureCell.m
//  01-彩票
//
//  Created by yhp on 16/6/5.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPNewFreatureCell.h"
#import "YHPTabBarController.h"

@interface YHPNewFreatureCell ()
@property(nonatomic,weak)UIImageView* imageView;
@property(nonatomic,weak)UIButton* startButton;

@end

@implementation YHPNewFreatureCell

#pragma mark - startButton 懒加载
- (UIButton *)startButton
{
    if (_startButton == nil) {
        // 苹果提供的类方法，暂时不用考虑weak引用
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setBackgroundImage:[UIImage imageNamed:@"guideStart"] forState:UIControlStateNormal];
        
        [btn sizeToFit];
        
        btn.center = CGPointMake(self.width * 0.5, self.height * 0.9);
        
        [btn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
        
        _startButton = btn;
        
        [self addSubview:btn];
    }
    
    return _startButton;
}

-(UIImageView*)imageView
{
    if (_imageView == nil) {
        UIImageView* imageV = [[UIImageView alloc]initWithFrame:self.bounds];
        _imageView = imageV;
        [self.contentView addSubview:imageV];
    }
    return _imageView;
}

-(void)setImage:(UIImage *)image
{
    _image = image;
    self.imageView.image = image;
    
}

-(void)setUpIndexPath:(NSIndexPath*) indexPath count:(NSInteger)pagCount
{
    if (indexPath.row == pagCount - 1) {
        //  添加立即体验按钮
        self.startButton.hidden = NO;
    }else{
        self.startButton.hidden = YES;
    }
}

#pragma mark - 监听按钮点击事件
-(void)start
{
//   跳转到核心界面 - 切换根控制器
    YHPKeyWindow.rootViewController = [[YHPTabBarController alloc]init];
    CATransition* anim = [CATransition animation];
    anim.duration = 1;
    anim.type = @"moveIn";
    [YHPKeyWindow.layer addAnimation:anim forKey:nil];
}

@end
