//
//  YHPDropDownMenu.m
//  01-彩票
//
//  Created by yhp on 16/5/30.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPDropDownMenu.h"
#import "YHPMenuItem.h"

#define YHPCols             3
#define YHPItemWH           YHPScreenW / YHPCols

@interface YHPDropDownMenu ()

@property(nonatomic,strong)NSArray* items;
@property(nonatomic,strong)NSMutableArray* btns;

@end

@implementation YHPDropDownMenu


-(NSMutableArray*)btns
{
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    
    return _btns;
}

#pragma mark - 影藏菜单
-(void)hide
{
    [UIView animateWithDuration:0.5 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, -self.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];

}
#pragma mark - 显示菜单
+(instancetype)showshowInView:(UIView*)superView items:(NSArray*)items oriY:(CGFloat)oriY
{
    NSUInteger count = items.count;
    
    // 3的倍数
    if (count % 3) {
        //  抛出异常
        NSException* excp = [NSException exceptionWithName:@"items不合法" reason:@"传入的数组必须是3的倍数" userInfo:nil];
        [excp raise];
    }
    NSUInteger row = (count - 1) / YHPCols + 1;
    CGFloat itemWH = YHPItemWH;
    CGFloat menuH = itemWH * row;
    CGFloat menuW = YHPScreenW;
    
    YHPDropDownMenu* menu = [[YHPDropDownMenu alloc]initWithFrame:CGRectMake(0, oriY, menuW, menuH)];
    menu.backgroundColor = [UIColor blackColor];
    menu.items = items;
    //  添加按钮
    [menu setUpAllBtn];
    //  添加分割线
    [menu setUpAllDivideView];
    // 添加黑色的view
    UIView* blackView = [[UIView alloc]initWithFrame:menu.frame];
    blackView.backgroundColor = [UIColor blackColor];
    [superView addSubview:blackView];
    //   向下移动的动画
    menu.transform = CGAffineTransformMakeTranslation(0, -menu.height);
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        menu.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [blackView removeFromSuperview];
    }];

    [superView addSubview:menu];
    
    return menu;
}

#pragma mark - 添加分割线
-(void)setUpAllDivideView
{
//    竖
    for (int i = 0; i < YHPCols - 1; i++) {
        UIView* divideV = [[UIView alloc]init];
        divideV.backgroundColor = [UIColor whiteColor];
        divideV.frame = CGRectMake((i+1)*YHPItemWH, 0, 1, self.height);
        [self addSubview:divideV];
    }
//    横
    NSUInteger rows = (self.items.count - 1) / YHPCols + 1;
    for (int i = 0; i < rows - 1; i++) {
        UIView* divideV = [[UIView alloc]init];
        divideV.backgroundColor = [UIColor whiteColor];
        divideV.frame = CGRectMake(0,(i+1)*YHPItemWH, self.width, 1);
        [self addSubview:divideV];
    }

}

#pragma mark - 添加子控件
-(void)setUpAllBtn
{
    for (YHPMenuItem* item in self.items) {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:item.tittle forState:UIControlStateNormal];
        [btn setImage:item.image forState:UIControlStateNormal];
        [self addSubview:btn];
        [self.btns addObject:btn];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //  布局按钮
    NSUInteger count = self.items.count;
    NSUInteger col   = 0;
    NSUInteger row   = 0;
    CGFloat x = 0;
    CGFloat y = 0;
    
    for (NSUInteger i = 0; i < count; i++) {
        UIButton* btn = self.btns[i];
        col = i % YHPCols;
        row = i / YHPCols;
        x = col * YHPItemWH;
        y = row * YHPItemWH;
        btn.frame = CGRectMake(x, y, YHPItemWH, YHPItemWH);
    }
    
}

@end
