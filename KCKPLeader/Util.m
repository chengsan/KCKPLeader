//
//  Util.m
//  KCKPLeader
//
//  Created by 程三 on 15/11/25.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "Util.h"
#import <UIKit/UIKit.h>

@implementation Util

#pragma mark 获取屏幕宽度
+(int)getUIScreenWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}

#pragma mark 获取屏幕高度
+(int)getUIScreenHeight
{
    return [UIScreen mainScreen].bounds.size.height;
}

#pragma mark 状态栏的高度
+(int)getStatusBarHeight
{
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    return rectStatus.size.height;
}

#pragma mark 状态栏的宽度
+(int)getStatusBarWidth
{
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    return rectStatus.size.width;
}

#pragma mark 获取系统版本好
+(float)getVersion
{
    //获取系统版本
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    return version;
}

@end
