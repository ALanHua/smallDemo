//
//  YHPAddTagViewController.m
//  02-百思不得其解
//
//  Created by yhp on 2017/3/2.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "YHPAddTagViewController.h"
#import "YHPTagButton.h"
#import "YHPTagTextField.h"
#import <SVProgressHUD.h>

@interface YHPAddTagViewController () <UITextFieldDelegate>
@property(nonatomic,weak)UIView* contentView;
@property(nonatomic,weak)YHPTagTextField* textField;
@property(nonatomic,weak)UIButton* addButton;
/** 所有的标签按钮 */
@property(nonatomic,strong)NSMutableArray* tagButtons;

@end

@implementation YHPAddTagViewController

#pragma mark -- 懒加载
- (UIButton *)addButton
{
    if (!_addButton) {
        UIButton* addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        addButton.contentEdgeInsets = UIEdgeInsetsMake(0, YHPTagMargin, 0, YHPTagMargin);
        [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        addButton.backgroundColor = YHPTagBg;
        addButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:addButton];
        _addButton = addButton;
    }
    return _addButton;
}

- (NSMutableArray *)tagButtons
{
    if (!_tagButtons) {
        _tagButtons = [NSMutableArray array];
    }
    return _tagButtons;
}

- (UIView *)contentView
{
    if (!_contentView) {
        UIView* contentView = [[UIView alloc]init];
        [self.view addSubview:contentView];
        self.contentView = contentView;
    }
    return _contentView;
}

- (YHPTagTextField *)textField
{
    if (!_textField) {
        __weak typeof(self) weakSelf = self;
        YHPTagTextField* textField = [[YHPTagTextField alloc]init];
        textField.deleteBlock = ^{
            if ([weakSelf.textField hasText]) {
                return;
            }
            [weakSelf addTagClick:[weakSelf.tagButtons lastObject]];
        };
        textField.delegate = self;
        [textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
        [textField becomeFirstResponder];
        [self.contentView addSubview:textField];
        self.textField = textField;
    }
    return _textField;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNav];
}

-(void)setUpTags
{
    if (self.tags.count) {
        for (NSString* tag in self.tags) {
            self.textField.text = tag;
            [self addButtonClick];
        }
        self.tags = nil;
    }

}

-(void)setUpNav
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"添加标签";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
}

#pragma mark - 监听文字改变
/**
 监听文字改变
 */
-(void)textDidChange
{
    // 更新标签和文本框的frame
    [self updateTextFieldFrame];
    
    if ([self.textField hasText]) { // 有蚊子
        // 显示添加标签按钮
        self.addButton.hidden = NO;
        self.addButton.y = CGRectGetMaxY(self.textField.frame) + YHPTagMargin;
        [self.addButton setTitle:[NSString stringWithFormat:@"添加标签%@",self.textField.text] forState:UIControlStateNormal];
        // 获得最后一个字符
        NSString* text = self.textField.text;
        NSUInteger len = text.length;
        NSString* lastCharacter = [text substringFromIndex:len -1];
        if (([lastCharacter isEqualToString:@","]
        || [lastCharacter isEqualToString:@"，"])
        && len > 1) {
           // 取出逗号
            self.textField.text = [text substringToIndex:len -1];
            [self addButtonClick];
        }
    }else{ // 没有文字
        // 影藏添加安妮
        self.addButton.hidden = YES;
    }
 
}

#pragma mark - 监听按钮点击
/**
 监听加号按钮点击
 */
