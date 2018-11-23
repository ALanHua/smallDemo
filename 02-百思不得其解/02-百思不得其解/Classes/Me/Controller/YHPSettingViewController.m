//
//  YHPSettingViewController.m
//  02-百思不得其解
//
//  Created by yhp on 2017/3/20.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "YHPSettingViewController.h"
#import <SDImageCache.h>

@interface YHPSettingViewController ()

@end

@implementation YHPSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.tableView.backgroundColor = YHPGlobalBg;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getSize2
{
    NSFileManager* manager = [NSFileManager defaultManager];
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *cachePath = [caches stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
    // 获取文件夹内部所有内容
    //NSArray* contents = [manager contentsOfDirectoryAtPath:cachePath error:nil];
    NSArray* subpaths = [manager subpathsAtPath:cachePath];
    
    
    YHPLog(@"%zd",subpaths);
}

-(void)getSize
{
    NSFileManager* manager = [NSFileManager defaultManager];
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *cachePath = [caches stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
    NSDirectoryEnumerator *fileEnumerator = [manager enumeratorAtPath:cachePath];
    NSUInteger totalSize = 0;
    for (NSString *fileName in fileEnumerator) {
        NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
        NSDictionary *attrs = [manager attributesOfItemAtPath:filePath error:nil];
        if ([attrs[NSFileType] isEqualToString:NSFileTypeDirectory]) {
            continue;
        }
        totalSize += [attrs[NSFileSize] integerValue];
    }
    
    YHPLog(@"%zd",totalSize);
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
//    cell.textLabel.text = @"清除缓存";
    CGFloat size = [[SDImageCache sharedImageCache] getSize] / 1000.0 / 1000.0;
    cell.textLabel.text = [NSString stringWithFormat:@"清除缓存,已使用:%.1fMB",size];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[SDImageCache sharedImageCache] clearDisk];
}


@end
