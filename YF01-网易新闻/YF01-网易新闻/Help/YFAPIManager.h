//
//  YFAPIManager.h
//  YF01-网易新闻
//
//  Created by apple on 16/4/5.
//  Copyright © 2016年 fei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFAPIManager : NSObject

/**
 *  创建一个单例，用来获取和管理API
 */
+ (instancetype)shareAPIManager;

/**
 *  请求头条数据
 *
 *  @param comletionHandle 完成回调
 */
- (void)requestHeadLineWithComletionHandle:(void(^)(id responseObject, NSError *error))comletionHandle;
/**
 *  请求新闻数据
 *
 *  @param pata            频道的路径(URL)
 *  @param comletionHandle 完成回调
 */
- (void)requestNewsDataWithPath:(NSString *)path comletionHandle:(void(^)(id responseObject, NSError *error))comletionHandle;
@end
