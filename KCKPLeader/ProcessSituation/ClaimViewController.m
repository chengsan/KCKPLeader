//
//  ClaimViewController.m
//  KCKPLeader
//
//  Created by Siren on 15/11/25.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "ClaimViewController.h"
#import "ClaimSituationCellCell.h"
#import "ClaimModel.h"
@interface ClaimViewController ()
{

    NSString *userName;
    NSString *passWord;
    NSMutableDictionary *bean;
    ClaimModel *model;

}
@end

@implementation ClaimViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    bean = [NSMutableDictionary dictionary];
    userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    passWord = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    [bean setValue:userName forKey:@"username"];
    [bean setValue:passWord forKey:@"password"];
    
    self.title = @"理赔处理情况";
    UINib *nib = [UINib nibWithNibName:@"ClaimSituationCellCell" bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:@"ClaimSituationCellCell"];
    
    [self loadClaimData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 加载理赔处理情况数据
-(void)loadClaimData{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[Globle getInstance].service requestWithServiceIP:ServiceURL ServiceName:@"DecAncpsinfo" params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (result != nil) {
            NSString *jsonStr = [Util objectToJson:result];
            NSLog(@"Detachment:%@",jsonStr);
            
            model = [[ClaimModel alloc]initWithString:jsonStr error:nil];

            [self.tableView reloadData];
        }
        else{
            NSLog(@"数据为空");
        }
        
    }];
    
}

#pragma mark - table Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *imgAry = @[@"ico08",@"ico09",@"ico10",@"ico12"];
    NSArray *titleAry = @[@"拍照",@"定责",@"保险报案",@"结案"];
    ClaimSituationCellCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClaimSituationCellCell"];
    cell.icon.image = [UIImage imageNamed:imgAry[indexPath.section]];
    cell.titleLab.text = titleAry[indexPath.section];
    switch (indexPath.section) {
        case 0:
            [cell setPicUIWithInfo:model];
            break;
        case 1:
            [cell setDutUIWithInfo:model];
            break;
        case 2:
            [cell setInsUIWithInfo:model];
            break;
        case 3:
            [cell setCpsUIWithInfo:model];
            break;
        default:
            break;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.0;
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
