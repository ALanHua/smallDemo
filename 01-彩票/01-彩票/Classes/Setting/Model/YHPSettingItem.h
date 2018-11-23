//
//  YHPSettingItem.h
//  01-彩票
//
//  Created by yhp on 16/6/12.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHPSettingItem : NSObject
/** 图片 */
@property(nonatomic,strong)UIImage* image;
/** 标题 */
@property(nonatomic,strong)NSString* tittle;
@property(nonatomic,strong)NSString* subTittle;

/** block 每一行cell 的功能*/
@property(nonatomic,strong)void(^itemOpertion)(NSIndexPath* indexPath);

+(instancetype)itemWithImage:(UIImage*)image tittle:(NSString*)tittle;

@end
