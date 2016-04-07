//
//  YFChannelLabel.m
//  YF01-网易新闻
//
//  Created by apple on 16/4/6.
//  Copyright © 2016年 fei. All rights reserved.
//

#import "YFChannelLabel.h"

#define YFSelectedFont 18.0f
#define YFNorFont 14.0f

@implementation YFChannelLabel


+ (instancetype)channelLabelWithTitle:(NSString *)title {
    
    YFChannelLabel *label = [[YFChannelLabel alloc] init];
    label.text = title;
    
    // 先设置字体的大小为选中大小
    label.font = [UIFont systemFontOfSize:YFSelectedFont];
    // 自适应
    [label sizeToFit];
    // 设置文字居中
    label.textAlignment = NSTextAlignmentCenter;
    
    // 再将字体设置成默认大小
    label.font = [UIFont systemFontOfSize:YFNorFont];
    
   // 打开用户交互 －－ label和imageView 都需要手动打开交互
    label.userInteractionEnabled = YES;
    return label;
}

- (void)setScale:(CGFloat)scale {
    _scale = scale;
    // 根据缩放比例设置字体颜色和大小
    // (18 - 14) / 18 * scale + 1
    CGFloat percent = (YFSelectedFont - YFNorFont) / YFSelectedFont * scale + 1;
//    NSLog(@"%f",percent);
//    self.font = [UIFont systemFontOfSize:percent * YFNorFont];
    // 或是采用transform
    self.transform = CGAffineTransformMakeScale(percent, percent);
    
    self.textColor = [UIColor colorWithRed:scale green:0 blue:0 alpha:1];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.clickChannel) {
        // 调用block
        self.clickChannel();
    }
}

@end
