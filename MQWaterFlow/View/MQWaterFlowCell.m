//
//  MQWaterFlowCell.m
//  MQWaterFlowLayout
//
//  Created by qiuming on 16/1/11.
//  Copyright © 2016年 qiuming. All rights reserved.
//

#import "MQWaterFlowCell.h"
#import "UIImageView+WebCache.h"

@interface MQWaterFlowCell()
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation MQWaterFlowCell

- (void)awakeFromNib {
    self.pictureView.layer.borderWidth = 5;
    self.pictureView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.pictureView.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)setWaterModel:(MQWaterModel *)waterModel
{
    _waterModel = waterModel;
    
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:waterModel.img] placeholderImage:[UIImage imageNamed:@"loading"]];
    
    self.priceLabel.text = waterModel.price;
}
@end
