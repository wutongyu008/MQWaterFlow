//
//  MQPhotoWallLayout.h
//  MQWaterFlowLayout
//
//  Created by qiuming on 16/1/15.
//  Copyright © 2016年 qiuming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MQPhotoWallLayout;
@protocol MQPhotoWallLayoutDelegate <NSObject>

@optional
/// 返回行间距
- (CGFloat)rowMarginInWaterFlowLayout:(MQPhotoWallLayout *)flowLayout;
/// 返回列间距
- (CGFloat)columnMarginInWaterFlowLayout:(MQPhotoWallLayout *)flowLayout;
/// 返回内边距
- (UIEdgeInsets)edgeInsetsInWaterFlowLayout:(MQPhotoWallLayout *)flowLayout;

@end

@interface MQPhotoWallLayout : UICollectionViewLayout

@property (weak, nonatomic) id <MQPhotoWallLayoutDelegate> delegate;

@end