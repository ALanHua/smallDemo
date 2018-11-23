//
//  YHPBaseSettingViewController.h
//  01-彩票
//
//  Created by yhp on 16/6/13.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHPArrowSettingItem.h"
#import "YHPSettingGroup.h"
#import "YHPSwitchSettingItem.h"
#import "YHPSettingItem.h"

@interface YHPBaseSettingViewController : UITableViewController

/** 记录tableView数组总数 */
@property(nonatomic,strong)NSMutableArray* groups;

@end
