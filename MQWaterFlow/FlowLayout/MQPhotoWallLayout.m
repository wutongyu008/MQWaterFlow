//
//  MQPhotoWallLayout.m
//  MQWaterFlowLayout
//
//  Created by qiuming on 16/1/15.
//  Copyright © 2016年 qiuming. All rights reserved.
//

#import "MQPhotoWallLayout.h"
#define MQCollectionW self.collectionView.frame.size.width

/// 默认行间距
static const CGFloat MQDefaultRowMargin = 5;
/// 默认列间距
static const CGFloat MQDefaultColumnMargin = 5;
/// 默认内边距
static const UIEdgeInsets MQDefaultInset = {5, 5, 5, 5};

@interface MQPhotoWallLayout()
/// 存放所有item属性数组
@property (strong, nonatomic) NSMutableArray *attrsArray;

// 方便使用点语法
- (CGFloat)rowMargin;
- (CGFloat)columnMargin;
- (UIEdgeInsets)edgeInsets;

@end

@implementation MQPhotoWallLayout
#pragma mark - 懒加载
- (NSMutableArray *)attrsArray {
    if (_attrsArray == nil) {
        _attrsArray = [[NSMutableArray alloc]init];
    }
    return _attrsArray;
}

#pragma mark -
/// 准备布局
- (void)prepareLayout
{
    [super prepareLayout];
    
    [self.attrsArray removeAllObjects];
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < count; i++) {
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
    CGFloat contentWidth = MQCollectionW - self.edgeInsets.left - self.edgeInsets.right;
    UICollectionViewLayoutAttributes *attri = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    // cell的宽度
    CGFloat photoW = (contentWidth - self.columnMargin * 2) / 3;
    CGFloat itemW = 0;
    CGFloat itemH = 0;
    CGFloat itemX = 0;
    CGFloat itemY = 0;
    
    if (indexPath.item == 0) {
        itemW = photoW;
        itemH = itemW;
        itemX = self.edgeInsets.left;
        itemY = self.edgeInsets.top;
        
    } else if (indexPath.item == 1) {
        itemW = contentWidth - photoW - self.columnMargin;
        itemH = photoW;
        itemX = self.edgeInsets.left + photoW +self.columnMargin;
        itemY = self.edgeInsets.top;
        
    } else if (indexPath.item == 2) {
        itemW = contentWidth - photoW - self.columnMargin;
        itemH = contentWidth;
        itemX = self.edgeInsets.left;
        itemY = self.edgeInsets.top + photoW + self.rowMargin;
        
    } else if (indexPath.item == 3) {
        itemW = photoW;
        itemH = itemW;
        itemX = MQCollectionW - self.edgeInsets.right - photoW;
        itemY = self.edgeInsets.top + photoW + self.rowMargin;
    } else if (indexPath.item == 4) {
        itemW = photoW;
        itemH = itemW;
        itemX = MQCollectionW - self.edgeInsets.right - photoW;
        itemY = self.edgeInsets.top + (photoW + self.rowMargin) * 2;
        
    } else if (indexPath.item == 5) {
        itemW = photoW;
        itemH = itemW;
        itemX = MQCollectionW - self.edgeInsets.right - photoW;
        itemY = self.edgeInsets.top + (photoW + self.rowMargin) * 3;
        
    } else if (indexPath.item == 6) {
        itemW = photoW;
        itemH = itemW;
        itemX = self.edgeInsets.left;
        itemY = self.edgeInsets.top + (photoW + self.rowMargin) * 4;
        
    } else if (indexPath.item == 7) {
        itemW = photoW;
        itemH = itemW;
        itemX = self.edgeInsets.left + (photoW + self.rowMargin);
        itemY = self.edgeInsets.top + (photoW + self.rowMargin) * 4;
 
    } else if (indexPath.item == 8) {
        itemW = photoW;
        itemH = itemW;
        itemX = self.edgeInsets.left + (photoW + self.rowMargin) * 2;
        itemY = self.edgeInsets.top + (photoW + self.rowMargin) * 4;

    } else {
        
        UICollectionViewLayoutAttributes *lastAttri = self.attrsArray[indexPath.item - 9];
        CGRect lastFrame = lastAttri.frame;
        
        itemW = lastFrame.size.width;
        itemH =  lastFrame.size.height;
        itemX =  lastFrame.origin.x;
        itemY =  lastFrame.origin.y + 5 * (photoW + self.rowMargin);
        
    }
    
    attri.frame = CGRectMake(itemX, itemY, itemW, itemH);
    [self.attrsArray addObject:attri];
    
    return attri;
    
}

// 设置滚动区域的contentSize
- (CGSize)collectionViewContentSize
{
    // 滚动区域范围由最后一个cell决定
    UICollectionViewLayoutAttributes *attri = (UICollectionViewLayoutAttributes *)self.attrsArray.lastObject;
    
    return CGSizeMake(MQCollectionW, CGRectGetMaxY(attri.frame));
}



#pragma mark - 处理代理返回的数据
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
