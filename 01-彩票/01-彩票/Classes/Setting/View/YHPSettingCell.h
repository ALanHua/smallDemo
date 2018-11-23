//
//  YHPSettingCell.h
//  01-彩票
//
//  Created by yhp on 16/6/12.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHPSettingItem;

@interface YHPSettingCell : UITableViewCell

/**  */
@property(nonatomic,strong)YHPSettingItem* item;

+(instancetype)cellWithTableView:(UITableView*)tableView style:(UITableViewCellStyle)style;


@end
