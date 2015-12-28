//
//  HomePageViewController.m
//  EProcess
//
//  Created by Siren on 15/11/24.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import "HomePageViewController.h"
#import "CaseTableViewCell.h"
#import "TotalTableViewCell.h"
#import "TotalSituationViewController.h"
#import "CustomView.h"
#import "CaseModel.h"
#import "ScrollModel.h"
#import "AppModel.h"
#import "ClaimTotalCell.h"
#import "InsuranceViewController.h"
#import "AppVerModel.h"
#import "DownloadsTableViewCell.h"
#import "APPDataShowView.h"
#import "HeaderView.h"
@interface HomePageViewController ()<UIScrollViewDelegate>

{
    NSString *userName;
    NSString *passWord;
    NSMutableDictionary *bean;

   

    
    NSNumber *totlaCount;
    AppVerModel *verModel;
    NSString *localVersion;
    NSString *serverVersion;
    NSString *remark;
}

@property (nonatomic, strong) HMSegmentedControl *segmentControl;
@property (nonatomic, strong) HMSegmentedControl *segmentControl1;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIScrollView *scrollView1;
@property (nonatomic, strong) CaseModel *model;
@property (nonatomic, strong) ScrollModel *scrModel;
@property (nonatomic, strong) AppModel *appModel;
@property (nonatomic, strong) UIAlertView *alertView;

@end

@implementation HomePageViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"概述";
    userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    passWord = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    bean = [[NSMutableDictionary alloc]init];
    NSLog(@"用户名%@",userName);
    NSLog(@"密码%@",passWord);
    [bean setValue:userName forKey:@"username"];
    [bean setValue:passWord forKey:@"password"];
    
    [self initTable];
    
    
    
    
    
//    [self loadScrolData];
    
//    [self loadCaseDataWithType1];
    
//    [self loadAppData];
    
//    [self loadClaimToalCountData];
    
    [self checkVersion];
    
}

#pragma mark - APP初始化segment
-(void)initAPPSegment:(UITableViewCell *)cell
{
    
    _segmentControl = [[HMSegmentedControl alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    _segmentControl.sectionTitles = @[@"今日",@"截止到昨天"];
    _segmentControl.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:15]};
    _segmentControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : NAVICOLOR};
    _segmentControl.selectionIndicatorColor = NAVICOLOR;
    _segmentControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    _segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _segmentControl.selectionIndicatorHeight = 2.0;
    [cell addSubview:_segmentControl];
    __weak typeof(self) weakSelf = self;
    [self.segmentControl setIndexChangeBlock:^(NSInteger index) {
        
        [weakSelf.scrollView scrollRectToVisible:CGRectMake(ScreenWidth * index, 0, weakSelf.view.frame.size.width, 240) animated:YES];
        
    }];
}

#pragma mark - APP初始化scrollView
-(void)initAPPScrollView:(UITableViewCell *)cell
{
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_segmentControl.frame), ScreenWidth, 240)];
    self.scrollView.contentSize = CGSizeMake(ScreenWidth * 2, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.bounces = NO;
    [cell addSubview:self.scrollView];
    
    NSArray *ietms = [[NSBundle mainBundle]loadNibNamed:@"APPDataShowView" owner:self options:nil];
    UIView *cus1 = [ietms lastObject];
    cus1.frame = self.scrollView.bounds;
    [self.scrollView addSubview:cus1];
    
    NSArray *ietms1 = [[NSBundle mainBundle]loadNibNamed:@"APPDataShowView" owner:self options:nil];
    UIView *cus2 = [ietms1 lastObject];
    cus2.frame = CGRectMake(ScreenWidth, 0, ScreenWidth, _scrollView.frame.size.height);
    [self.scrollView addSubview:cus2];
    
    
    NSLog(@"SCRW%f",ScreenWidth);
    NSLog(@"SCRH%f",ScreenHeight);
}

