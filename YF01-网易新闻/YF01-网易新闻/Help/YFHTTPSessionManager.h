//
//  YFHTTPSessionManager.h
//  YF01-网易新闻
//
//  Created by apple on 16/4/5.
//  Copyright © 2016年 fei. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "HMSingle.h"

@interface YFHTTPSessionManager : AFHTTPSessionManager
/**
 *  创建一个单例对象
 */
+ (instancetype)shareSessionManager;

/**
 *  自定义GET请求
 *
 *  @param path            路径
 *  @param parasmeters     参数
 *  @param comletionHandle 完成回调
 */
- (void)GET:(NSString *)path parameters:(id)parameters comletionHandle:(void(^)(id responseObject, NSError *error))comletionHandle;
/**
 *  自定义POST请求
 *
 *  @param path            路径
 *  @param parasmeters     参数
 *  @param comletionHandle 完成回调
 */
- (void)POST:(NSString *)path parameters:(id)parameters comletionHandle:(void(^)(id responseObject, NSError *error))comletionHandle;
@end

