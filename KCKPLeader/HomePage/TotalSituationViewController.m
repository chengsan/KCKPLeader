//
//  TotalSituationViewController.m
//  KCKPLeader
//
//  Created by Siren on 15/11/26.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "TotalSituationViewController.h"
#import "ClaimViewController.h"
@interface TotalSituationViewController ()
@property(nonatomic,retain)NSMutableArray *data;//数据源
@property(nonatomic,retain)NSMutableDictionary *exp;//是否展开
@end

@implementation TotalSituationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
    self.data=[NSMutableArray array];
    for (int i=0; i<3; i++) {
        NSString *str=[NSString stringWithFormat:@"it-%zi",i];
        [self.data addObject:str];
    }
    self.exp=[NSMutableDictionary dictionary];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)click:(UIButton *)btn{
    
    NSString *indexSection=[NSString stringWithFormat:@"%zi",btn.tag];
    if ([self.exp objectForKey:indexSection]) {//如果有这个section
        
        BOOL b=[[self.exp objectForKey:indexSection] boolValue];
        [self.exp removeAllObjects];
        if(b){
            [ self.exp setObject:[NSNumber numberWithBool:NO] forKey:indexSection];
        }
        else {
            [ self.exp setObject:[NSNumber numberWithBool:YES] forKey:indexSection];
        }
        
    }
    else{
        [self.exp removeAllObjects];
        [self.exp setObject:[NSNumber numberWithBool:YES] forKey:indexSection];
    }
    //    NSIndexSet *indexset=[NSIndexSet indexSetWithIndex:btn.tag];
    
    //    [_tableview reloadSections:indexset withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView reloadData];
}

-(void)btnOfSectionTreeClick{
    ClaimViewController *vc = [ClaimViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - table Delegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //判断分组是否展开，展开则返回真实数据，否则返回0
    NSString *indexsection=[NSString stringWithFormat:@"%zi",section];
    BOOL b=[[self.exp objectForKey:indexsection] boolValue];
    if ([self.exp objectForKey:indexsection] && b) {
        return self.data.count;
    }
    return 0;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    static NSString *cellIdentify=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%zi",indexPath.row];
    
    return cell;
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSArray *titleAry = @[@"发生事故总数",@"122报警量",@"APP处理案件总数",@"本周保险公司理赔次数"];
    NSArray *numAry = @[@"10000次",@"8000次",@"16起",@"68次"];
    NSArray *iconAry = @[@"icon025",@"icon026",@"icon027",@"sign"];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, ScreenWidth, 60);
    btn.backgroundColor = [UIColor clearColor];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(btn.frame)-5, ScreenWidth, 5)];
    lab.backgroundColor = RGBA(235, 235, 241, 1.0);
    [btn addSubview:lab];
    btn.tag=section;
    
    SectionView *view = [[NSBundle mainBundle] loadNibNamed:@"SectionView" owner:nil options:nil][0];
    view.frame = btn.bounds;
    view.icon.image = [UIImage imageNamed:iconAry[section]];
    view.titleLab.text = titleAry[section];
    view.count.text = numAry[section];
    [view addSubview:btn];
    
    if (section == 3) {
        [btn addTarget:self action:@selector(btnOfSectionTreeClick) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *rightIcon = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-30, 15, 22, 30)];
        rightIcon.image = [UIImage imageNamed:@"next"];
        [view addSubview:rightIcon];
    }
    else{
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 60;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
