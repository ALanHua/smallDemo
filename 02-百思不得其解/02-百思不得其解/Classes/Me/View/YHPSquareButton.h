//
//  YHPSquareButton.h
//  02-百思不得其解
//
//  Created by yhp on 2017/2/13.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHPSquare;
@interface YHPSquareButton : UIButton

/** 方块模型 */
@property(nonatomic,strong)YHPSquare* square;
@end
