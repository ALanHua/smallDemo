//
//  YHPActiveMenu.h
//  01-彩票
//
//  Created by yhp on 16/5/29.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHPActiveMenu;

@protocol YHPActiveMenuDelegate <NSObject>

@optional
-(void)activeMenuDidClickCloseBtn:(YHPActiveMenu*)menu;

@end


@interface YHPActiveMenu : UIView

@property(nonatomic,weak)id<YHPActiveMenuDelegate>delegate;
// 如果一个控件从xib加载，控件的尺寸默认和xib一样大
+(instancetype)activeMenu;
+(instancetype)showInPoint:(CGPoint)point;
+(void)hideInPoint:(CGPoint)point completion:(void(^)())completion;

@end
