//
//  YHPCommentViewController.m
//  02-百思不得其解
//
//  Created by yhp on 2016/12/7.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPCommentViewController.h"
#import "YHPTopicCell.h"
#import "YHPTopic.h"
#import "YHPComment.h"
#import "YHPCommentHeaderView.h"
#import <MJRefresh.h>
#import <AFNetworking.h>
#import <MJExtension.h>
#import "YHPCommentCell.h"

static NSString* const YHPCommnetId = @"comment";

@interface YHPCommentViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttomSpace;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/** 最热评论 */
@property(nonatomic,strong)NSArray* hotComments;
/** 最新评论 */
@property(nonatomic,strong)NSMutableArray* latestComments;
/** 保存帖子top_cmt */
@property(nonatomic,strong)YHPComment* saved_top_cmt;
/** 保存当前页数 */
@property(nonatomic,assign)NSInteger page;
/** Manager */
@property(nonatomic,strong)AFHTTPSessionManager* manager;
@end

@implementation YHPCommentViewController

-(AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpBasic];
    [self setUpHeader];
    [self setUpRefresh];
}
-(void)setUpHeader
{
    // 设置header
    UIView* header = [[UIView alloc]init];
    
    // 清空top_cmt
    if (self.topic.top_cmt) {
        self.saved_top_cmt = self.topic.top_cmt;
        self.topic.top_cmt = nil;
        [self.topic setValue:@0 forKey:@"cellHeight"];
    }
    YHPTopicCell* cell = [YHPTopicCell cell];
    cell.topic  = self.topic;
    cell.size = CGSizeMake(YHPScreenW, self.topic.cellHeight);
    
    [header addSubview:cell];
    // header 的高度
    header.height = cell.height + YHPTopicCellMargin;
    
    self.tableView.tableHeaderView = header;
}

-(void)setUpBasic
{
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" target:self action:nil];
    
    // 监听键盘弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
   
    // cell的高度设置
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // 设置背景色
    self.tableView.backgroundColor = YHPGlobalBg;
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YHPCommentCell class]) bundle:nil] forCellReuseIdentifier:YHPCommnetId];
    // 去掉分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 内边距
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, YHPTopicCellMargin, 0);
}

-(void)setUpRefresh
{
    // 设置上拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.mj_header beginRefreshing];
    // 设置下拉刷新
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    self.tableView.mj_footer.hidden = YES;
}

/**
 上拉刷新
 */
-(void)loadNewComments
{
    // 结束之前的所有任务
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @"1";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
             [self.tableView.mj_header endRefreshing];
            return;// 没有评论数据
        }
        // 最热评论
        self.hotComments = [YHPComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        // 最新评论
        self.latestComments =  [YHPComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        // 页码
        self.page = 1;
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        // 控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count >= total) {// 全部加载完毕
           self.tableView.mj_footer.hidden = YES;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
}


/**
 下拉刷新
 */
-(void)loadMoreComments
{
    // 结束之前的所有任务
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    // 页码
    NSInteger page = self.page + 1;
    YHPComment* cmt = [self.latestComments lastObject];
    // 参数
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"page"] = @(page);
    params[@"lastcid"] = cmt.ID;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            self.tableView.mj_footer.hidden = YES;
            return;// 没有评论数据
        }
        // 最新评论
        NSArray* newComments =  [YHPComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.latestComments addObjectsFromArray:newComments];
        self.page = page;
        // 刷新
        [self.tableView reloadData];
        // 控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count >= total) {// 全部加载完毕
            self.tableView.mj_footer.hidden = YES;
        }else{
            // 结束刷新状态
            [self.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
    }];
}
/**
 监听键盘frame 变化
 @param note
 */
-(void)keyboardWillChangeFrame: (NSNotification*)note
{
    // 键盘显示隐藏完毕的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 修改底部约束
    self.buttomSpace.constant = YHPScreenH - frame.origin.y;
    // 动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationCurveUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        // 强制布局
        [self.view layoutIfNeeded];
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    // 恢复帖子的top_cmt
    if (self.saved_top_cmt) {
        self.topic.top_cmt = self.saved_top_cmt;
        [self.topic setValue:@0 forKey:@"cellHeight"];
    }
    
    // 结束之前的所有任务
//    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [self.manager invalidateSessionCancelingTasks:YES];// sension 都不起作用
    
}


