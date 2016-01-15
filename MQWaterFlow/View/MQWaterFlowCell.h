//
//  MQWaterFlowCell.h
//  MQWaterFlowLayout
//
//  Created by qiuming on 16/1/11.
//  Copyright © 2016年 qiuming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MQWaterModel.h"

static NSString *const WaterFlowLayoutReusedID = @"WaterFlowLayoutReusedID";

@interface MQWaterFlowCell : UICollectionViewCell

@property (strong, nonatomic) MQWaterModel *waterModel;
@end
