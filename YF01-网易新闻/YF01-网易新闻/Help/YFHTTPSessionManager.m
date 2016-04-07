//
//  YFHTTPSessionManager.m
//  YF01-网易新闻
//
//  Created by apple on 16/4/5.
//  Copyright © 2016年 fei. All rights reserved.
//

#import "YFHTTPSessionManager.h"

#define YFBaseURL [NSURL URLWithString:@"http://c.m.163.com/nc/"]

@implementation YFHTTPSessionManager
+ (instancetype)shareSessionManager {
    
    static dispatch_once_t onceToken;
    static YFHTTPSessionManager *manager;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] initWithBaseURL:YFBaseURL];
        // NSLocalizedDescription=Request failed: unacceptable content-type: text/html -- 碰到这种错误需要配置数据的解析的类型
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        
    });
    return manager;
}

- (void)GET:(NSString *)path parameters:(id)parameters comletionHandle:(void(^)(id responseObject, NSError *error))comletionHandle {
    // 自己定义的方法，然后要去调用封装好的方法
    [self GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        comletionHandle(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        comletionHandle(nil, error);
    }];
    
}
- (void)POST:(NSString *)path parameters:(id)parameters comletionHandle:(void(^)(id responseObject, NSError *error))comletionHandle {
    // 自己定义的方法，然后要去调用封装好的方法
    [self POST:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        comletionHandle(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        comletionHandle(nil, error);
    }];
    
}
@end