#pragma mark - 处理时效初始化segment
-(void)saveAPPSegment:(UITableViewCell *)cell
{
    
    _segmentControl1 = [[HMSegmentedControl alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    _segmentControl1.sectionTitles = @[@"拍照平均时间",@"责任平均认定时间",@"整体平均时间"];
    _segmentControl1.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:15]};
    _segmentControl1.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : NAVICOLOR};
    _segmentControl1.selectionIndicatorColor = NAVICOLOR;
    _segmentControl1.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    _segmentControl1.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _segmentControl1.selectionIndicatorHeight = 2.0;
    [cell addSubview:_segmentControl1];
    __weak typeof(self) weakSelf = self;
    [self.segmentControl1 setIndexChangeBlock:^(NSInteger index) {
        
        [weakSelf.scrollView1 scrollRectToVisible:CGRectMake(ScreenWidth * index, 0, weakSelf.view.frame.size.width, 180) animated:YES];
        
    }];
}

#pragma mark - 处理时效初始化scrollView
-(void)saveScrollView:(UITableViewCell *)cell
{
    
    self.scrollView1 = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_segmentControl1.frame), ScreenWidth, 180)];
    self.scrollView1.contentSize = CGSizeMake(ScreenWidth * 3, 0);
    self.scrollView1.pagingEnabled = YES;
    self.scrollView1.showsVerticalScrollIndicator = NO;
    self.scrollView1.showsHorizontalScrollIndicator = NO;
    self.scrollView1.delegate = self;
    self.scrollView1.bounces = NO;
    [cell addSubview:self.scrollView1];
    
    NSArray *ietms = [[NSBundle mainBundle]loadNibNamed:@"SaveCaseTimeView" owner:self options:nil];
    UIView *cus1 = [ietms lastObject];
    cus1.frame = self.scrollView1.bounds;
    [self.scrollView1 addSubview:cus1];
    
    NSArray *ietms1 = [[NSBundle mainBundle]loadNibNamed:@"SaveCaseTimeView" owner:self options:nil];
    UIView *cus2 = [ietms1 lastObject];
    cus2.frame = CGRectMake(ScreenWidth, 0, ScreenWidth, _scrollView1.frame.size.height);
    [self.scrollView1 addSubview:cus2];
    
    NSArray *ietms2 = [[NSBundle mainBundle]loadNibNamed:@"SaveCaseTimeView" owner:self options:nil];
    UIView *cus3 = [ietms2 lastObject];
    cus3.frame = CGRectMake(ScreenWidth*2, 0, ScreenWidth, _scrollView1.frame.size.height);
    [self.scrollView1 addSubview:cus3];
    
    
    //下面的View
    NSArray *ietms3 = [[NSBundle mainBundle]loadNibNamed:@"SaveCaseBottomView" owner:self options:nil];
    UIView *cus4 = [ietms3 lastObject];
    cus4.frame = CGRectMake(0, CGRectGetMaxY(_scrollView1.frame), ScreenWidth, 160);
    [cell addSubview:cus4];
    NSLog(@"SCRW%f",ScreenWidth);
    NSLog(@"SCRH%f",ScreenHeight);
}


#pragma mark - 初始化taibleView
-(void)initTable{
    
    self.tableView.bounces = NO;
    [self.view addSubview:self.tableView];
    
    UINib *downNib = [UINib nibWithNibName:@"DownloadsTableViewCell" bundle:nil];
    [self.tableView registerNib:downNib forCellReuseIdentifier:@"DownloadsTableViewCell"];
    
//    UINib *totalNib = [UINib nibWithNibName:@"TotalTableViewCell" bundle:nil];
//    [self.tableView registerNib:totalNib forCellReuseIdentifier:@"TotalTableViewCell"];
//    UINib *nib = [UINib nibWithNibName:@"ClaimTotalCell" bundle:nil];
//    [self.tableView registerNib:nib forCellReuseIdentifier:@"ClaimTotalCell"];
//    
////    if (ScreenWidth == 320) {
//    
//        UINib *caseNib = [UINib nibWithNibName:@"CaseTableViewCell" bundle:nil];
//        [self.tableView registerNib:caseNib forCellReuseIdentifier:@"CaseTableViewCell"];
//    }
    
//    else{
//    
//        UINib *nib = [UINib nibWithNibName:@"CaseTableViewCell6" bundle:nil];
//        [self.tableView registerNib:nib forCellReuseIdentifier:@"CaseTableViewCell"];
//    }

}

