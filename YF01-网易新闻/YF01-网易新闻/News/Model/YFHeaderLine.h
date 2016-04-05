//
//  YFHeaderLine.h
//  YF01-网易新闻
//
//  Created by apple on 16/4/5.
//  Copyright © 2016年 fei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFHeaderLine : NSObject
/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  图片的地址
 */
@property (nonatomic, copy) NSString *imgsrc;


/**
 *  请求头条数据
 *  网络数据是在子线程加载的需要使用block或者代理，不可以直接用返回值
 *  @param completion 完成回调
 */
+ (void)headLineWithCompletion:(void (^)(NSArray *headLine))completion;

@end
