//
//  YHPLoginRegisterViewController.m
//  02-百思不得其解
//
//  Created by yhp on 16/9/20.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPLoginRegisterViewController.h"
#import "YHPTopWindow.h"

@interface YHPLoginRegisterViewController ()
// 登录框距离左边约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;

@end

@implementation YHPLoginRegisterViewController


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [YHPTopWindow hiden];
    /*
     * info.plist 添加View controller-based status bar appearance = NO
     */
//    [UIApplication sharedApplication].statusBarStyle =UIStatusBarStyleLightContent;
}
- (IBAction)back {
    [YHPTopWindow show];
//    [UIApplication sharedApplication].statusBarStyle =UIStatusBarStyleDefault;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginRegister:(UIButton *)sender {
    // 退出键盘
    [self.view endEditing:YES];
    
    if (self.loginViewLeftMargin.constant == 0) {
        self.loginViewLeftMargin.constant = -self.view.width;// 注册界面
        sender.selected = YES;
    }else{
        self.loginViewLeftMargin.constant = 0;// 登录几面
        [sender setTitle:@"注册账号" forState:UIControlStateNormal];
        sender.selected = NO;
    }

    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}
/**
 *  状态栏切换成为白色
 */
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

/*
-(void)setTextFieldPlaceholderColor1
{
 
    // NSAttributedString : 带有属性的文字（富文本技术)
    NSMutableDictionary* attrs =  [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableAttributedString* placeholder = [[NSMutableAttributedString alloc]initWithString:@"手机号" attributes:attrs];
    self.phoneField.attributedPlaceholder = placeholder;
}

-(void)setTextFieldPlaceholderColor2
{
    
        NSMutableAttributedString* placeholder = [[NSMutableAttributedString alloc]initWithString:@"手机号"];
        [placeholder setAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(0, 1)];
        [placeholder setAttributes:@{
                        NSForegroundColorAttributeName:[UIColor yellowColor],
                        NSFontAttributeName:[UIFont systemFontOfSize:18]
                        } range:NSMakeRange(1, 1)];
        [placeholder setAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(2, 1)];
        self.phoneField.attributedPlaceholder = placeholder;
}
*/

@end
