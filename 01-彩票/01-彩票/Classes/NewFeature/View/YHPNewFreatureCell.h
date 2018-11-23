//
//  YHPNewFreatureCell.h
//  01-彩票
//
//  Created by yhp on 16/6/5.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHPNewFreatureCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *image;

-(void)setUpIndexPath:(NSIndexPath*) indexPath count:(NSInteger)pagCount;

@end
