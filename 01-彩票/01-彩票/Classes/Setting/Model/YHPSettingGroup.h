//
//  YHPSettingGroup.h
//  01-彩票
//
//  Created by yhp on 16/6/12.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHPSettingGroup : NSObject

/**  */
@property(nonatomic,strong)NSArray* item;
/**  */
@property(nonatomic,strong)NSString* headTittle;
/**  */
@property(nonatomic,strong)NSString* footTittle;

+(instancetype)groupWithItem:(NSArray*)item;

@end
