//
//  YHPTextField.m
//  02-百思不得其解
//
//  Created by yhp on 16/9/22.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPTextField.h"
#import <objc/runtime.h>

static NSString* const YHPPlaceholderColorKeyPath = @"_placeholderLabel.textColor";

@implementation YHPTextField

-(void)awakeFromNib
{
    [super awakeFromNib];
   // 设置光标颜色
    self.tintColor = self.textColor;
    [self resignFirstResponder];
}
/**
 *  聚焦
 */
- (BOOL)becomeFirstResponder
{
    [self setValue:self.textColor forKeyPath:YHPPlaceholderColorKeyPath];
    return [super becomeFirstResponder];

}
/**
 *  失去焦点
 */
-(BOOL)resignFirstResponder
{
    [self setValue:[UIColor grayColor] forKeyPath:YHPPlaceholderColorKeyPath];
    return [super becomeFirstResponder];
}


-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
  [self setValue:placeholderColor forKeyPath:YHPPlaceholderColorKeyPath];
}

+(void)initialize
{
    
}

-(void)getProperties
{
    unsigned int count = 0;
    objc_property_t* properties =  class_copyPropertyList([UITextField class], &count);
    
    for (int i = 0; count; i++) {
        objc_property_t property = properties[i];
        YHPLog(@"%s---->%s",property_getName(property),property_getAttributes(property));
    }
    free(properties);
}
-(void)getIvars
{
    unsigned int count = 0;
    Ivar* ivars = class_copyIvarList([UITextField class],&count);
    for (int i = 0; i < count; i++) {
        Ivar iva = *(ivars+i);
        YHPLog(@"%s",ivar_getName(iva));
    }
    // 释放
    free(ivars);
}

//-(void)drawPlaceholderInRect:(CGRect)rect
//{
//    [self.placeholder drawInRect:CGRectMake(0, 15, rect.size.width , 25) withAttributes:@{
//            NSForegroundColorAttributeName:[UIColor whiteColor],
//            NSFontAttributeName:self.font}];
//}
//
//-(void)initialize
//{
//    unsigned int count = 0;
//    Ivar* ivars = class_copyIvarList([UITextField class],&count);
//    for (int i = 0; i < count; i++) {
//        Ivar iva = *(ivars+i);
//        YHPLog(@"%s",ivar_getName(iva));
//    }
//    // 释放
//    free(ivars);
//}
@end
