//
//  Util.m
//  KCKPLeader
//
//  Created by 程三 on 15/11/26.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "Util.h"
#import <UIKit/UIKit.h>

@implementation Util
+(CGFloat)getUIScreenWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}
+(CGFloat)getUIScreenHeight
{
    return [UIScreen mainScreen].bounds.size.height;
}
+(float)getVersion
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}
+(int)getStatusBarHeight
{
    return [[UIApplication sharedApplication] statusBarFrame].size.height;
}
@end
