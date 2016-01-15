//
//  MQWaterFlowLayout.h
//  MQWaterFlowLayout
//
//  Created by qiuming on 16/1/11.
//  Copyright © 2016年 qiuming. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MQWaterFlowLayout;

@protocol MQWaterFlowLayoutDelegate <NSObject>

@required
/// 返回indexPath位置cell的高度
- (CGFloat)waterFlowLayout:(MQWaterFlowLayout *)flowLayout HeightForItemAtIndexPath:(NSIndexPath *)indexPath withItemWidth:(CGFloat)width;

@optional
/// 返回显示列数
- (NSInteger)columnCountInWaterFlowLayout:(MQWaterFlowLayout *)flowLayout;
/// 返回行间距
- (CGFloat)rowMarginInWaterFlowLayout:(MQWaterFlowLayout *)flowLayout;
/// 返回列间距
- (CGFloat)columnMarginInWaterFlowLayout:(MQWaterFlowLayout *)flowLayout;
/// 返回内边距
- (UIEdgeInsets)edgeInsetsInWaterFlowLayout:(MQWaterFlowLayout *)flowLayout;

@end
@interface MQWaterFlowLayout : UICollectionViewLayout

@property (weak, nonatomic) id <MQWaterFlowLayoutDelegate> delegate;
@end
