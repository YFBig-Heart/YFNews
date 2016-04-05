//
//  YFAPIManager.m
//  YF01-网易新闻
//
//  Created by apple on 16/4/5.
//  Copyright © 2016年 fei. All rights reserved.
//

#import "YFAPIManager.h"
#import "YFHTTPSessionManager.h"

@implementation YFAPIManager

+ (instancetype)shareAPIManager {
    
    static dispatch_once_t onceToken;
    static YFAPIManager *manager;
    
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]init];
    });
    
    return manager;
}
/**
 *  请求头条数据
 *
 *  @param comletionHandle 完成回调
 */
- (void)requestHeadLineWithComletionHandle:(void(^)(id responseObject, NSError *error))comletionHandle {
    
    YFHTTPSessionManager *manager = [YFHTTPSessionManager shareSessionManager];
    // 调用网络请求方法
    [manager GET:@"ad/headline/0-4.html" parameters:nil comletionHandle:comletionHandle];
    
}

@end
