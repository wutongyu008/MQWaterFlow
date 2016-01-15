//
//  ViewController.m
//  MQWaterFlowLayout
//
//  Created by qiuming on 16/1/11.
//  Copyright © 2016年 qiuming. All rights reserved.
//

#import "MQExampleViewController.h"
#import "MQWaterFlowController.h"
#import "MQGridFlowController.h"
#import "MQPhotoWallController.h"
#import "MQExample.h"
#import <MJRefresh.h>

NSString *const reusedID = @"reusedID";

NSString *const MQExample00 = @"自定义流水布局样式一";
NSString *const MQExample01 = @"自定义流水布局样式二";
NSString *const MQExample02 = @"自定义流水布局样式三";

@interface MQExampleViewController ()<UITableViewDataSource>
@property (strong, nonatomic) NSArray *examples;
@end

@implementation MQExampleViewController

#pragma mark - 懒加载
- (NSArray *)examples
{
    if (_examples == nil) {
        MQExample *example0 = [[MQExample alloc]init];
        example0.vcClass = [MQWaterFlowController class];
        example0.header = MQExample00;
        example0.titles = @[@"普通电商类展示"];
        
        MQExample *example1 = [[MQExample alloc]init];
        example1.vcClass = [MQGridFlowController class];
        example1.header = MQExample01;
        example1.titles = @[@"照片展示"];
        
        MQExample *example2 = [[MQExample alloc]init];
        example2.vcClass = [MQPhotoWallController class];
        example2.header = MQExample02;
        example2.titles = @[@"照片墙展示"];
        
        self.examples = @[example0, example1, example2];
    }
    return _examples;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar"] forBarMetrics:UIBarMetricsDefault];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reusedID];

    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        // 模拟延迟加载数据(为以后扩展预留)
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    // 结束刷新
                    [self.tableView.mj_header endRefreshing];
                });
    }];
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSUInteger i = 1; i <= 8 ; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%zd", i]];
        [arrayM addObject:image];
        
    }
    // 设置普通状态的动画图片
    [header setImages:arrayM forState:MJRefreshStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [header setImages:arrayM forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [header setImages:arrayM forState:MJRefreshStateRefreshing];
    // 设置header
    self.tableView.mj_header = header;
    // 根据拖拽比设置透明度
    self.tableView.mj_header.automaticallyChangeAlpha = 0.9;
    
    
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 模拟延迟加载数据(为以后扩展预留)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [self.tableView.mj_footer endRefreshing];
        });
    }];

}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.examples.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.examples[section] titles].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID forIndexPath:indexPath];
    
    MQExample *example = self.examples[indexPath.section];
    cell.textLabel.text = example.titles[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    MQExample *example = self.examples[section];
    return example.header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MQExample *example = self.examples[indexPath.section];
    UIViewController *vc = [[example.vcClass alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end



















