//
//  YFNewsCell.m
//  YF01-网易新闻
//
//  Created by apple on 16/4/5.
//  Copyright © 2016年 fei. All rights reserved.
//

#import "YFNewsCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "YFNews.h"
#import "YFNewsImage.h"

@interface YFNewsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleVLabel;
@property (weak, nonatomic) IBOutlet UILabel *digestLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyCountLabel;
/**
 *  更多的图片
 */
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *images;

@end
@implementation YFNewsCell

- (void)setNews:(YFNews *)news {
    _news = news;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:news.imgsrc] placeholderImage:nil options:SDWebImageLowPriority | SDWebImageRetryFailed ];
    
    // 设置标题
    self.titleVLabel.text = news.title;
    // 设置简介
    self.digestLabel.text = news.digest;
    // 设置跟贴数
    // 判断是否有跟贴数
    if (news.replyCount) {
        self.replyCountLabel.text = [NSString stringWithFormat:@"%@人跟贴",news.replyCount];
    }else {
        self.replyCountLabel.text = @"0人跟贴";
    }

    // imgextra有值说明是有更多图片
    if (_news.imgextra) {
        
        // 遍历
        [_news.imgextra enumerateObjectsUsingBlock:^(YFNewsImage *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           // 取出imageview
            UIImageView *imageView = self.images[idx];
            // 下载图片
            [imageView sd_setImageWithURL:[NSURL URLWithString:obj.imgsrc] placeholderImage:nil options:SDWebImageLowPriority | SDWebImageRetryFailed];
            
        }];
      
    }
  
}
// 判断cell的类型
+ (NSString *)cellIdentifierWithNews:(YFNews *)news {
    
    NSString *indentifier;
    if (news.imgType) { // imgType 有值时即为大图
        indentifier = @"YFNewsBigImageCell";
    }else if (news.imgextra) {
        // 有值代表有多张图片
        indentifier = @"YFNewsmoreImageCell";
    }else {
        indentifier = @"YFNewsCell";
    }
    return indentifier;
}
// 返回cell的高度
+ (CGFloat)cellHeightWithNews:(YFNews *)news {
    
    CGFloat rowHeight = 0;
    if ([news.imgType isEqualToString:@"1"]) { // imgType 有值时即为大图
        rowHeight = 150;
    }else if (news.imgextra) {
        // 有值代表有多张图片
        rowHeight = 130;
        
    }else {
        rowHeight = 80;
    }
    return rowHeight;
}


@end

