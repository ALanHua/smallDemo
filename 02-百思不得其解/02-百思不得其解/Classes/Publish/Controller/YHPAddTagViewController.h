//
//  YHPAddTagViewController.h
//  02-百思不得其解
//
//  Created by yhp on 2017/3/2.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHPAddTagViewController : UIViewController
/** 获取tags的block */
@property(nonatomic,copy)void (^tagsBlock)(NSArray* tags);
/** 所有的标签 */
@property(nonatomic,strong)NSArray* tags;

@end
