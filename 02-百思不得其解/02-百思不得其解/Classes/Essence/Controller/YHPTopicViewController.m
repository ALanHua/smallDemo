//
//  YHPTopicViewController.m
//  02-百思不得其解
//
//  Created by yhp on 2016/10/13.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//
#import "YHPTopicViewController.h"
#import "YHPCommentViewController.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "YHPTopic.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import "YHPTopicCell.h"
#import "YHPNewViewController.h"

@interface YHPTopicViewController ()
/** 段子数据 */
@property(nonatomic,strong)NSMutableArray* topics;
/** 当前页码 */
@property(nonatomic,assign)NSInteger page;
/** 加载夏夜数据需要用到 */
@property(nonatomic,copy)NSString* maxtime;
/** 上一次请求的参数 */
@property(nonatomic,strong)NSDictionary* parames;
/** 上次选中控制器的索引 */
@property(nonatomic,assign)NSInteger lastSelectIndex;
@end

@implementation YHPTopicViewController

static NSString* const YHPTopicCellId = @"topic";
- (NSMutableArray *)topics
{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化表格
    [self setupTableView];
    // 添加刷新控件
    [self setupRefresh];
}
#pragma mark - 初始化
-(void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    // 自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

-(void)setupTableView
{
    CGFloat botton = self.tabBarController.tabBar.height;
    CGFloat top = YHPTitilesViewY + YHPTitilesViewH;
    // 设置滚动条内边距
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, botton, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YHPTopicCell class]) bundle:nil] forCellReuseIdentifier:YHPTopicCellId];
    // 监听tabBar点击的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tabBarClick) name:YHPTabBarDidSelectedNotification object:nil];
}

#pragma mark - 监听tabBar点击通知
-(void)tabBarClick
{
    /*
     * 1,如果不是连续点击2次
     * 2,如果选中了不是当前的导航控制器
     */
    if ((self.lastSelectIndex == self.tabBarController.selectedIndex)
//        && (self.tabBarController.selectedViewController == self.navigationController)
        && [self.view isShowingOnKeyWindow]) {
        [self.tableView.mj_header beginRefreshing];
    }
    self.lastSelectIndex = self.tabBarController.selectedIndex;
}

#pragma mark - a参数
- (NSString*)a
{
    return [self.parentViewController isKindOfClass:[YHPNewViewController class]] ? @"newlist" : @"list";
}

#pragma mark - 数据处理
-(void)loadNewTopics
{
    // 结束上啦
    [self.tableView.mj_footer endRefreshing];
    // 向服务器请求数据
    NSString* urlString = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary* parames = [NSMutableDictionary dictionary];
    parames[@"a"] = self.a;
    parames[@"c"] = @"data";
    parames[@"type"] = @(self.type);
    self.parames = parames;
    [[AFHTTPSessionManager manager] GET:urlString parameters:parames progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.parames != parames) {
            return;
        }
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        self.topics = [YHPTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 刷新表格
        [self.tableView reloadData];
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        // 清空页码
        self.page = 0;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.parames != parames) {
            return;
        }
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        
    }];
}
/*
 加载更多的段子
 */
-(void)loadMoreTopics
{
    // 结束下拉
    [self.tableView.mj_header endRefreshing];
    self.page++;
    // 向服务器请求数据
    NSString* urlString = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary* parames = [NSMutableDictionary dictionary];
    parames[@"a"] = self.a;
    parames[@"c"] = @"data";
    parames[@"type"] = @(self.type);
    parames[@"page"] = @(self.page);
    parames[@"maxtime"] = self.maxtime;
    self.parames = parames;
    [[AFHTTPSessionManager manager] GET:urlString parameters:parames progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.parames != parames) {
            return;
        }
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        NSArray* newTopics = [YHPTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:newTopics];
        // 刷新表格
        [self.tableView reloadData];
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.parames != parames) {
            return;
        }
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
        // 恢复页码
        self.page--;
    }];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YHPTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:YHPTopicCellId];
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}

/**
 监听cell 点击
 @param tableView
 @param indexPath
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YHPCommentViewController* commentVc = [[YHPCommentViewController alloc]init];
    commentVc.topic = self.topics[indexPath.row];
    [self.navigationController pushViewController:commentVc animated:YES];
}

#pragma mark - 代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取出帖子模型
    YHPTopic* topic = self.topics[indexPath.row];
    return topic.cellHeight;
}
@end
