//
//  YFChannel.h
//  YF01-网易新闻
//
//  Created by apple on 16/4/6.
//  Copyright © 2016年 fei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFChannel : NSObject
@property (nonatomic, copy) NSString *tid;
@property (nonatomic, copy) NSString *tname;

// 加载本地json数据
+ (NSArray *)channels;
@end
