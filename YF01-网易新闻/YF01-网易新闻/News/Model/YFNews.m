//
//  YFNews.m
//  YF01-网易新闻
//
//  Created by apple on 16/4/5.
//  Copyright © 2016年 fei. All rights reserved.
//

#import "YFNews.h"
#import "YFAPIManager.h"
#import <YYModel/YYModel.h>
#import "YFHTTPSessionManager.h"
#import "YFNewsImage.h"
@implementation YFNews

+ (void)newsDataWithPath:(NSString *)path completion:(void (^)(NSArray *))completion {
    
    [[YFAPIManager shareAPIManager] requestNewsDataWithPath:path comletionHandle:^(NSDictionary *responseObject, NSError *error) {
        if (responseObject) {
            // 请求成功
            NSString *key = responseObject.keyEnumerator.nextObject;
            // 取出新闻数据
            NSArray *data = responseObject[key];
        
            // 把数据转成模型数组
            NSArray *news = [NSArray yy_modelArrayWithClass:self json:data];
            // 回调
            completion(news);
        }else {
            completion(nil);
        }
    }];

}
/*
 The generic class mapper for container properties.
 @discussion If the property is a container object, such as NSArray/NSSet/NSDictionary,
 */
// 将news 中的_imgextra字典 -- 直接从第三方中的注释中将方法实现拷贝过来
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"imgextra" : [YFNewsImage class],};
             
}
// 将将在新闻详情的url 拼其来 -- 重写set或get方法都可以
- (void)setDocid:(NSString *)docid {
    _docid = docid;
    self.detailURL = [NSString stringWithFormat:@"article/%@/full.html",_docid];
}

@end
