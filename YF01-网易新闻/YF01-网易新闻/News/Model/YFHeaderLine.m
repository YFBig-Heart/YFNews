//
//  YFHeaderLine.m
//  YF01-网易新闻
//
//  Created by apple on 16/4/5.
//  Copyright © 2016年 fei. All rights reserved.
//

#import "YFHeaderLine.h"
#import "YFAPIManager.h"
#import <YYModel/YYModel.h>

@implementation YFHeaderLine

+ (void)headLineWithCompletion:(void (^)(NSArray *))completion {
    //加载头部view的网络数据
    YFAPIManager *manager = [YFAPIManager shareAPIManager];
    [manager requestHeadLineWithComletionHandle:^(NSDictionary *responseObject, NSError *error) {
       
        // NSLog(@"%@",responseObject);
        // 判断是否请求成功
        if (responseObject) {
            // 请求成功 -- 获取第一个key
            NSString *key = responseObject.keyEnumerator.nextObject;
            NSArray *data = responseObject[key];
            
           // 将数组中的数据转成模型
            /**
             yy_modelArrayWithClass 就是模型类
             json 就是返回的json数据
             */
            NSArray *headLine = [NSArray yy_modelArrayWithClass:self json:data];
            // NSLog(@"%@",headLine);
            completion(headLine);
        }else {
            // 请求失败
            completion(nil);
        }
        
        
    }];
    
}

@end
