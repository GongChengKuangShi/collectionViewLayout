//
//  LayoutViewController-02.m
//  Layout
//
//  Created by xiangronghua on 2017/4/20.
//  Copyright © 2017年 xiangronghua. All rights reserved.
//

#import "LayoutViewController-02.h"
#import "JGShopCell.h"
#import "JGShop.h"
#import "JGWaterflowLayout.h"
#import "MJExtension.h"
#import "MJRefresh.h"

@interface LayoutViewController_02 () <UICollectionViewDataSource, JGWaterflowLayoutDelegate>

/** 所有的商品数据  */
@property (nonatomic, strong)NSMutableArray *shops;

/** collectionView */
@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation LayoutViewController_02

static NSString * const JGShopId = @"shop";

- (NSMutableArray *)shops {
    if (!_shops) {
        _shops = [NSMutableArray array];
    }
    return _shops;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupLayout];
    [self setupRefresh];
}

- (void)setupRefresh {
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewShops)];
    [self.collectionView.mj_header beginRefreshing];
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreShops)];
    self.collectionView.mj_footer.hidden = YES;
}

#pragma mark - 加载下拉数据
- (void)loadNewShops
{
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *shops = [JGShop mj_objectArrayWithFilename:@"2.plist"];
        [weakSelf.shops removeAllObjects];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData];
            [weakSelf.shops addObjectsFromArray:shops];
            [weakSelf.collectionView.mj_header endRefreshing];
            [weakSelf.collectionView reloadData];
        });
    });
}

#pragma mark - 加载上拉数据
- (void)loadMoreShops
{
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *shops = [JGShop mj_objectArrayWithFilename:@"2.plist"];
        [weakSelf.shops addObjectsFromArray:shops];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.collectionView.mj_footer endRefreshing];
            [weakSelf.collectionView reloadData];
        });
    });
}

- (void)setupLayout {
    
    //创建布局
    JGWaterflowLayout *layout = [[JGWaterflowLayout alloc] init];
    layout.delegate = self;
    
    //创建collectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    
    //注册
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([JGShopCell class]) bundle:nil] forCellWithReuseIdentifier:JGShopId];
    self.collectionView = collectionView;
}



#pragma mark - <UICollectionViewDataSource> -
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    self.collectionView.mj_footer.hidden = self.shops.count == 0;
    return self.shops.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JGShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:JGShopId forIndexPath:indexPath];
    cell.shop = self.shops[indexPath.item];
    return cell;
}

#pragma mark - <JGWaterflowLayoutDelegate> -
- (CGFloat)waterflowlayout:(JGWaterflowLayout *)waterlayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth {
    
    JGShop *shop = self.shops[index];
    return itemWidth * shop.h / shop.w;
    
}

- (CGFloat)rowMarginInWaterflowLayout:(JGWaterflowLayout *)waterflowLayout {
    return 20;
}

- (CGFloat)columnCountInWaterflowLayout:(JGWaterflowLayout *)waterflowLayout {
    return 3;
}

- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(JGWaterflowLayout *)waterflowLayout {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}





@end
