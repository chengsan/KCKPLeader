//
//  PhoneBindingViewController.m
//  KCKPLeader
//
//  Created by Siren on 15/11/25.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "PhoneBindingViewController.h"

@interface PhoneBindingViewController ()

@end

@implementation PhoneBindingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self.title isEqualToString:@"换绑手机"]) {
        [self.confirmBtn setTitle:@"验证后绑定手机" forState:UIControlStateNormal];
    }
    else{
        [self.confirmBtn setTitle:@"确认绑定" forState:UIControlStateNormal];
    }
    self.confirmBtn.backgroundColor = NAVICOLOR;
    
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
