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
    
    
    [self loadData];
}

-(void)loadData
{
    
//    NSString *name = @"decanpol";
//    NSString *pass = [@"888888a" md5];
//    NSMutableDictionary *bean = [[NSMutableDictionary alloc] init];
//    [bean setValue:name forKey:@"username"];
//    [bean setValue:pass forKey:@"userpwd"];
//    
//    [[Globle getInstance].service requestWithServiceIP:ServiceURL ServiceName:@"DecAnapplogin" params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
//        
//        NSLog(@"%@",result);
//        
//    } ];
    
    NSString *name = @"decanins";
//    NSString *pass = [@"888888a" md5];
    NSString *pass = @"F11351A8B0D7483AEBCE6CBD7679F33A";
    NSMutableDictionary *bean = [[NSMutableDictionary alloc] init];
    
    NSMutableDictionary *childBean = [[NSMutableDictionary alloc] init];
    [childBean setValue:@"decanins" forKey:@"username"];
    [childBean setValue:[@"888888a" md5] forKey:@"userpwd"];
    [childBean setValue:@"F11351A8B0D7483AEBCE6CBD7679F33A" forKey:@"userpwd"];
    [bean setValue:childBean forKey:@"user"];
    childBean = nil;
    
    [bean setValue:name forKey:@"username"];
    [bean setValue:pass forKey:@"password"];
    
    //该值时一个定值
    
    NSString *ServiceUrl = @"http://192.168.3.217:86/KCKP/restservices/kckpjcfsrest/";
    
    [[Globle getInstance].service requestWithServiceIP:ServiceUrl ServiceName:@"DecAnapplogin" params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
     
        NSString *str = [Util objectToJson:result];
        NSLog(@"%@",str);
        
    } ];
    
}



//隐藏状态栏
-(BOOL)prefersStatusBarHidden{
    return YES;
}


-(void)presentHomePage{
    
    UIStoryboard *s = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.view.window.rootViewController=[s instantiateInitialViewController];
    
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
