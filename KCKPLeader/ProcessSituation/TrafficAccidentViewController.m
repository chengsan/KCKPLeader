//
//  TrafficAccidentViewController.m
//  KCKPLeader
//
//  Created by Siren on 15/11/25.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "TrafficAccidentViewController.h"
#import "DetachmentModel.h"
#import "CaseTableViewCell.h"
@interface TrafficAccidentViewController ()
{

    NSString *userName;
    NSString *passWord;
    NSMutableDictionary *bean;
    NSMutableDictionary *detailBean;
    SectionView *view;
    DetachmentModel *model;//支队model
    CaseModel *detailModel;//支队详情model
    NSString *groupCode;
    NSMutableArray *detailData;
    
    NSInteger index;
    
}
@property(nonatomic,retain)NSMutableArray *data;//数据源
@property(nonatomic,retain)NSMutableDictionary *exp;//是否展开
@end

@implementation TrafficAccidentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"点击某个支队展开支队详情，点击今天和截止昨天查看最新数据" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
    
    bean = [NSMutableDictionary dictionary];
    self.data=[NSMutableArray array];
    detailData = [NSMutableArray array];
    self.exp=[NSMutableDictionary dictionary];
    
    userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    passWord = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    
    [bean setValue:userName forKey:@"username"];
    [bean setValue:passWord forKey:@"password"];
    NSLog(@"code%@",groupCode);
    
    detailBean = [NSMutableDictionary dictionaryWithDictionary:bean];
    
    [self loadDetachmentData];
    
    UINib *nib;
    if (ScreenWidth<375) {
        nib = [UINib nibWithNibName:@"CaseTableViewCell" bundle:nil];
        
    }
    else{
        nib = [UINib nibWithNibName:@"CaseTableViewCell6" bundle:nil];
    }
    
    self.tableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-64);
    [self.tableView registerNib:nib forCellReuseIdentifier:@"CaseTableViewCell"] ;
    
    
}

#pragma mark - 加载北京区域支队数据
-(void)loadDetachmentData{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[Globle getInstance].service requestWithServiceIP:ServiceURL ServiceName:@"DecAnArea" params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (result != nil) {
            NSString *jsonStr = [Util objectToJson:result];
//            NSLog(@"Detachment:%@",jsonStr);
            
            model = [[DetachmentModel alloc]initWithString:jsonStr error:nil];
            for (DetDataModel *data in model.data) {
                
                [self.data addObject:data];
            }
//
            [self.tableView reloadData];
        }
        else{
            NSLog(@"数据为空");
        }
        
    }];
    
}

#pragma mark - 加载区域支队详细信息
-(void)loadDetailDataWithType:(NSString *)type{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [detailBean setValue:type forKey:@"type"];
    detailModel = nil;
    [self.tableView reloadData];
    NSLog(@"detailBean%@",detailBean);
    [[Globle getInstance].service requestWithServiceIP:ServiceURL ServiceName:@"DecAnAreainfo" params:detailBean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result != nil) {
            NSString *jsonStr = [Util objectToJson:result];
            NSLog(@"Detail:%@",jsonStr);
            
            detailModel = [[CaseModel alloc]initWithString:jsonStr error:nil];

            [self.tableView reloadData];
        }
        else{
            NSLog(@"数据为空");
        }
        
    }];
    
}

-(void)loadYesterdayData{
    detailModel = nil;
    [self loadDetailDataWithType:@"2"];
}

-(void)loadTodayData{
    detailModel = nil;
    [self loadDetailDataWithType:@"1"];
}


#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 点击section上的Btn
-(void)click:(UIButton *)btn{
    
    NSLog(@"section被点击");
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:btn.tag];
    CaseTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    NSString *indexSection=[NSString stringWithFormat:@"%zi",btn.tag];
    DetDataModel *dataMod = model.data[btn.tag];
    NSLog(@"%@",dataMod.groupcode);
    [detailBean setValue:dataMod.groupcode forKey:@"groupcode"];

    if ([self.exp objectForKey:indexSection]) {
    
        BOOL b=[[self.exp objectForKey:indexSection] boolValue];
        [self.exp removeAllObjects];
        detailModel = nil;
        [self.tableView reloadData];
    
        if(b){
            detailModel = nil;
            
            [self.tableView reloadData];
            
            [ self.exp setObject:[NSNumber numberWithBool:NO] forKey:indexSection];
            NSLog(@"section关闭");
        }
        else {
            
            detailModel = nil;
            [self.tableView reloadData];
            
            [ self.exp setObject:[NSNumber numberWithBool:YES] forKey:indexSection];
            NSLog(@"secton展开");
            
        }
        
    }
    else{
        
        detailModel = nil;
        [self.exp removeAllObjects];
        [self.exp setObject:[NSNumber numberWithBool:YES] forKey:indexSection];
    }

    //    NSIndexSet *indexset=[NSIndexSet indexSetWithIndex:btn.tag];
    //    [_tableview reloadSections:indexset withRowAnimation:UITableViewRowAnimationFade];
    
    cell.todayBtn.backgroundColor = NAVICOLOR;
    [cell.todayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cell.untilYesterdayBtn.backgroundColor = [UIColor whiteColor];
    [cell.untilYesterdayBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    [self.tableView reloadData];
    
}


#pragma mark - table Delegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.data.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //判断分组是否展开，展开则返回真实数据，否则返回0
    NSString *indexsection=[NSString stringWithFormat:@"%zi",section];
    BOOL b=[[self.exp objectForKey:indexsection] boolValue];
    if ([self.exp objectForKey:indexsection] && b) {
        
        return 1;
    }
    return 0;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CaseTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CaseTableViewCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    index = indexPath.section;

    
    [cell setUIWithInfo:detailModel];
    
    UIButton *todayBtn = [cell viewWithTag:101];
    [todayBtn addTarget:self action:@selector(loadTodayData) forControlEvents:UIControlEventTouchUpInside];
//    todayBtn.backgroundColor = NAVICOLOR;
//    [todayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIButton *yestodayBtn = [cell viewWithTag:102];
    [yestodayBtn addTarget:self action:@selector(loadYesterdayData) forControlEvents:UIControlEventTouchUpInside];
//    yestodayBtn .backgroundColor = [UIColor whiteColor];
//    [yestodayBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    
    return cell;
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSArray *iconAry = @[@"ico04",@"ico05",@"ico06",@"ico07"];
    DetDataModel *dataModel = self.data[section];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, ScreenWidth, 60);
    btn.backgroundColor = [UIColor clearColor];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(btn.frame)-5, ScreenWidth, 5)];
    lab.backgroundColor = RGBA(235, 235, 241, 1.0);
    [btn addSubview:lab];
    btn.tag=section;
    
    view = [[NSBundle mainBundle] loadNibNamed:@"SectionView" owner:nil options:nil][0];
    view.frame = btn.bounds;
    view.icon.image = [UIImage imageNamed:iconAry[section%4]];
    view.titleLab.text = dataModel.groupname;
    view.count.hidden = YES;
    [view addSubview:btn];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 60;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 230;
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
