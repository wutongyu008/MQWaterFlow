//
//  MQWaterFlowController.m
//  MQWaterFlowLayout
//
//  Created by qiuming on 16/1/12.
//  Copyright © 2016年 qiuming. All rights reserved.
//

#import "MQWaterFlowController.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "MQWaterModel.h"
#import "MQWaterFlowCell.h"
#import "MQWaterFlowLayout.h"

/// 重用标识符
//NSString *const WaterFlowLayoutReusedID = @"WaterFlowLayoutReusedID";

@interface MQWaterFlowController ()<UICollectionViewDataSource, MQWaterFlowLayoutDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;
/// 模型数组
@property (strong, nonatomic) NSMutableArray *waterModel;

@end

@implementation MQWaterFlowController
#pragma mark - 懒加载
- (NSMutableArray *)waterModel
{
    if (_waterModel == nil) {
        _waterModel = [NSMutableArray array];
    }
    return _waterModel;
}

#pragma mark -
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置collectionView
    MQWaterFlowLayout *layout = [[MQWaterFlowLayout alloc]init];
    layout.delegate = self;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.collectionView registerNib:[UINib nibWithNibName:@"MQWaterFlowCell" bundle:nil] forCellWithReuseIdentifier:WaterFlowLayoutReusedID];

    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    
    [self.view addSubview:self.collectionView];
    
    self.waterModel = [MQWaterModel mj_objectArrayWithFilename:@"2.plist"];
    
    // 添加下拉、上拉刷新
    [self addRefreshing];
    
}

/// 添加下拉、上拉刷新
- (void)addRefreshing
{
    // 下拉刷新
    __weak typeof(self) weakSelf = self;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        NSString *fileName = [NSString stringWithFormat:@"%d.plist", arc4random_uniform(3)];
        NSArray *array = [MQWaterModel mj_objectArrayWithFilename:fileName];
        [weakSelf.waterModel insertObjects:array atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, array.count)]];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [weakSelf.collectionView reloadData];
            // 线束刷新
            [weakSelf.collectionView.mj_header endRefreshing];
        });
    }];
    [self.collectionView.mj_header beginRefreshing];
    
    // 上拉刷新
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        NSString *fileName = [NSString stringWithFormat:@"%d.plist", arc4random_uniform(3)];
        NSArray *array = [MQWaterModel mj_objectArrayWithFilename:fileName];
        [weakSelf.waterModel addObjectsFromArray:array];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [weakSelf.collectionView reloadData];
            [weakSelf.collectionView.mj_footer endRefreshing];
        });
    }];
    self.collectionView.mj_footer.automaticallyChangeAlpha = 0.7;
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.waterModel.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MQWaterFlowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WaterFlowLayoutReusedID forIndexPath:indexPath];
    
    cell.waterModel = self.waterModel[indexPath.item];
    
    return cell;
}

#pragma mark - MQWaterFlowLayoutDelegate
- (CGFloat)waterFlowLayout:(MQWaterFlowLayout *)flowLayout HeightForItemAtIndexPath:(NSIndexPath *)indexPath withItemWidth:(CGFloat)width
{
    MQWaterModel *model = self.waterModel[indexPath.item];
    return model.h * width / model.w;
}

- (CGFloat)rowMarginInWaterFlowLayout:(MQWaterFlowLayout *)flowLayout
{
    return 5;
}

- (CGFloat)columnMarginInWaterFlowLayout:(MQWaterFlowLayout *)flowLayout
{
    return 5;
}

- (NSInteger)columnCountInWaterFlowLayout:(MQWaterFlowLayout *)flowLayout
{
    return 3;
}

- (UIEdgeInsets)edgeInsetsInWaterFlowLayout:(MQWaterFlowLayout *)flowLayout
{
    return UIEdgeInsetsMake(20, 10, 40, 10);
}
@end



