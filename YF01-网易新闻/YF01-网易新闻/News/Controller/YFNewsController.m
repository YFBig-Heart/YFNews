//
//  YFNewsController.m
//  YF01-网易新闻
//
//  Created by apple on 16/4/5.
//  Copyright © 2016年 fei. All rights reserved.
//

#import "YFNewsController.h"
#import "YFNews.h"
#import "YFNewsCell.h"
#import "UIView+YFExt.h"
#import "YFDetailController.h"

@interface YFNewsController ()
/**
 *  模型数据
 */
@property (nonatomic, strong)NSArray *datas;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation YFNewsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTableViewData];

}
- (void)setURLString:(NSString *)URLString {
    _URLString = URLString;
    // 加载数据
    [self loadTableViewData];
}
// 加载数据
- (void)loadTableViewData {
    
    [YFNews newsDataWithPath:self.URLString completion:^(NSArray *newDatas) {
        self.datas = newDatas;
//        NSLog(@"%@ %@",[NSThread currentThread],newDatas);

        // 刷新表格
        [self.tableView reloadData];
    }];
    
}
/**
 *  UIContainerView相当于以下代码
 */
- (void)container {
    // 1. 加载头条控制器
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"News" bundle:nil];
    // 2. 加载指定的控制器
    UIViewController *headLine = [sb instantiateViewControllerWithIdentifier:@"HMHeadLineController"];
    
    // 3. 把headLine的view显示出来
    self.tableView.tableHeaderView = headLine.view;
    
    // 设置frame
    headLine.view.height = 250;
    
    // 4. 把控制控制器强引用
    [self addChildViewController:headLine];
    
}


#pragma mark 数据源和代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YFNews *news = self.datas[indexPath.row];

    
    YFNewsCell *cell  = [tableView dequeueReusableCellWithIdentifier:[YFNewsCell cellIdentifierWithNews:news] forIndexPath:indexPath];
    cell.news = news;

    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YFNews *news = self.datas[indexPath.row];
    return [YFNewsCell cellHeightWithNews:news];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YFNews *news = self.datas[indexPath.row];
    
    // 创建新闻详情页的控制器
    YFDetailController *detail = [[YFDetailController alloc] init];
     // 设置详情页的URL
    detail.detailURL = news.detailURL;
   
    
    // 跳转
    [self.navigationController pushViewController:detail animated:YES];
}
@end