#pragma mark - 跳转事件总体情况页
-(void)jumpToTotalSituation{
    
    NSLog(@"按钮点击");
    TotalSituationViewController *vc = [TotalSituationViewController new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - 检测版本更新
-(void)checkVersion{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:@"KCKP_Leader" forKey:@"arg1"];

//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.labelText = @"正在检查更新...";
    
    [[Globle getInstance].service requestWithServiceIP:UpdateURL ServiceName:@"lbcp_getAppVersion" params:params httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {

//        [hud hide:YES afterDelay:1.0];
        
        if (nil != result) {
            NSString *jsonStr = [Util objectToJson:result];
            NSLog(@"版本检测%@",jsonStr);
            verModel = [[AppVerModel alloc]initWithString:jsonStr error:nil];
//            verModel.appversion;
//            verModel.upgrade
//            verModel.remarks
            remark = verModel.remarks;

            localVersion = VersionCode;
            NSLog(@"当前版本号%@",verModel.appversion);
            int localVersionNUm = (localVersion == nil ? -1 : [localVersion intValue]);
            
            //获取服务器版本
            serverVersion = verModel.appversion;
            int serverVersionNum = (serverVersion == nil ? -1 : [serverVersion intValue]);
            //判断是非升级
            if(localVersionNUm < serverVersionNum)
            {
                NSString *upgrade = verModel.upgrade;
                if([@"1" isEqualToString:upgrade])    //   强制升级
                {
                    self.alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"有新的版本，请及时更新。" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                }
                else     //  自选升级
                {
                    self.alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"有新的版本，请及时更新。" delegate:self cancelButtonTitle: nil otherButtonTitles:@"确定",@"取消",nil];
                }
                [self.alertView show];

            }else{
            
            }
        }

    }];
    
}

#pragma mark - UIAlertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView == self.alertView)
    {
        if(buttonIndex == 0)
        {
    
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:remark]];
            
        }
        
        //        long oldTime = (long)[Util getValue:@"systemTime"];
        //        oldTime = oldTime + 24*60*60*1000;
        //        [Util setObject:[[NSNumber alloc] initWithLong:oldTime] key:@"systemTime"];
    }
}

#pragma mark - 加载顶部scroll数据
-(void)loadScrolData{

//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[Globle getInstance].service requestWithServiceIP:ServiceURL ServiceName:@"DecAnSearchdayweekmonth" params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if (result != nil) {
            NSString *jsonStr = [Util objectToJson:result];
            NSLog(@"result:%@",jsonStr);
            self.scrModel = [[ScrollModel alloc]initWithString:jsonStr error:nil];
//            NSLog(@"week%@",self.scrModel.data.weeave);
//            cus1.todayLab.text = FORMATSTR (_scrModel.data.dayave);
//            cus1.weekLab.text  = FORMATSTR (_scrModel.data.weeave) ;
//            cus1.monthLab.text = FORMATSTR (_scrModel.data.monave);
//            
//            cus2.todayLab.text = FORMATSTR (_scrModel.data.voldayave);
//            cus2.weekLab.text  = FORMATSTR (_scrModel.data.volweeave);
//            cus2.monthLab.text = FORMATSTR (_scrModel.data.volmonave);
//
//            cus3.todayLab.text = FORMATSTR (_scrModel.data.poldayave);
//            cus3.weekLab.text  = FORMATSTR (_scrModel.data.polweeave);
//            cus3.monthLab.text = FORMATSTR (_scrModel.data.polmonave);
//
//            cus4.todayLab.text = FORMATSTR (_scrModel.data.scedayave);
//            cus4.weekLab.text  = FORMATSTR (_scrModel.data.sceweeave);
//            cus4.monthLab.text = FORMATSTR (_scrModel.data.scemonave);
            
        }
        else{
            NSLog(@"数据为空");
        }
        
    } ];
}




#pragma mark - 加载统计案件数量的数据
//根据type加载数据 1为今天 2为截止昨天
-(void)loadCaseDataWithType1{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:bean];
    [dic setValue:@"1" forKey:@"type"];
    NSLog(@"1");
    [[Globle getInstance].service requestWithServiceIP:ServiceURL ServiceName:@"DecAnSearchcasenum" params:dic httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        
        [hud hide:YES afterDelay:0];
        
        if (result != nil) {
            NSString *jsonStr = [Util objectToJson:result];
            NSLog(@"TodayResult:%@",jsonStr);
            self.model = [[CaseModel alloc]initWithString:jsonStr error:nil];
            NSLog(@"JSONModel %@",self.model.data.volnum.mannum);
            [self.tableView reloadData];
        }
        else{
            NSLog(@"数据为空");
        }
        
    }];
    
}


