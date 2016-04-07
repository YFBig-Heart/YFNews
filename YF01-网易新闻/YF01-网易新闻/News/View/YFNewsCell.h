//
//  YFNewsCell.h
//  YF01-网易新闻
//
//  Created by apple on 16/4/5.
//  Copyright © 2016年 fei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YFNews;
@interface YFNewsCell : UITableViewCell

@property(nonatomic, strong)YFNews *news;
// 返回cell的高度
+ (CGFloat)cellHeightWithNews:(YFNews *)news;
// 判断cell的类型
+ (NSString *)cellIdentifierWithNews:(YFNews *)news;
@end
