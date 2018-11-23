//
//  YHPGroupBuyViewController.m
//  01-彩票
//
//  Created by yhp on 16/6/1.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPGroupBuyViewController.h"
#import "YHPTittleView.h"

@interface YHPGroupBuyViewController ()
@property(nonatomic,weak)UIButton* tittleView;
@end

@implementation YHPGroupBuyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //  titleVie
    UIButton* tittleView = [YHPTittleView buttonWithType:UIButtonTypeCustom];
       _tittleView = tittleView;
    [tittleView setTitle:@"全部彩种" forState:UIControlStateNormal];
    [tittleView setImage:[UIImage imageNamed:@"YellowDownArrow"] forState:UIControlStateNormal];
    [tittleView sizeToFit];
    
    self.navigationItem.titleView = tittleView;
    
    //  添加右边按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"助手" style:UIBarButtonItemStylePlain target:self action:@selector(help)];
}

-(void)help
{
    [_tittleView setTitle:@"福利彩票" forState:UIControlStateNormal];
    
}

@end