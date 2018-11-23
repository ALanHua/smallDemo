//
//  YHPDropDownMenu.h
//  01-彩票
//
//  Created by yhp on 16/5/30.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHPDropDownMenu : UIView

//item(YHPMenuItem)
//@property(nonatomic,strong)NSArray* item;
+(instancetype)showshowInView:(UIView*)superView items:(NSArray*)items oriY:(CGFloat)oriY;
-(void)hide;
@end