-(void)loadCaseDataWithType2{

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:bean];
    [dic setValue:@"2" forKey:@"type"];
    NSLog(@"2");
    [[Globle getInstance].service requestWithServiceIP:ServiceURL ServiceName:@"DecAnSearchcasenum" params:dic httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        
        [hud hide:YES afterDelay:0];
        if (result != nil) {
            NSString *jsonStr = [Util objectToJson:result];
            NSLog(@"YesterdayResult:%@",jsonStr);
            self.model = [[CaseModel alloc]initWithString:jsonStr error:nil];
            NSLog(@"JSONModel %@",self.model.data.volnum.mannum);
            [self.tableView reloadData];
        }
        else{
            NSLog(@"数据为空");
        }
        
    }];
}


#pragma mark - 加载保险公司理赔总数数据
-(void)loadClaimToalCountData{


    NSLog(@"理赔总数bean%@",bean);
    [[Globle getInstance].service requestWithServiceIP:ServiceURL ServiceName:@"DecAnInscpsnum" params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        
        NSString *jsonStr = [Util objectToJson:result];
        NSLog(@"总数%@",jsonStr);
        
        if (nil != result) {
        
            if ([[result objectForKey:@"restate"] isEqualToString:@"0"]) {
                NSDictionary *dic = [result objectForKey:@"data"];
                totlaCount = [dic objectForKey:@"cpsnum"];
            }
            
            
        }
        
        [self.tableView reloadData];
    
    }];
    
    
}




#pragma mark - 加载APP下载和注册的数据
-(void)loadAppData{
    
    [[Globle getInstance].service requestWithServiceIP:ServiceURL ServiceName:@"DecAnAppData" params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if (result != nil) {
            NSString *jsonStr = [Util objectToJson:result];
            NSLog(@"APPResult:%@",jsonStr);
            self.appModel = [[AppModel alloc]initWithString:jsonStr error:nil];
            NSLog(@"regnum%@",self.appModel.data.regnnum);
            [self.tableView reloadData];
        }
        else{
            NSLog(@"数据为空");
        }
        
    }];
}

#pragma mark - scrollView Delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.scrollView) {
        NSInteger page = scrollView.contentOffset.x/ScreenWidth;
        [self.segmentControl setSelectedSegmentIndex:page animated:YES];
    }
    else
    {
        NSInteger page = scrollView.contentOffset.x/ScreenWidth;
        [self.segmentControl1 setSelectedSegmentIndex:page animated:YES];
    }
   
    
    
}


#pragma mark - tableView DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        DownloadsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DownloadsTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else if (indexPath.section == 1){
        static NSString *strID = @"APPID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strID];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
        }
        [self initAPPSegment:cell];
        
        [self initAPPScrollView:cell];
        
        return cell;
    }
    else if (indexPath.section == 2)
    {
        static NSString *strID = @"ASAVEID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strID];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
        }
        [self saveAPPSegment:cell];
        
        [self saveScrollView:cell];
        return cell;
    }
    
    return [[UITableViewCell alloc]init];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 135;
            break;
            
        case 1:
            return 270;
            break;
            
        case 2:
            return 370;
            break;
    
        default:
            break;
    }
    return 40;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 5;
    }
    else if (section == 1)
    {
        return 50;
    }else if (section == 2)
    {
        return 50;
    }
    return 0.00001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 5;
}



#pragma mark - tableView Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        InsuranceViewController *vc = [InsuranceViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1)
    {
        NSArray *ietms = [[NSBundle mainBundle]loadNibNamed:@"HeaderView" owner:self options:nil];
        UIView *headView = [ietms lastObject];
       UILabel *label =  headView.subviews[0];
        label.text = @"APP使用情况";
        headView.subviews[1].backgroundColor = [UIColor redColor];
//        label.text = @"APP使用情况";
        return headView;
    }
    else if(section == 2)
    {
        NSArray *ietms = [[NSBundle mainBundle]loadNibNamed:@"HeaderView" owner:self options:nil];
        UIView *headView = [ietms lastObject];
        UILabel *label =  headView.subviews[0];
        label.text = @"处理时效(截止到昨天)";
        headView.subviews[1].backgroundColor = [UIColor redColor];
        //        label.text = @"APP使用情况";
        return headView;
    }
    return nil;
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
