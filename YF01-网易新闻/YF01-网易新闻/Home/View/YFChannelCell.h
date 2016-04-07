//
//  YFChannelCell.h
//  YF01-网易新闻
//
//  Created by apple on 16/4/6.
//  Copyright © 2016年 fei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YFChannel,YFNewsController;
@interface YFChannelCell : UICollectionViewCell

/**
 *  频道模型数据
 */
@property (nonatomic, strong)YFChannel *channl;
/**
 *  当前的控制器
 */
@property (nonatomic, strong)YFNewsController *news;

@end
