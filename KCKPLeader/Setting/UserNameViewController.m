//
//  UserNameViewController.m
//  KCKPLeader
//
//  Created by Siren on 15/11/25.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "UserNameViewController.h"

@interface UserNameViewController ()<UITextFieldDelegate>
{
    NSString *changedUserName;//要修改的用户名
    NSMutableDictionary *bean;
    NSMutableDictionary *childBean;
    NSString *currentUserName;//已登录的用户名
    NSString *passWord;
    NSString *userId;//用户id
    
}
@end

@implementation UserNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    bean = [NSMutableDictionary dictionary];
    childBean = [[NSMutableDictionary alloc] init];
    currentUserName = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    passWord = [[NSUserDefaults standardUserDefaults] objectForKey:@"useid"];
    userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"tureid"];
    NSLog(@"%@",currentUserName);
    NSLog(@"%@",userId);
    [childBean setValue:userId forKey:@"userid"];
    
    [bean setValue:currentUserName forKey:@"username"];
    [bean setValue:passWord forKey:@"password"];
    
    self.confirmBtn.backgroundColor = NAVICOLOR;
    [self.confirmBtn addTarget:self action:@selector(confirmChanged) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)confirmChanged{
    
    [self.userField resignFirstResponder];

    NSLog(@"输入的：%@",changedUserName);
    [childBean setValue:changedUserName forKey:@"username"];
    [bean setValue:childBean forKey:@"user"];
    NSLog(@"BEAN%@",bean);
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
//    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.labelText = @"正在提交";
    [[Globle getInstance].service requestWithServiceIP:ServiceURL ServiceName:@"DecAnModifyUser" params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        
        NSDictionary *dic = result;
        NSString *restate = [dic objectForKey:@"restate"];
        NSString *jsonStr = [Util objectToJson:result];
        NSLog(@"JSONSTR  %@",jsonStr);
        if ([restate isEqualToString:@"0"] && ![_userField.text  isEqual: @""]) {
            hud.labelText = @"修改成功";
            [hud hide:YES afterDelay:1.0];
            [[NSUserDefaults standardUserDefaults] setValue:changedUserName forKey:@"username"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        else{
            hud.labelText = @"修改失败";
            hud.mode = MBProgressHUDModeIndeterminate;
            [hud hide:YES afterDelay:1.0];
        }
        
//        /** Progress is shown using an UIActivityIndicatorView. This is the default. */
//        MBProgressHUDModeIndeterminate,
//        /** Progress is shown using a round, pie-chart like, progress view. */
//        MBProgressHUDModeDeterminate,
//        /** Progress is shown using a horizontal progress bar */
//        MBProgressHUDModeDeterminateHorizontalBar,
//        /** Progress is shown using a ring-shaped progress view. */
//        MBProgressHUDModeAnnularDeterminate,
//        /** Shows a custom view */
//        MBProgressHUDModeCustomView,
//        /** Shows only labels */
//        MBProgressHUDModeText
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    changedUserName = self.userField.text;
    
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
