//
//  YFHeaderLineCell.m
//  YF01-网易新闻
//
//  Created by apple on 16/4/5.
//  Copyright © 2016年 fei. All rights reserved.
//

#import "YFHeaderLineCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "YFHeaderLine.h"

@interface YFHeaderLineCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end
@implementation YFHeaderLineCell

- (void)setHeaderLine:(YFHeaderLine *)headerLine {
    _headerLine = headerLine;
    /*
     SDWebImageRetryFailed 下载失败下次会再次尝试
     SDWebImageLowPriority 降低优先级，在滚动的时候不加载图片
     
     
     
     SDWebImageRefreshCached 刷新缓存，会去下载新的图片
     */
//    NSLog(@"%@",headerLine.imgsrc);
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:headerLine.imgsrc] placeholderImage:nil options:SDWebImageLowPriority | SDWebImageRetryFailed];
}

@end
