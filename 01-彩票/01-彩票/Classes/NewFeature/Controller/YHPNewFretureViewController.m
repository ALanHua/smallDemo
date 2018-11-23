//
//  YHPNewFretureViewController.m
//  01-彩票
//
//  Created by yhp on 16/6/4.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPNewFretureViewController.h"
#import "YHPNewFreatureCell.h"


#define YHP_ADD_BUTTON_PAGE    4

@interface YHPNewFretureViewController ()

@property (nonatomic,assign)CGFloat lastOffsetX;

@property(nonatomic,weak)UIImageView* guideView;
@property(nonatomic,weak)UIImageView* guideLargeView;
@property(nonatomic,weak)UIImageView* guideSnallView;

@end
//  UICollectionViewController层次结构，控制器View上面UICollectionView
//  self.view != elf.collectionView
//  1，初始化的时候必须设置布局参数，通过使用系统提供的流水布局 UICollectionViewFlowLayout
//  2，cell必须通过注册
//  3，自定义cell
@implementation YHPNewFretureViewController

// 展示图片的控制器应该添加到collectionView上
static NSString * const reuseIdentifier = @"Cell";


-(instancetype)init
{
    //  流水布局对象,设置cell的尺寸和布局
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
    //  设置滚动方向
    layout.scrollDirection =  UICollectionViewScrollDirectionHorizontal;
    //  设置cell的尺寸
    layout.itemSize = YHPScreenBounds.size;
    //  设置cell之间间距
    layout.minimumInteritemSpacing = 0;
    //  设置行距
    layout.minimumLineSpacing = 0;
//    //  设置每一组的内间距
//    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    return [super initWithCollectionViewLayout:layout];
}



- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor redColor];// 无效代码
//    self.collectionView.backgroundColor = [UIColor greenColor];
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    // 注册 cell
    [self.collectionView registerClass:[YHPNewFreatureCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self setUpAllChildView];
}

#pragma mark - 添加子控件
- (void)setUpAllChildView
{
    // guide1
    UIImageView* guide = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"guide1"]];
    _guideView = guide;
    guide.centerX = self.view.centerX;
    [self.collectionView addSubview:guide];
    
    // guideLine
    UIImageView* guideLine = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"guideLine"]];
    guideLine.x -= 140;
    [self.collectionView addSubview:guideLine];
    
    // layoutText
    UIImageView* layoutText = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"guideLargeText1"]];
    _guideLargeView = layoutText;
    layoutText.centerX = self.view.centerX;
    layoutText.centerY = self.view.height * 0.7;
    [self.collectionView addSubview:layoutText];
    
    //  snallText
    UIImageView* snallText = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"guideSmallText1"]];
    _guideSnallView = snallText;
    snallText.centerX = self.view.centerX;
    snallText.centerY = self.view.height * 0.8;
    [self.collectionView addSubview:snallText];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 减速完成
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    获取当前x偏移量
    CGFloat curOffsetX = scrollView.contentOffset.x;
//    NSLog(@"%f,%f",_lastOffsetX,curOffsetX);
//    获取差值
    CGFloat delta = curOffsetX - _lastOffsetX;
    // 往左边滑动，图片有从右往左的动画
    _guideView.x += 2 * delta;
    _guideLargeView.x += 2 * delta;
    _guideSnallView.x += 2 * delta;
    [UIView animateWithDuration:0.25 animations:^{
        _guideView.x -= delta;
        _guideLargeView.x -= delta;
        _guideSnallView.x -= delta;
    }];
    // 修改显示内容
    int page = curOffsetX / self.view.width + 1;
    _guideView.image = [UIImage imageNamed:[NSString
        stringWithFormat:@"guide%d",page]];
    _guideLargeView.image = [UIImage imageNamed:[NSString stringWithFormat:@"guideLargeText%d",page]];
    _guideSnallView.image =  [UIImage imageNamed:[NSString stringWithFormat:@"guideSmallText%d",page]];
    // 往右边滑动，图片有从左往右的动画
    _lastOffsetX = curOffsetX;
//    NSLog(@"%d",page);
}

#pragma mark <UICollectionViewDataSource>
//collectionView 有多少个组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

#pragma mark - 返回第section组有多少个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 4;
}

#pragma mark - 返回每个cell长什么样
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YHPNewFreatureCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSString* imageName = [NSString stringWithFormat:@"guide%ldBackground",indexPath.item + 1];
    cell.image = [UIImage imageNamed:imageName];
//   添加按钮
    [cell setUpIndexPath:indexPath count:YHP_ADD_BUTTON_PAGE];
    
    return cell;
}



@end
