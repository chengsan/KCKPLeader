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
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.icon.image = [UIImage imageNamed:@"ico20"];
            cell.titleLab.text = @"用户名";
            
            cell.rightLab.text = @"Longrise";
            cell.rightLab.textColor = [UIColor grayColor];
        }
        else if (indexPath.row == 1) {
            cell.icon.image = [UIImage imageNamed:@"ico21"];
            cell.titleLab.text = @"手机";
            cell.rightLab.text = @"13888888888";
            cell.rightLab.textColor = [UIColor grayColor];
        }
        else {
            cell.icon.image = [UIImage imageNamed:@"ico22"];
            cell.titleLab.text = @"登录密码";
            cell.rightLab.text = @"修改";
            cell.rightLab.textColor = NAVICOLOR;
        }
    }
    else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.icon.image = [UIImage imageNamed:@"ico23"];
            cell.titleLab.text = @"清除缓存";
            
        }
        else{
            cell.icon.image = [UIImage imageNamed:@"ico24"];
            cell.titleLab.text = @"退出登录";
        }
        cell.rightLab.textColor = [UIColor clearColor];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    SettingTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        UIViewController *vc;
        if (indexPath.row == 0) {
            vc = [UserNameViewController new];
            vc.title = @"用户名";
        }
        else if (indexPath.row == 1){
            vc = (PhoneBindingViewController *)[PhoneBindingViewController new];
            if ([cell.rightLab.text isEqualToString:@""]) {
                vc.title = @"绑定手机";
            }
            else{
                vc.title = @"换绑手机";
            }
        }
        else{
            vc = [ChangePassWordViewController new];
            vc.title = @"修改密码";
        }
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        
        if (indexPath.row == 0) {
            
        }
        else{
            
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
