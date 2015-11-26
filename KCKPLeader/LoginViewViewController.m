//
//  LoginViewViewController.m
//  KCKPLeader
//
//  Created by 程三 on 15/11/25.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "LoginViewViewController.h"
#import "UIViewExt.h"
#import "Util.h"

@interface LoginViewViewController ()

@end

@implementation LoginViewViewController

-(id)init
{
    self = [super init];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //使用的是原生值
    [self.view setBackgroundColor:[UIColor colorWithRed:52/255.0 green:130/255.0 blue:255/255.0 alpha:1]];
    
    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_txt.png"]];
    titleView.frame = CGRectZero;
    //根据屏幕的宽和高计算图片的位置
    titleView.width = [Util getUIScreenWidth] * 0.8;
    titleView.left = ([Util getUIScreenWidth] - titleView.width)/2;
    titleView.top = [Util getUIScreenHeight] * 0.1;
    titleView.height = 154 * titleView.width/844;
    [self.view addSubview:titleView];
    
    UIImageView *iconImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_img.png"]];
    iconImage.frame = CGRectZero;
    iconImage.top = [Util getUIScreenHeight] * 0.1;
    iconImage.width = [Util getUIScreenWidth];
    iconImage.left = ([Util getUIScreenWidth] - iconImage.width)/2;
    iconImage.height = 832 * iconImage.width/851;
    [self.view addSubview:iconImage];
    
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
