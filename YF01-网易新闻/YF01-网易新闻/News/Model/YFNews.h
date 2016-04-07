//
//  YFNews.h
//  YF01-网易新闻
//
//  Created by apple on 16/4/5.
//  Copyright © 2016年 fei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFNews : NSObject

/**
 *  跟帖数
 */
@property (nonatomic, copy) NSString *replyCount;
/**
 *  新闻标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  图片
 */
@property (nonatomic, copy) NSString *imgsrc;
/**
 *  新闻简介
 */
@property (nonatomic, copy) NSString *digest;
/**
 *  图片类型，如果是1 就是显示大图
 */
@property (nonatomic, copy) NSString *imgType;
/**
 *  更多的图片
 */
@property (nonatomic, strong) NSArray *imgextra;
/**
 *  加载新闻详情页的id
 */
@property (nonatomic, copy) NSString *docid;
/**
 *  加载新闻详情的URL
 */
@property (nonatomic, copy) NSString *detailURL;

+ (void)newsDataWithPath:(NSString *)path completion:(void(^)(NSArray *newDatas))completion;
@end
