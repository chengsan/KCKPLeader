//
//  ProcessSituationViewController.m
//  EProcess
//
//  Created by Siren on 15/11/24.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import "ProcessSituationViewController.h"
#import "TrafficAccidentViewController.h"
#import "ClaimViewController.h"
#import "InsuranceViewController.h"
#import "NewTrafficViewController.h"
@interface ProcessSituationViewController ()
{
    NSArray *titleAry;
    NSArray *imgAry;
}
@end

@implementation ProcessSituationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"处理情况";
    titleAry = @[@"交通事故处理大队情况",@"理赔处理情况",@"保险公司处理情况",@"交通事故处理支队情况"];
    imgAry = @[@"ico01",@"ico02",@"ico03",@"ico4"];
    
    UINib *nib = [UINib nibWithNibName:@"ProcessSituationCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"ProcessSituationCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView代理

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ProcessSituationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProcessSituationCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.icon.image = [UIImage imageNamed:imgAry[indexPath.section]];
    cell.titleLab.text = titleAry[indexPath.section];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        NewTrafficViewController *newVC = [NewTrafficViewController new];
        newVC.titleStr = @"交通事故大队处理情况";
        [self presentViewController:newVC animated:YES completion:nil];
    }
    else if (indexPath.section == 1){
        ClaimViewController *vc = [ClaimViewController new];
        vc.title = titleAry[indexPath.section];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section == 2){
        InsuranceViewController *vc = [InsuranceViewController new];
        vc.title = titleAry[indexPath.section];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        NewTrafficViewController *newVC = [NewTrafficViewController new];
        newVC.titleStr = @"交通事故支队处理情况";
        [self presentViewController:newVC animated:YES completion:nil];
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
