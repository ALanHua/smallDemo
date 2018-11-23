//
//  YHPShowPictureViewController.m
//  02-百思不得其解
//
//  Created by yhp on 2016/10/27.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPShowPictureViewController.h"
#import "YHPTopic.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import "YHPProgressView.h"

@interface YHPShowPictureViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) UIImageView* imageView;
@property (weak, nonatomic) IBOutlet YHPProgressView *progressView;
@end

@implementation YHPShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 屏幕尺寸
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    // 添加图片控件
    UIImageView* imageView = [[UIImageView alloc]init];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:    [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back)]];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    // 图片宽度
    CGFloat pictureW = screenW;
    CGFloat pictureH = pictureW * self.topic.height / self.topic.width;
    
    if (pictureH > screenH) {
        // 滚动查看
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
    }else{
        imageView.size = CGSizeMake(pictureW, pictureH);
        imageView.centerY = screenH * 0.5;
    }
    
    // 马上显示进度值
    [self.progressView setProgress:self.topic.pictureProgress animated:YES];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        [self.progressView setProgress:1.0 * receivedSize / expectedSize animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
}

-(IBAction)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)save {
    if (self.imageView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"图片未下载成功"];
        return;
    }
    // 将图片写入相册
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}

@end
