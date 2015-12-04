//
//  EPNaviController.m
//  EProcess
//
//  Created by Siren on 15/11/24.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import "EPNaviController.h"

@interface EPNaviController ()

@end

@implementation EPNaviController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.barTintColor = NAVICOLOR;
    self.navigationBar.translucent = NO;
    
    //改变返回按钮文字颜色为白色
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
     [self.navigationBar setTintColor:[UIColor whiteColor]];
    
    //隐藏返回按钮的文字
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
