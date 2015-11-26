//
//  DecisionAnalysisViewController.m
//  EProcess
//
//  Created by Siren on 15/11/24.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import "DecisionAnalysisViewController.h"
#import "PlaceViewController.h"
#import "TimeViewController.h"
#import "CircumstancesViewController.h"
@interface DecisionAnalysisViewController ()
{
    NSArray *titleAry;
    NSArray *imgAry;
}
@end

@implementation DecisionAnalysisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"决策分析";
    titleAry = @[@"事故地点分析",@"事故时间分析",@"事故情形分析"];
    imgAry = @[@"ico17",@"ico18",@"ico19"];
    
    UINib *nib = [UINib nibWithNibName:@"ProcessSituationCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"ProcessSituationCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView代理

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
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
    
    UIViewController *vc;
    if (indexPath.section == 0) {
        vc = [PlaceViewController new];
    }
    else if (indexPath.section == 1){
        vc = [TimeViewController new];
    }
    else{
        vc = [CircumstancesViewController new];
    }
    vc.title = titleAry[indexPath.section];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
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
