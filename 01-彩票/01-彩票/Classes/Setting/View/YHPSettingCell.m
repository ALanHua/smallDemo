//
//  YHPSettingCell.m
//  01-彩票
//
//  Created by yhp on 16/6/12.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPSettingCell.h"
#import "YHPSwitchSettingItem.h"
#import "YHPArrowSettingItem.h"
#import "YHPSettingItem.h"

@interface YHPSettingCell()

@property(nonatomic,strong)UIImageView* arrowView;
@property(nonatomic,strong)UISwitch* switchView;
@end

@implementation YHPSettingCell

#pragma mark - 懒加载
-(UIImageView*)arrowView
{
    if (_arrowView == nil) {
        _arrowView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow_right"]];
    }
    return _arrowView;
}

- (UISwitch *)switchView
{
    if (_switchView == nil) {
        _switchView = [[UISwitch alloc]init];
    }
    return _switchView;
}



+(instancetype)cellWithTableView:(UITableView*)tableView style:(UITableViewCellStyle)style
{
    static NSString* ID = @"cell";
    YHPSettingCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[YHPSettingCell alloc]initWithStyle:style reuseIdentifier:ID];
    }
    
    return cell;
    
}

- (void)setItem:(YHPSettingItem *)item
{
    _item = item;
    // 设置控件上的内容
    [self setUpData];
    // 设置辅助视图
    [self setUpAccessory];
    
}
// 设置控件上的内容
-(void)setUpData
{
    self.textLabel.text = _item.tittle;
    self.detailTextLabel.text = _item.subTittle;
    self.imageView.image = _item.image;
}

-(void)setUpAccessory
{
    if ([_item isKindOfClass:[YHPArrowSettingItem class]]) {
        //  箭头
        self.accessoryView = self.arrowView;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }else if ([_item isKindOfClass:[YHPSwitchSettingItem class]]){
       //  开关
        self.accessoryView = self.switchView;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }else{
        self.accessoryView = nil;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    
    
}

@end
