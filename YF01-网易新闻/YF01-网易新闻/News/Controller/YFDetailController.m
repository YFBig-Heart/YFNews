//
//  YFDetailController.m
//  YF01-网易新闻
//
//  Created by apple on 16/4/7.
//  Copyright © 2016年 fei. All rights reserved.
//

#import "YFDetailController.h"
#import "YFHTTPSessionManager.h"

@interface YFDetailController ()<UIWebViewDelegate>

@property(nonatomic, strong)UIWebView *webView;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *newsTitle;
@property (nonatomic, copy) NSString *time;
@end

@implementation YFDetailController

- (void)loadView {
    
    self.webView = [[UIWebView alloc] init];
    // 设置代理
    self.webView.delegate = self;
    self.view = self.webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadData];
}
/**
 *  加载新闻详情页
 */
- (void)loadData {
    // http://c.m.163.com/nc/article/BJV8OPGD00234KO7/full.html

    // 加载详情数据
    [[YFHTTPSessionManager shareSessionManager] GET:self.detailURL parameters:nil comletionHandle:^(NSDictionary *responseObject, NSError *error) {

//        NSLog(@"%@",responseObject);
        // 取出第一个key
        NSString *key  = responseObject.keyEnumerator.nextObject;
        // 取出内容的字典
        NSDictionary *content = responseObject[key];
       
        // 取出新闻内容
        __block NSString *body = content[@"body"];
        
        // 取出所有的图片数据
        NSArray *images = content[@"img"];
       // 遍历所有的图片
        [images enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           // 替换字符串
            NSString *ref = obj[@"ref"];
            body = [body stringByReplacingOccurrencesOfString:ref withString:[self imageHtmlWithDict:obj]];
            
        }];
        // 取出视频内容
        NSArray *video = content[@"video"];
        // 遍历所有的视频
        [video enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            // 替换字符串
            NSString *ref = obj[@"ref"];
            body = [body stringByReplacingOccurrencesOfString:ref withString:[self videoHtmlWithDict:obj]];
        }];
        // 标题
        NSString *title =content[@"title"];
        // 时间和来源
        NSString *time = [NSString stringWithFormat:@"%@ %@",content[@"ptime"],content[@"source"]];
        self.body = body;
        self.newsTitle = title;
        self.time = time;
        
        // 加载详情页html
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"detail.html" withExtension:nil];
        
        // 请求
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:30];
        // 加载详情
        [self.webView loadRequest:request];
        
    }];
    
}


- (NSString *)imageHtmlWithDict:(NSDictionary *)dict {
    NSString *html = [NSString stringWithFormat:@"<img src=\"%@\" width=\"100%%\">"
                      "<span style=\"font-size: 13px;color: grey\">%@</span>",dict[@"src"],dict[@"alt"]];
    return html;
}
- (NSString *)videoHtmlWithDict:(NSDictionary *)dict {
    
    NSString *html = [NSString stringWithFormat:@"<video width=\"100%%\" controls>"
                      "<source src=\"%@\" type=\"video/mp4\">"
                      "</video>"
                      "<span style=\"font-size: 13px;color: grey\">%@</span>",dict[@"url_mp4"],dict[@"alt"]];
    
    return html;
}
#pragma mark 代理方法
// 加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView {
     // 调用js的方法
    NSString *code = [NSString stringWithFormat:@"changeContent('%@','%@','%@')",self.newsTitle,self.time, self.body];
    // 把js代码拼接到webview
    [webView stringByEvaluatingJavaScriptFromString:code];
}

@end
