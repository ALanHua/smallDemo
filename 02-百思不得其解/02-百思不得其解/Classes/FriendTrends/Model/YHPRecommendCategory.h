//
//  YHPRecommendCategory.h
//  02-百思不得其解
//
//  Created by yhp on 16/9/7.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHPRecommendCategory : NSObject

/** id */
@property(nonatomic,assign)NSInteger ID;
/** 总数 */
@property(nonatomic,assign)NSInteger count;
/** 名字 */
@property(nonatomic,copy)NSString* name;
/** 这个类别对应的用户数据**/
@property(nonatomic,strong)NSMutableArray* users;
/** 当前页数 */
@property(nonatomic,assign)NSInteger currentPage;
/**  总数*/
@property(nonatomic,assign)NSInteger total;
@end
