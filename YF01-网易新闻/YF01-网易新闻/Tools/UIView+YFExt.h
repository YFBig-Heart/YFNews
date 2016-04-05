//
//  UIView+YFExt.h
//  YF-网易彩票
//
//  Created by apple on 16/3/12.
//  Copyright © 2016年 fei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YFExt)

@property (nonatomic, assign)CGFloat x;
@property (nonatomic, assign)CGFloat y;
@property (nonatomic, assign)CGFloat width;
@property (nonatomic, assign)CGFloat height;

@property (nonatomic, assign)CGSize size;
//- (void)setX:(CGFloat)x; 如果使用 property 不太懂，可以使用setter和getter方法，效果是一样的
//- (CGFloat)x;

@end
