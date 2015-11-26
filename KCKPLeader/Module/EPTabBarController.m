//
//  EPTabBarController.m
//  EProcess
//
//  Created by Siren on 15/11/24.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import "EPTabBarController.h"

@interface EPTabBarController ()

@end

@implementation EPTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *names = @[@"首页",@"处理情况",@"决策分析",@"设置"];
    NSArray *imgAry = @[@"nav01",@"nav02",@"nav03",@"nav04"];
    NSArray *selectedImgAry = @[@"nav01_on",@"nav02_on",@"nav03_on",@"nav04_on"];
    for (int i=0; i<4; i++) {
        UINavigationController *nav = self.viewControllers[i];
        UIViewController *vc = nav.viewControllers[0];
        UIImage *image = [UIImage imageNamed:imgAry[i]];
        UIImage *selectedImage = [UIImage imageNamed:selectedImgAry[i]];
        vc.tabBarItem = [[UITabBarItem alloc]initWithTitle:names[i] image:image selectedImage:selectedImage];
        
    }
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
