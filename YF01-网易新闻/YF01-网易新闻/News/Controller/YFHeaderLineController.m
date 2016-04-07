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
 
        self.headLineData = headLine;
        // 刷新collectionView
        [self.collectionView reloadData];
        // 设置总的
        self.pageContr.numberOfPages = headLine.count;
        
        // 设置第一页的标题
        [self scrollViewDidEndDecelerating:self.collectionView];
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:1];
        
         // 默认滚动第一页
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        
    }];
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 设置cell的item size
    self.flowLayout.itemSize = self.collectionView.bounds.size;

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
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}
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
    
    NSInteger index = offsetX / width;
    // 第几组
    NSInteger section = index / self.headLineData.count;
    // 第组的第几页
    NSInteger sectionIndex = index % self.headLineData.count;
    
    // 取出模型数据
    YFHeaderLine *headline = self.headLineData[sectionIndex];

    if ( section != 1) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sectionIndex inSection:1];
        
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }
    
    // 设置当前的滚动的页码
    self.pageContr.currentPage = sectionIndex;
    // 设置标题
    self.titleLabel.text = headline.title;
    
}

@end


