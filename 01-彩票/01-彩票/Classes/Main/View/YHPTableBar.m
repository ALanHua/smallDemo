//
//  YHPTableBar.m
//  01-彩票
//
//  Created by yhp on 16/5/26.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//  

#import "YHPTableBar.h"
#import "YHPTabBarButton.h"
// 需要UITableBar需要一个UITableBarItem
@interface YHPTableBar()

@property(nonatomic,weak)YHPTabBarButton* selButton;

@end

@implementation YHPTableBar

-(void)setItems:(NSArray *)items
{
    _items = items;
    //  UITanleBarItem保存按钮上的图片
    for (UITabBarItem* item in items) {
        YHPTabBarButton* btn = [YHPTabBarButton buttonWithType:UIButtonTypeCustom];
        //  通用
        btn.tag = self.subviews.count;
        
        [btn setBackgroundImage:item.image forState:UIControlStateNormal];
        //  高亮
        [btn setBackgroundImage:item.selectedImage forState:UIControlStateSelected];
        //  知识点 UIControlEventTouchDown <---> touchbegin
        //        UIControlEventTouchInside <---> touchEnd
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        
        [self addSubview:btn];
        
        if (self.subviews.count == 1) {
            [self btnClick:btn];
        }
    }
}

#pragma mark - 监听按键点击
-(void)btnClick:(YHPTabBarButton*)button
{
    _selButton.selected = NO;
    button.selected = YES;
    _selButton = button;
    
    //  通知tableBar切换控制器
    if ([_delegate respondsToSelector:@selector(tabBar:didClickBtn:)]) {
        [self.delegate tabBar:self didClickBtn:button.tag];
    }
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    int count = (int)self.subviews.count;
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = [UIScreen mainScreen].bounds.size.width / count;
    CGFloat h = self.height;
    
    for (int i = 0; i < count; i++) {
        UIButton* btn = self.subviews[i];
        x = i * w;
        btn.frame = CGRectMake(x, y, w, h);
    }
}

-(void)setUp
{

}

@end
