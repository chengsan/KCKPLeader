//
//  AppDelegate.h
//  KCKPLeader
//
//  Created by 程三 on 15/11/24.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property float autoSizeScaleX;
@property float autoSizeScaleY;

+ (void)storyBoradAutoLay:(UIView *)allView;

@end

