//
//  LoadDataDemo.m
//  KCKPLeader
//
//  Created by 程三 on 15/11/25.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "LoadDataDemo.h"

@implementation LoadDataDemo

/*
 #pragma mark 点击回调事件
 -(void)onClick:(UIButton *)btn
 {
 NSString *name = @"110000002000";
 NSString *pass = [@"888888a" md5];
 
 NSMutableDictionary *bean = [[NSMutableDictionary alloc] init];
 
 NSMutableDictionary *childBean = [[NSMutableDictionary alloc] init];
 [childBean setValue:@"15102722895" forKey:@"phonenumber"];
 [childBean setValue:[@"888888" md5] forKey:@"userpwd"];
 [childBean setValue:@"1111111" forKey:@"loginip"];
 [childBean setValue:@"15102722895" forKey:@"phonenumber"];
 [bean setValue:childBean forKey:@"userbean"];
 childBean = nil;
 
 [bean setValue:name forKey:@"username"];
 [bean setValue:pass forKey:@"password"];
 
 
 [[Globle getInstance].service requestWithServiceName:@"kckpAppLogin" params:bean httpMethod:@"POST" resultIsDictionary:true completeBlock:^(id result)
 {
 NSDictionary *dic = result;
 NSLog(@"result:%@",dic);
 }];
 
 }
 
 //初始化Globle
 -(void)initGloble
 {
 [Globle getInstance].serviceURL = ServiceURL;
 [Globle getInstance].updateURL = UpdateURL;
 }

 */
@end
