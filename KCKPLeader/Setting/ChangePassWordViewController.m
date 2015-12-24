//
//  ChangePassWordViewController.m
//  KCKPLeader
//
//  Created by Siren on 15/11/26.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "ChangePassWordViewController.h"

@interface ChangePassWordViewController ()<UITextFieldDelegate>
{
    NSString *inputOld;
    NSString *inputNew;
    NSString *repeatPass;
    NSString *userId;//用户id
    NSMutableDictionary *bean;
    NSMutableDictionary *childBean;
    
    NSString *currentUserName;//已登录的用户名
    NSString *passWord;
}

@end

@implementation ChangePassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [AppDelegate storyBoradAutoLay:self.view];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.confirmBtn.backgroundColor = NAVICOLOR;
    self.confirmBtn.layer.cornerRadius = 3;
    [self.confirmBtn addTarget:self action:@selector(confirmChanged) forControlEvents:UIControlEventTouchUpInside];
//    oripwd
    bean = [NSMutableDictionary dictionary];
    childBean = [NSMutableDictionary dictionary];
    currentUserName = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    //加密的用户id
    passWord = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"tureid"];
    NSString *realPass = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    
    [bean setValue:currentUserName forKey:@"username"];
    [bean setValue:passWord forKey:@"password"];
    [childBean setValue:userId forKey:@"userid"];
    [childBean setValue:realPass forKey:@"oripwd"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 修改密码
-(void)confirmChanged{
    
    [self.view endEditing:YES];
    
    NSString *oldpwd = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    NSLog(@"oldpwd%@",oldpwd);
    
    NSString *oldInput  = [DESCript encrypt:inputOld encryptOrDecrypt:kCCEncrypt key:@"longstar"];
    NSLog(@"inputOld%@",oldInput);
    if ([oldpwd isEqual:oldInput]) {
        if ([inputNew isEqualToString:repeatPass]) {
            inputNew  = [DESCript encrypt:inputNew encryptOrDecrypt:kCCEncrypt key:@"longstar"];
            [childBean setValue:inputNew forKey:@"userpwd"];
            [bean setValue:childBean forKey:@"user"];
            
        }
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"正在提交...";
    NSLog(@"bean%@",bean);
    [[Globle getInstance].service requestWithServiceIP:ServiceURL ServiceName:@"DecAnModifyUser" params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        NSString *str = [Util objectToJson:result];
        NSLog(@"手机绑定%@",str);
        NSDictionary *dic = result;
        NSString *restate = [dic objectForKey:@"restate"];
        if ([restate isEqualToString:@"0"]) {
            
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"修改成功";
            [hud hide:YES afterDelay:1.0];
            [[NSUserDefaults standardUserDefaults] setValue:inputNew forKey:@"password"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            UIStoryboard *loginStoryboard=[UIStoryboard storyboardWithName:@"Login" bundle:nil];
            [self presentViewController:[loginStoryboard instantiateInitialViewController] animated:YES completion:nil];
        }
        
        else{
            
            if ([inputNew isEqual:repeatPass]) {
                
                NSString *realPass = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
                if ([oldInput isEqual:realPass]) {
                    hud.mode = MBProgressHUDModeText;
                    hud.labelText = @"修改失败";
                }
                else{
                    hud.mode = MBProgressHUDModeText;
                    hud.labelText = @"原密码输入错误";

                }
                
            }
            else{
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"2次输入的密码不一致";
            }
            
            [hud hide:YES afterDelay:1.0];
        }
    }];
}


#pragma mark - textField Delegate
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField == _passOld) {
        inputOld = self.passOld.text;
        NSLog(@"old%@",inputOld);
    }
    else if (textField == _passNew){
        inputNew = self.passNew.text;
         NSLog(@"new%@",inputNew);
    }
    else{
        repeatPass = self.repeatNew.text;
        NSLog(@"repeat%@",repeatPass);
    }
    
    
    
    
    
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
