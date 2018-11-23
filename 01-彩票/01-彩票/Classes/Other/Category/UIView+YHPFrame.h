//
//  UIView+YHPFrame.h
//  01-彩票
//
//  Created by yhp on 16/5/29.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YHPFrame)


//@property如果在分类里面,只会生成get和set方法的声明,不会生成属性
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat x;
@property(nonatomic,assign)CGFloat y;
@property(nonatomic,assign)CGFloat centerX;
@property(nonatomic,assign)CGFloat centerY;

@end
