//
//  MQWaterFlowLayout.m
//  MQWaterFlowLayout
//
//  Created by qiuming on 16/1/11.
//  Copyright © 2016年 qiuming. All rights reserved.
//

#import "MQWaterFlowLayout.h"

#define MQCollectionW self.collectionView.frame.size.width

/// 默认列数
static const NSInteger MQDefaultColumnCount = 3;
/// 默认行间距
static const CGFloat MQDefaultRowMargin = 10;
/// 默认列间距
static const CGFloat MQDefaultColumnMargin = 10;
/// 默认内边距
static const UIEdgeInsets MQDefaultInset = {10, 10, 10, 10};


@interface MQWaterFlowLayout()
/// 存放所有item属性数组
@property (strong, nonatomic) NSMutableArray *attrsArray;
/// 存放每一列最大的Y值
@property (strong, nonatomic) NSMutableArray *columnMaxY;

// 方便使用点语法
- (NSInteger)columnCount;
- (CGFloat)rowMargin;
- (CGFloat)columnMargin;
- (UIEdgeInsets)edgeInsets;

@end


@implementation MQWaterFlowLayout
#pragma mark - 懒加载
- (NSMutableArray *)attrsArray {
    if (_attrsArray == nil) {
        _attrsArray = [[NSMutableArray alloc]init];
    }
    return _attrsArray;
}

- (NSMutableArray *)columnMaxY {
    if (_columnMaxY == nil) {
        _columnMaxY = [[NSMutableArray alloc]init];
    }
    return _columnMaxY;
}

/// 准备布局
- (void)prepareLayout
{
    [super prepareLayout];
    // 清空数组，为防止下拉刷新时，加载新数据旧数据不重排
    [self.columnMaxY removeAllObjects];
    
    for (NSInteger i = 0; i < self.columnCount; i++) {
        [self.columnMaxY addObject:@(self.edgeInsets.top)];
    }
    [self.attrsArray removeAllObjects];
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attri = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attri];
    }
}

/// 返回所有item布局属性数组 - 此方法调用次数频繁，可以将耗性能的代码放在prepareLayout
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrsArray;
}

/// 形容每个item布局属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 内容尺寸
    CGFloat contentWidth = MQCollectionW - self.edgeInsets.left - self.edgeInsets.right;
    // cell的宽度
    CGFloat itemW = (contentWidth - (self.columnCount - 1) * self.columnMargin) / self.columnCount;
    // cell的高度
    CGFloat itemH = [self.delegate waterFlowLayout:self HeightForItemAtIndexPath:indexPath withItemWidth:itemW];
    
    CGFloat maxY = [self.columnMaxY[0] floatValue];
    NSInteger column = 0;
    for (NSInteger i = 1; i < self.columnCount; i++) {
        if (maxY > [self.columnMaxY[i] floatValue]) {
            maxY = [self.columnMaxY[i] floatValue];
            column = i;
        }
    }
    // cell的x\y值 
    CGFloat itemX = self.edgeInsets.left + (itemW + self.columnMargin) * column;
    CGFloat itemY = maxY;
    if (maxY != self.edgeInsets.top) {
        itemY += self.rowMargin;
    }

    UICollectionViewLayoutAttributes *attri = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attri.frame = CGRectMake(itemX, itemY, itemW, itemH);
    
    // 更新Y值数组
    self.columnMaxY[column] = @(CGRectGetMaxY(attri.frame));
    
    return attri;
}

// 返回内容尺寸
- (CGSize)collectionViewContentSize
{
    CGFloat maxY = [self.columnMaxY[0] floatValue];

    for (NSInteger i = 1; i < self.columnCount; i++) {
        if (maxY < [self.columnMaxY[i] floatValue]) {
            maxY = [self.columnMaxY[i] floatValue];
        }
    }
    
    return CGSizeMake(0, maxY + self.edgeInsets.bottom);

}


#pragma mark - 处理代理返回的数据
- (NSInteger)columnCount
{
    if ([self.delegate respondsToSelector:@selector(columnCountInWaterFlowLayout:)])
    {
        
        return [self.delegate columnCountInWaterFlowLayout:self];
    }
    
    return MQDefaultColumnCount;
}

- (CGFloat)rowMargin
{
    if ([self.delegate respondsToSelector:@selector(rowMarginInWaterFlowLayout:)])
    {
        return [self.delegate rowMarginInWaterFlowLayout:self];
    }
    return MQDefaultRowMargin;
}

- (CGFloat)columnMargin
{
    if ([self.delegate respondsToSelector:@selector(columnMarginInWaterFlowLayout:)])
    {
        return [self.delegate columnMarginInWaterFlowLayout:self];
    }
    return MQDefaultColumnMargin;
}

- (UIEdgeInsets)edgeInsets
{
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInWaterFlowLayout:)])
    {
        return [self.delegate edgeInsetsInWaterFlowLayout:self];
    }
    return MQDefaultInset;
}

@end
