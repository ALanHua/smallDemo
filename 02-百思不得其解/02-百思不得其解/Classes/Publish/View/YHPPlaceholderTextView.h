//
//  YHPPlaceholderTextView.h
//  02-百思不得其解
//
//  Created by yhp on 2017/2/21.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//  

#import <UIKit/UIKit.h>

@interface YHPPlaceholderTextView : UITextView
/** 占位位置 */
@property(nonatomic,copy)NSString* placeholder;
/** 占位文字的颜色 */
@property(nonatomic,strong)UIColor* placeholderColor;
@end
