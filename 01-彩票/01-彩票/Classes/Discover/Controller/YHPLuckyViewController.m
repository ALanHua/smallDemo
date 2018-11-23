//
//  YHPLuckyViewController.m
//  01-彩票
//
//  Created by yhp on 16/6/2.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPLuckyViewController.h"

@interface YHPLuckyViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *lightView;

@end

@implementation YHPLuckyViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage* image = [UIImage imageNamed:@"lucky_entry_light0"];
    UIImage* image1 = [UIImage imageNamed:@"lucky_entry_light1"];
    
    _lightView.animationImages = @[image,image1];
    _lightView.animationDuration = 1;
    [_lightView startAnimating];
}


@end