//
//  YHPTableBar.h
//  01-彩票
//
//  Created by yhp on 16/5/26.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//  模仿下UITableBar

#import <UIKit/UIKit.h>
@class YHPTableBar;

@protocol YHPTableBarDelegate <NSObject>
@optional
-(void)tabBar:(YHPTableBar*)tabBar didClickBtn:(NSInteger)index;

@end

@interface YHPTableBar : UIView

//@property(nonatomic,assign)int itemCount;
// 模型数组 传UITableBarItem模型
@property(nonatomic,strong)NSArray* items;

@property(nonatomic,weak)id<YHPTableBarDelegate> delegate;

@end
