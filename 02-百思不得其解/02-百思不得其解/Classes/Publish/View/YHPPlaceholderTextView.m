//
//  YHPPlaceholderTextView.m
//  02-百思不得其解
//
//  Created by yhp on 2017/2/21.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "YHPPlaceholderTextView.h"

@interface YHPPlaceholderTextView()
/* 占位文字*/
@property(nonatomic,weak)UILabel* placeholderLabel;

@end

@implementation YHPPlaceholderTextView

-(UILabel*)placeholderLabel
{
    if (!_placeholderLabel) {
        UILabel* placeholderLabel = [[UILabel alloc]init];
        placeholderLabel.numberOfLines = 0;
        placeholderLabel.x = 4;
        placeholderLabel.y = 7;
        [self addSubview:placeholderLabel];
        _placeholderLabel = placeholderLabel;
    }
    return _placeholderLabel;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 垂直方向上永远有弹簧的效果
        self.alwaysBounceVertical = YES;
        
        self.font = [UIFont systemFontOfSize:15];
        // 默认占位文字
        self.placeholderColor = [UIColor grayColor];
        // 监听文字改变
        [YHPNoteCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}
-(void)dealloc
{
    [YHPNoteCenter removeObserver:self];
}


/**
 监听文字改变
 */
-(void)textDidChange
{
    // [self setNeedsDisplay];
    // 只要有文字, 就隐藏占位文字label
    self.placeholderLabel.hidden = self.hasText;
}


/**
 绘制占位文字
 @param rect 位置
 */
/*
- (void)drawRect:(CGRect)rect
{
    if (self.hasText) {
        return;
    }
    rect.origin.x = 3;
    rect.origin.y = 7;
    rect.size.width -= 2 * rect.origin.x;
    
    [super drawRect:rect];
    NSMutableDictionary* attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor;
    [self.placeholder drawInRect:rect withAttributes:attrs];
}
 */

-(void)layoutSubviews
{
    //CGSize maxSize = CGSizeMake(YHPScreenW - 2 * self.placeholderLabel.x, MAXFLOAT);
    //self.placeholderLabel.size = [self.placeholder boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.font} context:nil].size;
    [super layoutSubviews];
    self.placeholderLabel.width = self.width - 2 * self.placeholderLabel.x;
    [self.placeholderLabel sizeToFit];
}

#pragma mark - 重写setter方法
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
   // [self setNeedsDisplay];
    self.placeholderLabel.textColor = placeholderColor;
}

-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    // [self setNeedsDisplay];
    self.placeholderLabel.text = placeholder;
    
    [self setNeedsLayout];
}

-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeholderLabel.font = font;
    [self setNeedsLayout];
   // [self setNeedsDisplay];
}

-(void)setText:(NSString *)text
{
  //  [self setNeedsDisplay];
    [super setText:text];
    [self textDidChange];
}

-(void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    // [self setNeedsDisplay];
    [self textDidChange];
}


@end
