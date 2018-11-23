//
//  YHPRecommendTagsViewController.m
//  02-百思不得其解
//
//  Created by yhp on 16/9/13.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPRecommendTagsViewController.h"
#import "YHPRecommendTag.h"
#import <AFNetWorking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import "YHPRecommendTagCell.h"

@interface YHPRecommendTagsViewController ()
/** 标签数据 */
@property(nonatomic,strong)NSArray* tags;
@end

static NSString* const YHPTagsId = @"tag";

@implementation YHPRecommendTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTableView];

    [self loadTags];
}

- (void)loadTags
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    // 发送服务器
    NSString* urlString = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary* parames = [NSMutableDictionary dictionary];
    parames[@"a"] = @"tag_recommend";
    parames[@"action"] = @"sub";
    parames[@"c"] = @"topic";
    [[AFHTTPSessionManager manager]GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.tags = [YHPRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败"];
        
    }];
}

- (void)setUpTableView
{
    self.title = @"推荐标签";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YHPRecommendTag class]) bundle:nil] forCellReuseIdentifier:YHPTagsId];
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = YHPGlobalBg;
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YHPRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:YHPTagsId forIndexPath:indexPath];
    
    cell.recommendTag = self.tags[indexPath.row];
    
    
    return cell;
}



@end
