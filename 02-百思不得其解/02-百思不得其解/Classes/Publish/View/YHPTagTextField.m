//
//  YHPTagTextField.m
//  02-百思不得其解
//
//  Created by yhp on 2017/3/9.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "YHPTagTextField.h"

@implementation YHPTagTextField

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.placeholder = @"多个标签用逗号或者换行操作";
        // 设置占位文字内容后，才能设备占位文字颜色
        [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        self.height = YHPTagH;
    }
    return self;
}

/**
 监听特定按钮，如 Return 空格等
 @param text 键盘上的字符
 */
//- (void)insertText:(NSString *)text
//{
//    [super insertText:text];
//    YHPLogFunc;
//}

-(void)deleteBackward
{
    !self.deleteBlock ? : self.deleteBlock();
    [super deleteBackward];
}

@end
