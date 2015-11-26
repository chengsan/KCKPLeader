//
//  LoginViewController.m
//  KCKPLeader
//
//  Created by Siren on 15/11/26.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "LoginViewController.h"
#import "HomePageViewController.h"
@interface LoginViewController ()<UITextFieldDelegate>
{
    NSString *userName;
    NSString *passWord;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = NAVICOLOR;
    self.navigationController.navigationBarHidden = YES;
//    self.tabBarController.tabBar.hidden = YES;
    [self.loginBtn addTarget:self action:@selector(presentHomePage) forControlEvents:UIControlEventTouchUpInside];
    self.loginBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.loginBtn.layer.borderWidth = 1.0;
    
    
    
//    [self loadDataWith:userName andWith:passWord];
}

//隐藏状态栏
-(BOOL)prefersStatusBarHidden{
    return YES;
}

//-(void)loadDataWith:(NSString *)userName andWith:(NSString *)passWord{
//    AFNetWorkService *service = [[AFNetWorkService alloc] init];
//    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"username":@"decanins",@"userpwd":@"888888a"}];
//    [service requestWithServiceName:@"DecAnapplogin" params:dic httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
//        
//        NSLog(@"%@",result);
//        
//    }];
//    
//}

-(void)presentHomePage{
    UIStoryboard *s = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    EPTabBarController *vc = [EPTabBarController ];
//    [self.navigationController pushViewController:vc animated:YES];
    self.view.window.rootViewController=[s instantiateInitialViewController];
//    [self presentViewController: animated:YES completion:nil];
    
}


-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    userName = self.userField.text;
    passWord = self.passField.text;
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
