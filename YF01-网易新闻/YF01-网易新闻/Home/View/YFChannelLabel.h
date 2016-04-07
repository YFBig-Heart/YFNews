//
//  YFChannelLabel.h
//  YF01-网易新闻
//
//  Created by apple on 16/4/6.
//  Copyright © 2016年 fei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFChannelLabel : UILabel


/**
 *  初始化一个label
 *
 *  @param title label的文字
 *
 *  @return 返回一个初始化好的label
 */
+ (instancetype)channelLabelWithTitle:(NSString *)title;

/**
 *  缩放比例
 */
@property (nonatomic,assign) CGFloat scale;
/**
 *  点击label就调用这个代码块
 */
@property (nonatomic, copy)void (^clickChannel)();
@end
