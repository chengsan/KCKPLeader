//
//  PhoneBindingViewController.m
//  KCKPLeader
//
//  Created by Siren on 15/11/25.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "PhoneBindingViewController.h"
#import "SettingViewController.h"
@interface PhoneBindingViewController ()<UITextFieldDelegate>
{
    //要修改的手机号
    NSString *phoneNum;
    NSString *code;
    NSString *userId;//用户id
    NSMutableDictionary *bean;
    NSMutableDictionary *childBean;
    NSMutableDictionary *getCodeBean;

    NSString *currentUserName;//已登录的用户名
    NSString *passWord;
    
    BOOL IsValid;
    MBProgressHUD *hud;
    NSTimer *timer;
    NSInteger seconds;

}
@end

@implementation PhoneBindingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [AppDelegate storyBoradAutoLay:self.view];
    seconds = 10;
    bean = [NSMutableDictionary dictionary];
    childBean = [NSMutableDictionary dictionary];
    getCodeBean = [NSMutableDictionary dictionary];
    currentUserName = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    passWord = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"tureid"];
    [bean setValue:currentUserName forKey:@"username"];
    [bean setValue:passWord forKey:@"password"];
    [childBean setValue:userId forKey:@"userid"];
    
    if ([self.title isEqualToString:@"换绑手机"]) {
        [self.confirmBtn setTitle:@"验证后绑定手机" forState:UIControlStateNormal];
        
    }
    else{
        [self.confirmBtn setTitle:@"确认绑定" forState:UIControlStateNormal];
    
    }
    self.confirmBtn.backgroundColor = NAVICOLOR;
    self.confirmBtn.layer.cornerRadius = 3;
    self.sengBtn.backgroundColor = NAVICOLOR;
    self.sengBtn.layer.cornerRadius = 3;
    [self.confirmBtn addTarget:self action:@selector(judgeCodeIsValid) forControlEvents:UIControlEventTouchUpInside];
    [self.sengBtn addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - 确认绑定
-(void)confirmBindingOrChanging{

    [self.phoneField resignFirstResponder];
    [self.codeField resignFirstResponder];

     NSLog(@"bean%@",bean);
    [[Globle getInstance].service requestWithServiceIP:ServiceURL ServiceName:@"DecAnModifyUser" params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {

        NSString *str = [Util objectToJson:result];
        NSLog(@"手机绑定%@",str);
        NSDictionary *dic = result;
        NSString *restate = [dic objectForKey:@"restate"];
        
        if ([restate isEqualToString:@"0"]) {
            
            [[NSUserDefaults standardUserDefaults] setValue:phoneNum forKey:@"phone"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            SettingViewController *vc = [SettingViewController new];
             [vc.tableView reloadData];
            vc.navigationItem.hidesBackButton = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
   
    
}

-(void)setTimer{
    
    if (timer == nil) {
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
    }
}

-(void)timerFireMethod:(NSTimer *)theTimer {
    if (seconds == 1) {
        [theTimer invalidate];
        self.sengBtn.backgroundColor = NAVICOLOR;
        self.sengBtn.userInteractionEnabled = YES;
        [self.sengBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        
    }else{
        seconds--;
        NSString *title = [NSString stringWithFormat:@"剩余%ld秒",seconds];
        self.sengBtn.backgroundColor = [UIColor grayColor];
        self.sengBtn.userInteractionEnabled = NO;
        [self.sengBtn setTitle:title forState:UIControlStateNormal];
    }
}

#pragma mark - 获取验证码
-(void)getCode{
    
    [self.codeField resignFirstResponder];
    [self.phoneField resignFirstResponder];
    [getCodeBean setValue:phoneNum forKey:@"phone"];
    [getCodeBean setValue:currentUserName forKey:@"username"];
    [getCodeBean setValue:passWord forKey:@"password"];
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"正在获取验证码";
    
    //判断手机号是否有效
    if ([Util isValidateMobile:_phoneField.text]) {
        
        self.sengBtn.backgroundColor = [UIColor grayColor];
        self.sengBtn.userInteractionEnabled = NO;
        [self setTimer];
        
        [[Globle getInstance].service requestWithServiceIP:ServiceURL ServiceName:@"DecAnAppSendVercode" params:getCodeBean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
            
            hud.labelText = @"获取成功";
            [hud hide:YES afterDelay:0];
            
            NSString *jsonStr = [Util objectToJson:result];
            NSLog(@"获取验证码%@",jsonStr);
            
        }];
    }
    else{
        hud.labelText = @"您输入的不是正确的手机号";
        hud.mode = MBProgressHUDModeText;
        [hud hide:YES afterDelay:3.0];
    }
    
}


#pragma mark - 判断验证码的有效性
-(void)judgeCodeIsValid{
    [self.codeField resignFirstResponder];
    [self.phoneField resignFirstResponder];
    
    NSMutableDictionary *judgeBean = [NSMutableDictionary dictionary];
    NSMutableDictionary *judgeChild = [NSMutableDictionary dictionary];
    [judgeChild setValue:phoneNum forKey:@"phone"];
    [judgeChild setValue:code forKey:@"validatecode"];
    
    [judgeBean setValue:judgeChild forKey:@"user"];
    [judgeBean setValue:currentUserName forKey:@"username"];
    [judgeBean setValue:passWord forKey:@"password"];
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"正在验证...";
    NSLog(@"JudgeBean%@",judgeBean);
    [[Globle getInstance].service requestWithServiceIP:ServiceURL ServiceName:@"DecAnAppValCode" params:judgeBean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        
        NSString *jsonStr = [Util objectToJson:result];
        NSLog(@"判断验证码%@",jsonStr);
        NSDictionary *dic = result;
        hud.mode = MBProgressHUDModeText;
        hud.labelText = [dic objectForKey:@"redes"];
        [hud hide:YES afterDelay:2.0];
        
        if ([[result objectForKey:@"restate"] isEqualToString:@"0"]) {
            IsValid = YES;
            [childBean setValue:userId forKey:@"userid"];
            [childBean setValue:phoneNum forKey:@"phone"];
            [bean setValue:childBean forKey:@"user"];
            [self confirmBindingOrChanging];
        }
        else{
            IsValid = NO;
        }
        
    }];
    
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - textField Delegate
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == _phoneField) {
        phoneNum = _phoneField.text;
    }
    else{
        code = _codeField.text;
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
