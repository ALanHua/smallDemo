//
//  UIView+YHPExtension.h
//  02-百思不得其解
//
//  Created by yhp on 16/9/5.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YHPExtension)

@property(nonatomic,assign)CGSize size;
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,assign)CGFloat x;
@property(nonatomic,assign)CGFloat y;
@property(nonatomic,assign)CGFloat centerX;
@property(nonatomic,assign)CGFloat centerY;

-(BOOL)isShowingOnKeyWindow;
/**
 *  在分类中声明property，只会生成方法的声明，不会生成方法的
    实现和带有下划线的成员变量
 */
+(instancetype)viewFromXib;

@end
