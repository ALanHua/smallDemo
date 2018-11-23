//
//  YHPPostWordViewController.m
//  02-百思不得其解
//
//  Created by yhp on 2017/2/19.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "YHPPostWordViewController.h"
#import "YHPPlaceholderTextView.h"
#import "YHPAddTagToolbar.h"

@interface YHPPostWordViewController () <UITextViewDelegate>
/** 文本输入控件 */
@property(nonatomic,strong)YHPPlaceholderTextView* textView;
/** 工具条 */
@property(nonatomic,weak)YHPAddTagToolbar* toolbar;
@end

@implementation YHPPostWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNav];
    [self setUpTestView];
    [self setUpToolbar];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 先退出之前的键盘
    [self.view endEditing:YES];
    // 弹出键盘
    [self.textView becomeFirstResponder];
}

/**
 监听键盘弹出和影藏
 @param note 通知
 */
-(void)keyboardWillChangeFrame:(NSNotification*)note
{
    // 键盘最终的frame
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 添加动画
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, keyboardF.origin.y - YHPScreenH);
    }];

}

-(void)setUpToolbar
{
    YHPAddTagToolbar* toolbar = [YHPAddTagToolbar viewFromXib];
    toolbar.width = self.view.width;
    toolbar.y = self.view.height - toolbar.height;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
    [YHPNoteCenter addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void)setUpTestView
{
    YHPPlaceholderTextView* textView = [[YHPPlaceholderTextView alloc]init];
    textView.frame = self.view.bounds;
    textView.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    textView.delegate = self;
    //textView.inputAccessoryView = [YHPAddTagToolbar viewFromXib];
    [self.view addSubview:textView];
    self.textView = textView;
}

-(void)setUpNav
{
    self.title = @"发表文字";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    self.navigationItem.rightBarButtonItem.enabled = NO; // 默认不能点
    // 强制刷新
    [self.navigationController.navigationBar layoutIfNeeded];
}

-(void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)post
{
    
}
#pragma mark - <UITextViewDelegate>
-(void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

@end
