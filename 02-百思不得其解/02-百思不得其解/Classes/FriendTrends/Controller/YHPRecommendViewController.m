//
//  YHPRecommendViewController.m
//  02-百思不得其解
//
//  Created by yhp on 16/9/7.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPRecommendViewController.h"
/* cell类型**/
#import "YHPRecommendCategoryViewCell.h"
#import "YHPRecommendUserCell.h"
/* 第三方库文件**/
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import <MJRefresh.h>
/* 模型**/
#import "YHPRecommendCategory.h"
#import "YHPRecommendUser.h"


#define YHPSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]
@interface YHPRecommendViewController ()<UITableViewDataSource,UITableViewDelegate>
/** 左边类别表格 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/** 右边的tableView*/
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
/** 左边类别数据 */
@property(nonatomic,strong)NSArray* categories;
/** 请求参数 */
@property(nonatomic,strong)NSMutableDictionary* params;
/** AFN请求管理者 */
@property(nonatomic,strong)AFHTTPSessionManager* manager;
@end

@implementation YHPRecommendViewController

static NSString* const YHPCategoryId = @"category";
static NSString* const YHPUserId = @"user";

-(AFHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

-(void)setUpTableView
{
    // 注册left cell
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([YHPRecommendCategoryViewCell class]) bundle:nil] forCellReuseIdentifier:YHPCategoryId];
    // 注册right cell
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([YHPRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:YHPUserId];
    //  设置Inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.rowHeight = 70;
    // 设置标题
    self.title = @"推荐关注";
    self.view.backgroundColor = YHPGlobalBg;
    
}
/**
 *  添加刷新控件
 */
-(void)setUpRefresh
{
    /**
     *  MJRefreshBackNormalFooter 回弹
     *  MJRefreshAutoFooter       自动
     */
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
}

-(void)setUpCategories
{
    // 显示指示器
    [SVProgressHUD showWithStatus:@"加载中"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    // 向服务器请求数据
    NSString* urlString = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary* parames = [NSMutableDictionary dictionary];
    parames[@"a"] = @"category";
    parames[@"c"] = @"subscribe";
    [self.manager GET:urlString parameters:parames progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 隐藏显示器
        [SVProgressHUD dismiss];
        //  解析JSON数据
        self.categories = [YHPRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 刷新表格
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.categoryTableView reloadData];
            // 默认选择首行
            [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
            // 让用户表格进入下拉刷新状态
            [self.userTableView.mj_header beginRefreshing];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 隐藏显示器
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败"];
    }];
}

#pragma mark - 加载新数据
-(void)loadNewUsers
{
    YHPRecommendCategory* c = YHPSelectedCategory;
    //   设置当前页码为1
    c.currentPage = 1;
    
    // 请求数据
    NSString* urlString = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary* parames = [NSMutableDictionary dictionary];
    parames[@"a"] = @"list";
    parames[@"c"] = @"subscribe";
    parames[@"category_id"] = @(c.ID);
    parames[@"page"] = @(c.currentPage);
    self.params = parames;
    // 发请求给服务器
    [self.manager GET:urlString parameters:parames progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray* users = [YHPRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 清除旧数据
        [c.users removeAllObjects];
        [c.users addObjectsFromArray:users];
        // 保存总数
        c.total = [responseObject[@"total"] integerValue];
        if (self.params != parames) return;
        // 刷新表格
        [self.userTableView reloadData];
        // 结束下拉刷新
        [self.userTableView.mj_header endRefreshing];
        [self checkFooterStatus];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != parames) return;
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        [self.userTableView.mj_header endRefreshing];
    }];
}

#pragma mark - 加载用户数据
-(void)loadMoreUsers
{
    YHPRecommendCategory* category = YHPSelectedCategory;
    // 发请求给服务器
    NSString* urlString = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary* parames = [NSMutableDictionary dictionary];
    parames[@"a"] = @"list";
    parames[@"c"] = @"subscribe";
    parames[@"category_id"] = @(category.ID);
    parames[@"page"] = @(++category.currentPage);
    self.params = parames;
    
    [self.manager GET:urlString parameters:parames progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray* users = [YHPRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [category.users addObjectsFromArray:users];
        if (self.params != parames) return;
        // 刷新表格
        [self.userTableView reloadData];
        [self checkFooterStatus];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != parames) return;
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        [self.userTableView.mj_footer endRefreshing];
    }];
}
#pragma mark - 更新footer状态
-(void)checkFooterStatus
{
    YHPRecommendCategory* rc = YHPSelectedCategory;
    // 每次刷新右边数据时, 都控制footer显示或者隐藏
    self.userTableView.mj_footer.hidden = (rc.users.count == 0);
    
    if (rc.users.count == rc.total) {// 加载完毕
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    }else{
        // 让底部控件结束刷新
        [self.userTableView.mj_footer endRefreshing];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpTableView];
    [self setUpRefresh];
    [self setUpCategories];
}

#pragma mark - <UITableViewDataSource>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView) return self.categories.count;
    [self checkFooterStatus];
    return [YHPSelectedCategory users].count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {// left view
        YHPRecommendCategoryViewCell* cell = [tableView dequeueReusableCellWithIdentifier:YHPCategoryId];
        cell.category= self.categories[indexPath.row];
        return cell;
    }else{// right view
        YHPRecommendCategory* rc = YHPSelectedCategory;
        YHPRecommendUserCell* cell = [tableView dequeueReusableCellWithIdentifier:YHPUserId];
        cell.user = [YHPSelectedCategory users][indexPath.row];
        if (rc.users.count == rc.total) {// 加载完毕
            [self.userTableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            // 让底部控件结束刷新
            [self.userTableView.mj_footer endRefreshing];
        }
        return cell;
    }

}

#pragma mark -<UITableViewDelegate>
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //  结束刷新
    [self.userTableView.mj_header endRefreshing];
    [self.userTableView.mj_footer endRefreshing];
    
    YHPRecommendCategory* c = self.categories[indexPath.row];
    if (c.users.count){// 有数据
        // 刷新表格
       [self.userTableView reloadData];
    }else{
        // 刷新表格 目的是马上显示当前模型数据，不让用户看见上一个残留数据
        [self.userTableView reloadData];
        // 下拉刷新-发送请求给服务器
        [self.userTableView.mj_header beginRefreshing];
    }
}

#pragma mark - 控制器销毁
-(void)dealloc
{
    // 停止请求操作
    [self.manager.operationQueue cancelAllOperations];
}

@end
