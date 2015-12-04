//
//  LoginViewController.m
//  KCKPLeader
//
//  Created by Siren on 15/11/26.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "LoginViewController.h"
#import "HomePageViewController.h"
#import "AppDelegate.h"
@interface LoginViewController ()<UITextFieldDelegate>
{
    //用户输入的用户名和密码
    NSString *userName;
    NSString *passWord;
    NSString *loginState;
    NSMutableDictionary *bean;
    MBProgressHUD *hud;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [AppDelegate storyBoradAutoLay:self.view];
    [NSThread sleepForTimeInterval:1.5];
    bean = [NSMutableDictionary dictionary];
    
//    userName = @"longrise";
//    passWord = [DESCript encrypt:@"888888a" encryptOrDecrypt:kCCEncrypt key:@"longstar"];
    
    // Do any additional setup after loading the view from its nib.
//    self.view.backgroundColor = NAVICOLOR;
//    self.navigationController.navigationBarHidden = YES;
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    self.navigationController.navigationBar.barTintColor = NAVICOLOR;
    self.navigationController.navigationBar.translucent = NO;
    [self.loginBtn addTarget:self action:@selector(presentHomePage) forControlEvents:UIControlEventTouchUpInside];
    self.loginBtn.backgroundColor = NAVICOLOR;
    self.loginBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.loginBtn.layer.borderWidth = 1.0;
    

}

//载入用户信息
-(void)loadData
{
    
    [[Globle getInstance].service requestWithServiceIP:ServiceURL ServiceName:@"DecAnapplogin" params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        
       
        if (result != nil) {
            NSString *str = [Util objectToJson:result];
            NSLog(@"JSONStr%@",str);
            NSDictionary *dic = result;
            loginState = [dic objectForKey:@"redes"];
            NSLog(@"state%@",loginState);
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            if ([loginState isEqualToString:@"登录成功"]) {
                
                hud.labelText = @"登录成功";
                [hud hide:YES afterDelay:1.0];
                NSDictionary *currentUser = [dic objectForKey:@"data"];
                NSString *currentUserName = [currentUser objectForKey:@"username"];
                NSString *currentPhoneNum = [currentUser objectForKey:@"phone"];
                NSString *currentUserId = [currentUser objectForKey:@"userid"];
                
                //防止没有手机号的用户导致程序崩溃
                if ([currentPhoneNum isKindOfClass:[NSString class]]) {
                    [userDefaults setValue:currentPhoneNum forKey:@"phone"];
                }
                
                [userDefaults setValue:currentUserName forKey:@"username"];
                [userDefaults setValue:passWord forKey:@"password"];
                [userDefaults setValue:loginState forKey:@"loginState"];
                [userDefaults setValue:currentUserId forKey:@"userid"];
                [userDefaults synchronize];
                
                UIStoryboard *s = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                self.view.window.rootViewController=[s instantiateInitialViewController];
            }
            else{
                    
                
                hud.labelText = @"用户名或密码错误";
                [hud hide:YES afterDelay:1.0];
                NSLog(@"用户名或密码错误");
                
                
            }
            
        }
        else{
            NSLog(@"返回数据为空");
        }

    } ];
    
}



//隐藏状态栏
//-(BOOL)prefersStatusBarHidden{
//    return YES;
//}


//验证用户名和密码是否正确，是则跳转到主页，否则提示用户
-(void)presentHomePage{
    
//    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self.passField resignFirstResponder];
    [self.userField resignFirstResponder];
    NSLog(@"%@",userName);
    NSLog(@"%@",passWord);
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if ([_userField.text isEqual:@""] || [_passField.text isEqual:@""]) {
        
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"用户名或密码为空";
        [hud hide:YES afterDelay:1.0];
    }
    
    else{
    
        passWord = [DESCript encrypt:passWord encryptOrDecrypt:kCCEncrypt key:@"longstar"];
        
        [bean setValue:userName forKey:@"username"];
        [bean setValue:passWord forKey:@"password"];
        hud.labelText = @"正在登录";
        [self loadData];
    
    }
    
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{

    
    if (textField == _userField) {
        userName = _userField.text;
    }
    else{
        passWord = _passField.text;
    }
    NSLog(@"ufield%@",userName);
    NSLog(@"pfield%@",passWord);

}

//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    CGRect frame = textField.frame;
    
    int offset;
    if (textField == _userField) {
        offset = frame.origin.y + 122 - (self.view.frame.size.height - 216.0);//键盘高度216
    }
    else{
        offset = frame.origin.y + 68 - (self.view.frame.size.height - 216.0);//键盘高度216
    }
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
//    if (ScreenHeight<568) {
        if(offset > 0)
            self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
//    }
    

    [UIView commitAnimations];
}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}




-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
//    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
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
