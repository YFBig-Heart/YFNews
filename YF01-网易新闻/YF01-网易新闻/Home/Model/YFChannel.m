//
//  YFChannel.m
//  YF01-网易新闻
//
//  Created by apple on 16/4/6.
//  Copyright © 2016年 fei. All rights reserved.
//

#import "YFChannel.h"
#import <YYModel/YYModel.h>

@implementation YFChannel

+ (NSArray *)channels {
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"topic_news.json" withExtension:nil];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    
    NSDictionary *topics = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    //取出第一个key值
    NSString *key = topics.keyEnumerator.nextObject;
    NSArray *channels = topics[key];

    // 将数组转成模型
    channels = [NSArray yy_modelArrayWithClass:self json:channels];
    // 对数据进行排序
    channels = [channels sortedArrayUsingComparator:^NSComparisonResult(YFChannel *_Nonnull obj1, YFChannel *_Nonnull obj2) {
        // 对哪些要设置是否区分大小写之类的就可以用下面的方法
//        obj1.tid compare:<#(nonnull NSString *)#> options:<#(NSStringCompareOptions)#>
       return [obj1.tid compare:obj2.tid];
    }];
    
//    NSLog(@"%@",channels);
    return channels;
}

@end
