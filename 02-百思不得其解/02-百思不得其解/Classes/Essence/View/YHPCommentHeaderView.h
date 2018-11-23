//
//  YHPCommentHeaderView.h
//  02-百思不得其解
//
//  Created by yhp on 2016/12/20.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHPCommentHeaderView : UITableViewHeaderFooterView

/** tittle */
@property(nonatomic,copy)NSString* title;

+(instancetype)headerViewWithTableView:(UITableView*)tableView;

@end
