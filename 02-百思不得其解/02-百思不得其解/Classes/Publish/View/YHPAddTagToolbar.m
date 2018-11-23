//
//  YHPAddTagToolbar.m
//  02-百思不得其解
//
//  Created by yhp on 2017/2/28.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "YHPAddTagToolbar.h"
#import "YHPAddTagViewController.h"

@interface YHPAddTagToolbar ()
@property (weak, nonatomic) IBOutlet UIView *topView;
/** label 数组 */
@property(nonatomic,strong)NSMutableArray* tagLabels;
/** 添加 按钮 */
@property(nonatomic,weak)UIButton* addButton;
@end

@implementation YHPAddTagToolbar

#pragma mark - 懒加载
-(NSMutableArray*)tagLabels
{
    if (!_tagLabels) {
        _tagLabels = [NSMutableArray array];
    }
    return _tagLabels;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    // 添加一个加号
    UIButton* addButton = [[UIButton alloc]init];
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    addButton.size = addButton.currentImage.size;
    addButton.x = YHPTagMargin;
    [self.topView addSubview:addButton];
    self.addButton = addButton;
    // 默认由2个标签
    [self createTags:@[@"吐槽",@"糗事"]];
}

-(void)addButtonClick
{
    YHPAddTagViewController* vc = [[YHPAddTagViewController alloc]init];
    __weak typeof(self) weakSelf = self;
    [vc setTagsBlock:^(NSArray* tags) {
        [weakSelf createTags:tags];
    }];
    vc.tags = [self.tagLabels valueForKey:@"text"];
    UIViewController* root = [UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController* nav = (UINavigationController*)root.presentedViewController;
    [nav pushViewController:vc animated:YES];
}

/**
 子控件布局
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    for (int i = 0; i < self.tagLabels.count; i++) {
        UILabel* tagLabel = self.tagLabels[i];
        // 设置位置
        if (i == 0) { // 最前面的标签
            tagLabel.x = 0;
            tagLabel.y = 0;
        } else { // 其他标签
            UILabel *lastTagLabel = self.tagLabels[i - 1];
            // 计算当前行左边的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + YHPTagMargin;
            // 计算当前行右边的宽度
            CGFloat rightWidth = self.topView.width - leftWidth;
            if (rightWidth >= tagLabel.width) { // 按钮显示在当前行
                tagLabel.y = lastTagLabel.y;
                tagLabel.x = leftWidth;
            } else { // 按钮显示在下一行
                tagLabel.x = 0;
                tagLabel.y = CGRectGetMaxY(lastTagLabel.frame) + YHPTagMargin;
            }
        }
    }
    // 最后一个标签按钮
    UILabel* lastTagLabel = [self.tagLabels lastObject];
    CGFloat leftWidth =  CGRectGetMaxX(lastTagLabel.frame) +YHPTagMargin;
    // 更新textfield的fram;
    if (self.topView.width - leftWidth >= self.addButton.width) {
        self.addButton.y = lastTagLabel.y;
        self.addButton.x = leftWidth;
    }else{
        self.addButton.x = 0;
        self.addButton.y = CGRectGetMaxY(lastTagLabel.frame) + YHPTagMargin;
    }
    // 整体高度
    CGFloat oldH = self.height;
    self.height = CGRectGetMaxY(self.addButton.frame) + 45;
    self.y -= self.height - oldH;
}

/**
 创建标签
 @param tags 标签参数
 */
-(void)createTags:(NSArray*)tags
{
    [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagLabels removeAllObjects];
    
    for (int i = 0; i < tags.count; i++) {
        UILabel* tagLabel = [[UILabel alloc]init];
        [self.tagLabels addObject:tagLabel];
        tagLabel.backgroundColor = YHPTagBg;
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.text = tags[i];
        tagLabel.font = YHPTagFont;
        [tagLabel sizeToFit];
        tagLabel.width += 2 * YHPTagMargin;
        tagLabel.height = YHPTagH;
        tagLabel.textColor = [UIColor whiteColor];
        [self.topView addSubview:tagLabel];
    }
    // 重新布局子控件
    [self setNeedsLayout];
}


@end
