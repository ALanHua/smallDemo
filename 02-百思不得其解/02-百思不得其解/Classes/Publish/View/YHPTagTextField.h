//
//  YHPTagTextField.h
//  02-百思不得其解
//
//  Created by yhp on 2017/3/9.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHPTagTextField : UITextField

/** 按了删除键的回调 */
@property(nonatomic,copy)void(^deleteBlock)();

@end
