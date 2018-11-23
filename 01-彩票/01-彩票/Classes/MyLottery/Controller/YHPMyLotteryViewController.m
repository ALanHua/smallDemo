//
//  YHPMyLotteryViewController.m
//  01-彩票
//
//  Created by yhp on 16/5/25.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPMyLotteryViewController.h"
#import "YHPSettingViewController.h"


@interface YHPMyLotteryViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation YHPMyLotteryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 获取按钮背景图片
    UIImage* image = _loginBtn.currentBackgroundImage;
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    [_loginBtn setBackgroundImage:image forState:UIControlStateNormal];
    
    [self setUpNav];
    
}

-(void)setUpNav
{
   //  设置左右两边按钮
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"客服" forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"FBMM_Barbutton"] forState:UIControlStateNormal];
    [btn sizeToFit];// 根据图片自适应
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
   // 左边
    self.navigationItem.leftBarButtonItem = leftItem;
   // 右边
//    UIImage* image = [UIImage imageNamed:@"Mylottery_config"];
//    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imgaeWithOriRenderingImage:@"Mylottery_config"] style:UIBarButtonItemStylePlain target:self action:@selector(setting)];
    
    self.navigationItem.rightBarButtonItem = rightItem;
}


-(void)setting
{
    // 跳转到设置界面
    YHPSettingViewController* vc = [[YHPSettingViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
