//
//  HMSingle.h
//  13-一次性执行
//
//  Created by HM on 16/3/22.
//  Copyright © 2016年 HM. All rights reserved.
//
// ## 可以在宏定义中拼接变量，可以直接拼接到后面
// 宏定义如果有多行，可以使用\来拼接
#define HMSingleInterface(name) +(instancetype)shared##name;
#define HMSingleImplemen(name) +(instancetype)shared##name {\
return [[self alloc]init];\
}\
+ (instancetype)allocWithZone:(struct _NSZone *)zone {\
    static id instance;\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        instance = [super allocWithZone:zone];\
    });\
    return instance;\
}\
- (id)copy {\
    return self;\
}