-(void)addButtonClick
{
    if (self.tagButtons.count == 5) {
        [SVProgressHUD showErrorWithStatus:@"最多5个标签"];
        return;
    }
    
    YHPTagButton* tagButton = [YHPTagButton buttonWithType:UIButtonTypeCustom];
    [tagButton addTarget:self action:@selector(addTagClick:) forControlEvents:UIControlEventTouchUpInside];
    [tagButton setTitle:self.textField.text forState:UIControlStateNormal];
    [tagButton setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
    tagButton.height = self.textField.height;
    [self.contentView addSubview:tagButton];
    [self.tagButtons addObject:tagButton];
    // 更新frame
    [self updatTagButtonFrame];
    [self updateTextFieldFrame];
    // 清空textField的文字
    self.textField.text = nil;
    self.addButton.hidden = YES;
}

/**
 监听标签按钮
 @param tagButton 标签按钮
 */
-(void)addTagClick:(YHPTagButton*)tagButton
{
    [tagButton removeFromSuperview];
    [self.tagButtons removeObject:tagButton];
    // 更新frame
    [UIView animateWithDuration:0.25 animations:^{
        [self updatTagButtonFrame];
        [self updateTextFieldFrame];
    }];
    
}

-(void)done
{
    // 传递数据
//    NSMutableArray* tags = [NSMutableArray array];
//    for (YHPTagButton* tagButton in self.tagButtons) {
//        [tags addObject:tagButton.currentTitle];
//    }
    NSArray* tags = [self.tagButtons valueForKeyPath:@"currentTitle"];
    !self.tagsBlock ? : self.tagsBlock(tags);
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - frame 布局
/**
 布局控制器view的子控件
 */
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.contentView.x = YHPTopicCellMargin;
    self.contentView.width = self.view.width - 2 * YHPTagMargin;
    self.contentView.y = 64 + YHPTagMargin;
    self.contentView.height = YHPScreenH;
    // 1
    self.textField.width = self.contentView.width;
    // 2
    self.addButton.width = self.contentView.width;
    self.addButton.height = 35;
    
    [self setUpTags];
}

/**
  更新标签按钮的frame
 */
-(void)updatTagButtonFrame
{
    for (int i = 0; i < self.tagButtons.count; i++) {
        YHPTagButton* tagButton = self.tagButtons[i];
        if (i == 0) {
            tagButton.x = tagButton.y = 0;
        }else{
            YHPTagButton* lastTagButton = self.tagButtons[i -1];
            CGFloat leftWidth =  CGRectGetMaxX(lastTagButton.frame) +YHPTagMargin;
            CGFloat rightWidth = self.contentView.width - leftWidth;
            if (rightWidth >= tagButton.width) {
                tagButton.y = lastTagButton.y;
                tagButton.x = leftWidth;
            }else{
                tagButton.x = 0;
                tagButton.y = CGRectGetMaxY(lastTagButton.frame);
            }
        }
    }
    // 更新添加标签frame
    self.addButton.y = CGRectGetMaxY(self.textField.frame) + YHPTagMargin;
    
}

-(void)updateTextFieldFrame
{
    // 最后一个标签按钮
    YHPTagButton* lastTagButton = [self.tagButtons lastObject];
    CGFloat leftWidth =  CGRectGetMaxX(lastTagButton.frame) +YHPTagMargin;
    // 更新textfield的fram;
    if (self.contentView.width - leftWidth >= [self textFeildTextWidth]) {
        self.textField.y = lastTagButton.y;
        self.textField.x = leftWidth;
    }else{
        self.textField.x = 0;
        self.textField.y = CGRectGetMaxY([[self.tagButtons lastObject] frame]) + YHPTagMargin;
    }
}
/**
 textFeild的文字宽度
 @return 文字宽度
 */
-(CGFloat)textFeildTextWidth
{
    // 计算单行文字宽度
    CGFloat textW =  [self.textField.text sizeWithAttributes:@{NSFontAttributeName: self.textField.font}].width;
    return MAX(100, textW);
}

#pragma mark - <YHPTagTextFieldDelegate>
/**
 监听键盘Return键点击
 @param textField 文本
 @return BOOL
 */
-(BOOL)textFieldShouldReturn:(YHPTagTextField *)textField
{
    if ([textField hasText]) {
        [self addButtonClick];
    }
    return YES;
}



@end

