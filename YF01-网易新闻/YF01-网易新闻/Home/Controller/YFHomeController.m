//
//  YFHomeController.m
//  YF01-网易新闻
//
//  Created by apple on 16/4/6.
//  Copyright © 2016年 fei. All rights reserved.
//

#import "YFHomeController.h"
#import "YFChannel.h"
#import "YFChannelLabel.h"
#import "UIView+YFExt.h"
#import "YFChannelCell.h"
#import "YFNewsController.h"

@interface YFHomeController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
/**
 *  加载的本地json频道数据
 */
@property (nonatomic, strong)NSArray *channels;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
/**
 *  当前选中第几页
 */
@property (nonatomic,assign) NSInteger currentSelected;

/**
 *  频道缓存
 */
@property (nonatomic, strong)NSMutableDictionary *channelCache;

@end

@implementation YFHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    // 在导航栏下面，scrollView默认会调整64,下有使用UIScrollView 及其派生类(UICollectionView,UIWebView,UITableView,UITextView)
    // 关闭自动调整
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setUpScrollView];
    
    
}
#pragma mark 设置scrollView
// 根据self.channels 数据循环添加label

- (void)setUpScrollView {
    // 加载频道数据
    self.channels = [YFChannel channels];
    
    CGFloat labelY = 0;
    CGFloat labelH = self.scrollView.height;
    __block CGFloat labelX = 0;
    
    __weak typeof(self) weakSelf = self;
    
    [self.channels enumerateObjectsUsingBlock:^(YFChannel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        YFChannelLabel *label = [YFChannelLabel channelLabelWithTitle:obj.tname];
        
        // 选中第一个
        if (idx == 0) {
            label.scale = 1;
        }
      
        __weak typeof(label) weakLabel = label;
        // 点击频道
        [label setClickChannel:^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
           // 滚动到选中的频道
            [weakSelf.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
            // 取出上一个被选中的label
            YFChannelLabel *currentLabel = weakSelf.scrollView.subviews[weakSelf.currentSelected];
             // 判断如果点击的就是当前选中的，就不作任何的处理
            if (idx == weakSelf.currentSelected) {
                return ;
            }
            
            currentLabel.scale = 0;
            // 设置缩放 － 放到后面可以防止同一个label点击了两次
            weakLabel.scale = 1;
            // 记录当前选中的index
            weakSelf.currentSelected = idx;
            // 调整offset
            [weakSelf adjustOffset];
        }];
       
        
        // 设置label的Frame
        CGFloat labelW = label.width;
        
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        
        [weakSelf.scrollView addSubview:label];

        
        // 把labelW叠加
        labelX += label.width;
    }];
    // 设置scrollView 的contentSize
    self.scrollView.contentSize = CGSizeMake(labelX, 0);
}
// 选择频道后调整scrollview的偏移量
- (void)adjustOffset {
    YFChannelLabel *label = self.scrollView.subviews[self.currentSelected];
    
    // 取出当前的选中的label的中心x值
    CGFloat labelX = label.x + label.width * 0.5;
    // 内容的宽
    CGFloat contentSizeX = self.scrollView.contentSize.width;
     CGFloat offsetX = 0;
    if (labelX > self.scrollView.width * 0.5) {
        offsetX = labelX - self.scrollView.width * 0.5;
    }
    // 判断offset 跟 contentSize 的关系
    if (labelX >contentSizeX - self.scrollView.width * 0.5 ) {
        offsetX = contentSizeX - self.scrollView.width;
    }
    
    if (labelX < self.scrollView.width * 0.5) {
        offsetX = 0;
    }
    // 设置scrollView的offset
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

#pragma mark 数据源和代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.channels.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // 取出模型数据
    YFChannel *channel = self.channels[indexPath.item];
    
    YFChannelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YFChannelCell" forIndexPath:indexPath];
    cell.channl = channel;
    
    // 移除旧的新闻view
    [cell.news.view removeFromSuperview];
    
    // 创建控制器
    YFNewsController *news = [self controllerWithCannel:channel];
    // 将控制器的view添加到cell上
    [cell.contentView addSubview:news.view];
    
    //记录当前的控制器
    cell.news = news;
    // 一般情况下，一个控制器使用另一个控制器的view，会把控制器添加到子控制器了。添加到子控制器了为了不让破坏响应者链
    // 添加之前，先判断，是否已经是子控制器
    if(![self.childViewControllers containsObject:news]){
        // 将控制器添加到子控制器
        [self addChildViewController:news];
         // 往数组中添加一个元素，实际上对元素引用计数器 + 1
    }
  
    return cell;
}
- (YFNewsController *)controllerWithCannel:(YFChannel *)channel {
    
    // 先从缓存中取出控制器 －－ 避免用户每次滑动都取下载数据
    YFNewsController *news = [self.channelCache objectForKey:channel.tname];
    
    // 判断news是否有值
    if (news == nil) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"News" bundle:nil];
        // 加载新闻页
        news = sb.instantiateInitialViewController;
        // 设置urlstring
        NSString *URLString = [NSString stringWithFormat:@"article/headline/%@/0-20.html",channel.tid];
        news.URLString = URLString;
        
        // 把控制器添加到词典
        [self.channelCache setObject:news forKey:channel.tname];
        
    }
    return news;
}
// 监听collectView 的滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 改变两个label的字体颜色
    YFChannelLabel *selectLabel = self.scrollView.subviews[self.currentSelected];

    // 获取可是的item －－ 本案中可视的item最多只有两个
    NSArray<NSIndexPath *> *visibleItem = [self.collectionView indexPathsForVisibleItems];
    // 遍历
    // 记录即将被选中的label
    __block YFChannelLabel *nextLabel;
    
    [visibleItem enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 判断是否为当前选中的
        if (obj.item != self.currentSelected) {
            nextLabel = self.scrollView.subviews[obj.item];
        }
        
    }];
    if (nextLabel == nil) {
        // 如果没有下一个频道
        return;
    }

    // 获取偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    // 计算缩放比例
    CGFloat scale = ABS(offsetX / scrollView.width - self.currentSelected);

    // 当前选中的缩放比例
    selectLabel.scale = 1 - scale;
    // 下一个选中的label的缩放比例
    nextLabel.scale = scale;
    
//    NSLog(@"%f -- %f",1-scale, scale);
 
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 获取偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 设置当前选中的页
    self.currentSelected = offsetX / scrollView.width;
    
}

#pragma mark 设置collectionView
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self setUpCollectionView];
}
- (void)setUpCollectionView {
    self.flowLayout.itemSize = self.collectionView.bounds.size;
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (NSMutableDictionary *)channelCache {
    if (_channelCache == nil) {
        _channelCache = [NSMutableDictionary dictionary];
    }
    return _channelCache;
}

@end
