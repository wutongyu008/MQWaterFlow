//
//  MQGridFlowLayout.h
//  MQWaterFlowLayout
//
//  Created by qiuming on 16/1/11.
//  Copyright © 2016年 qiuming. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MQGridFlowLayout;
@protocol MQGridFlowLayoutDelegate <NSObject>

@optional
/// 返回行间距
- (CGFloat)rowMarginInWaterFlowLayout:(MQGridFlowLayout *)flowLayout;
/// 返回列间距
- (CGFloat)columnMarginInWaterFlowLayout:(MQGridFlowLayout *)flowLayout;
/// 返回内边距
- (UIEdgeInsets)edgeInsetsInWaterFlowLayout:(MQGridFlowLayout *)flowLayout;

@end

@interface MQGridFlowLayout : UICollectionViewLayout

@property (weak, nonatomic) id <MQGridFlowLayoutDelegate> delegate;

@end
