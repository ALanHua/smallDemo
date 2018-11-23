//
//  YHPMenuItem.h
//  01-彩票
//
//  Created by yhp on 16/5/30.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHPMenuItem : NSObject

@property(nonatomic,strong)NSString* tittle;
@property(nonatomic,strong)UIImage* image;


+(instancetype)itemWithImage:(UIImage*)image tittle:(NSString*)tittle;
@end
