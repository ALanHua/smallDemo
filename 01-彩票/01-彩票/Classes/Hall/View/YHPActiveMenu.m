//
//  YHPActiveMenu.m
//  01-彩票
//
//  Created by yhp on 16/5/29.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPActiveMenu.h"
#import "YHPCover.h" // 耦合性太强

@implementation YHPActiveMenu


- (IBAction)close:(UIButton *)sender {
    
    if ([_delegate respondsToSelector:@selector(activeMenuDidClickCloseBtn:)]) {
        [_delegate activeMenuDidClickCloseBtn:self];
    }
//    [YHPActiveMenu hideInPoint:CGPointMake(44, 44)];
}


+(instancetype)activeMenu
{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([YHPActiveMenu class]) owner:nil options:nil][0];
}
#pragma mark - 显示菜单
+(instancetype)showInPoint:(CGPoint)point
{
    YHPActiveMenu* menu = [YHPActiveMenu activeMenu];
    menu.center = point;
//    //   向下移动的动画
//    menu.transform = CGAffineTransformMakeTranslation(0, -menu.height);
//    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        menu.transform = CGAffineTransformIdentity;
//    } completion:^(BOOL finished) {
//        
//    }];
    
    [YHPKeyWindow addSubview:menu];
    
    return menu;
}

#pragma mark - 影藏菜单
+(void)hideInPoint:(CGPoint)point completion:(void(^)())completion
{
    for (YHPActiveMenu* childView in YHPKeyWindow.subviews) {
        if ([childView isKindOfClass:self]) {
            [childView setUpHideAnim:point completion:^{
                //  动画执行完成的时候会调用
                if (completion) {
                    completion();
                }
            }];
        }
    }
}

#pragma mark - 隐藏动画
-(void)setUpHideAnim:(CGPoint)point completion:(void(^)())completion
{
    //  当前控件移动到某个位置，模板也要消失
    //  注意:修改父类的frame并不会影响子控件
    [UIView animateWithDuration:0.25 animations:^{
        //        self.frame = CGRectMake(44, 44, 0, 0);
        // 设置子控件的尺寸
        //        [self.subviews makeObjectsPerformSelector:@selector(setBounds:) withObject:[NSValue valueWithCGRect:CGRectZero]];
        //        利用自动布局解决了子控件随着父控件的尺寸改变而改变
        CGAffineTransform transform = CGAffineTransformIdentity;
        
        transform  = CGAffineTransformTranslate(transform, -self.center.x + point.x, -self.center.y + point.y);
        transform = CGAffineTransformScale(transform,0.01, 0.01);// 父控件马上消失
        self.transform = transform;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
//        [YHPCover hide];
        if (completion) {
            completion();
        }
    }];
}

@end
