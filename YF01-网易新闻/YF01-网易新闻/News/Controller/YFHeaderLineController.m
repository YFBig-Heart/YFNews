//
//  YFHeaderLineController.m
//  YF01-网易新闻
//
//  Created by apple on 16/4/5.
//  Copyright © 2016年 fei. All rights reserved.
//

#import "YFHeaderLineController.h"
#import "YFHeaderLine.h"
#import "YFHeaderLineCell.h"

@interface YFHeaderLineController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIPageControl *pageContr;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong)NSArray *headLineData;

@end

@implementation YFHeaderLineController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCollectionView];
    [self loadHeadLineData];
   
}
// 加载模型数据
- (void)loadHeadLineData {
    [YFHeaderLine headLineWithCompletion:^(NSArray *headLine) {
        
        NSMutableArray *array = [NSMutableArray arrayWithArray:headLine];
        [array addObject:headLine.firstObject];
        [array insertObject:headLine.lastObject atIndex:0];
        
        self.headLineData = array.copy;
        // 刷新collectionView
        [self.collectionView reloadData];
        // 设置总的
        self.pageContr.numberOfPages = headLine.count;
    }];
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 设置cell的item size
    self.flowLayout.itemSize = self.collectionView.bounds.size;
//    NSLog(@"%@",NSStringFromCGRect(self.collectionView.bounds));
}

// 设置collectionView
- (void)setCollectionView {
    
    
    // 去掉滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    // 去掉弹簧
    self.collectionView.bounces = NO;
    // 设置分业效果
    self.collectionView.pagingEnabled = YES;
    // 设置列间距
    self.flowLayout.minimumLineSpacing = 0;
    
    // 设置滚动方向
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
}

#pragma mark 数据源和代理
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.headLineData.count;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
     YFHeaderLineCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YFHeaderLineCell" forIndexPath:indexPath];
    
    cell.headerLine = self.headLineData[indexPath.item];
    
    
    return cell;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 获取偏移量
    CGFloat offsetX= scrollView.contentOffset.x;
    // collectionView 的宽度
    CGFloat width = scrollView.bounds.size.width;
    
    // 计算当前滚动到第几页
    NSInteger index = offsetX / width;
    if (index == 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:4 inSection:0];
        
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }else if (index == 5) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];  
    }
    
}

@end
