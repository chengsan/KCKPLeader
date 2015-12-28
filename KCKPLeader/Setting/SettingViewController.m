//
//  SettingViewController.m
//  EProcess
//
//  Created by Siren on 15/11/24.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingTableViewCell.h"
#import "UserNameViewController.h"
#import "PhoneBindingViewController.h"
#import "ChangePassWordViewController.h"
#import "LoginViewController.h"
@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"设置";
    
    UINib *nib = [UINib nibWithNibName:@"SettingTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"SettingTableViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 2;
            break;
        default:
            break;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (!(indexPath.section == 0 && indexPath.row == 1)) {
        cell.phoneLab.hidden = YES;
    }
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.icon.image = [UIImage imageNamed:@"nicon07"];
            cell.titleLab.text = @"用户名";
            NSString *currentUserName = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
//            NSLog(@"%@",currentUserName);
            cell.rightLab.text = currentUserName;
            cell.rightLab.textColor = [UIColor grayColor];
        }
        else if (indexPath.row == 1) {
            cell.icon.image = [UIImage imageNamed:@"nicon08"];
            cell.titleLab.text = @"手机";
            
            NSString *currentPhoneNum;
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"phone"] isKindOfClass:[NSString class]]) {
                
                currentPhoneNum = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
                
            }
            
            //隐藏手机号中间4位
            NSMutableString *hideNum = [NSMutableString stringWithString:currentPhoneNum];
            NSRange range = {3,4};
            //判断用户是否有手机号，没有则不进行操作，防止程序在用户没有绑定手机号的时候崩溃
            if (currentPhoneNum.length == 11) {
                [hideNum replaceCharactersInRange:range withString:@"****"];
                cell.phoneLab.text = hideNum;
                cell.phoneLab.textColor = [UIColor grayColor];
                cell.rightLab.text = @"修改";
                cell.rightLab.textColor = NAVICOLOR;
            }
            
        }
        else {
            cell.icon.image = [UIImage imageNamed:@"nicon09"];
            cell.titleLab.text = @"登录密码";
            cell.rightLab.text = @"修改";
            cell.rightLab.textColor = NAVICOLOR;
        }
    }
    
    else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.icon.image = [UIImage imageNamed:@"nicon10"];
            cell.titleLab.text = @"清除缓存";
            
        }
        else{
            cell.icon.image = [UIImage imageNamed:@"nicon11"];
            cell.titleLab.text = @"退出登录";
        }
        cell.rightLab.textColor = [UIColor clearColor];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 49;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        UIViewController *vc;
        if (indexPath.row == 0) {
//            vc = [UserNameViewController new];
//            vc.title = @"用户名";
            return;
        }
        else if (indexPath.row == 1){
            vc = (PhoneBindingViewController *)[PhoneBindingViewController new];
            vc.title = @"绑定手机";
            
        }
        else{
            vc = [ChangePassWordViewController new];
            vc.title = @"修改密码";
        }
        
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        
        if (indexPath.row == 0) {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"清除成功" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            
            
        }
        else{
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.labelText = @"正在退出";
            BOOL isrem = 0;
            BOOL islog = 0;
            [[NSUserDefaults standardUserDefaults] setBool:isrem forKey:@"isrem"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [[NSUserDefaults standardUserDefaults] setBool:islog forKey:@"islog"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            UIStoryboard *loginStoryboard=[UIStoryboard storyboardWithName:@"Login" bundle:nil];
            [self presentViewController:[loginStoryboard instantiateInitialViewController] animated:YES completion:nil];
        }
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