/**
 返回第section组的评论数据
 @param section 组号
 @return latestCount
 */
-(NSArray*)commetsInSection:(NSInteger)section
{
    NSInteger hotCount = self.hotComments.count;
    if (section == 0) {
        return hotCount ? self.hotComments : self.latestComments;
    }
    return self.latestComments;
}

-(YHPComment*)commentInIndexPath:(NSIndexPath*)indexPath
{
    return [self commetsInSection:indexPath.section][indexPath.row];
}

#pragma mark - <UITableViewDataSource>
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    if (hotCount) {
        return 2;
    }else if (latestCount){
        return 1;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    // 影藏底部footer
    tableView.mj_footer.hidden = (latestCount == 0);
    if (section == 0) {
      return hotCount ? hotCount : latestCount;
    }
    return latestCount;
}

//-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    NSInteger hotCount = self.hotComments.count;
//    if (section == 0) {
//        return hotCount ? @"最热评论" : @"最新评论";
//    }
//    return @"最新评论";
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    YHPCommentHeaderView* header = [YHPCommentHeaderView headerViewWithTableView:tableView];
    // 设置label的属性
    NSInteger hotCount = self.hotComments.count;
    if (section == 0) {
        header.title = hotCount ? @"最热评论" : @"最新评论";
    }else{
        header.title =  @"最新评论";
    }
    
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YHPCommentCell* cell = [tableView dequeueReusableCellWithIdentifier:YHPCommnetId];
    cell.comment = [self commentInIndexPath:indexPath];
    return cell;
}

#pragma mark - <UITableViewDelegate>
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    [[UIMenuController sharedMenuController]setMenuVisible:NO animated:YES];
}

/**
 监听 cell 点击
 @param tableView
 @param indexPath
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 显示UIMenuController
    UIMenuController* memu = [UIMenuController sharedMenuController];
    if (memu.isMenuVisible) {
        [memu setMenuVisible:NO animated:YES];
    }else{
        // 被点击的cell
        YHPCommentCell* cell = (YHPCommentCell*)[tableView cellForRowAtIndexPath:indexPath];
        // 出现第一响应者
        [cell becomeFirstResponder];
        [memu setTargetRect:cell.bounds inView:cell];
        [memu setMenuVisible:YES animated:YES];
        UIMenuItem* ding = [[UIMenuItem alloc]initWithTitle:@"顶" action:@selector(ding:)];
        UIMenuItem* replay = [[UIMenuItem alloc]initWithTitle:@"恢复" action:@selector(ding:)];
        UIMenuItem* report = [[UIMenuItem alloc]initWithTitle:@"举报" action:@selector(ding:)];
        memu.menuItems = @[ding,replay,report];
        
        CGRect rect = CGRectMake(0, cell.height * 0.5, cell.width, cell.height * 0.5);
        [memu setTargetRect:rect inView:cell];
        [memu setMenuVisible:YES animated:YES];
    }
}

#pragma mark - UIMenuController
/**
 ding
 @param menu 菜单控制器
 */
-(void)ding:(UIMenuController*)menu
{
    NSIndexPath* indexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"%s,%zd,%@",__func__,indexPath.row,[self commentInIndexPath:indexPath].content);
}

/**
 replay
 @param menu 菜单控制器
 */
-(void)replay:(UIMenuController*)menu
{
    NSIndexPath* indexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"%s,%zd,%@",__func__,indexPath.row,[self commentInIndexPath:indexPath].content);
}

/**
 report
 @param menu 菜单控制器
 */
-(void)report:(UIMenuController*)menu
{
    NSIndexPath* indexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"%s,%zd,%@",__func__,indexPath.row,[self commentInIndexPath:indexPath].content);
}



@end
