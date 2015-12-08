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
@interface HomePageViewController ()<UIScrollViewDelegate>

{
    NSString *userName;
    NSString *passWord;
    NSMutableDictionary *bean;
    CustomView *cus1;
    CustomView *cus2;
    CustomView *cus3;
    CustomView *cus4;
    
    NSNumber *totlaCount;
    AppVerModel *verModel;
    NSString *localVersion;
    NSString *serverVersion;
    NSString *remark;
}

@property (nonatomic, strong) HMSegmentedControl *segmentControl;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) CaseModel *model;
@property (nonatomic, strong) ScrollModel *scrModel;
@property (nonatomic, strong) AppModel *appModel;
@property (nonatomic, strong) UIAlertView *alertView;

@end

@implementation HomePageViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"首页";
    userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
//    passWord = [DESCript encrypt:@"888888a" encryptOrDecrypt:kCCEncrypt key:@"longstar"];
    passWord = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    bean = [[NSMutableDictionary alloc]init];
    NSLog(@"用户名%@",userName);
    NSLog(@"密码%@",passWord);
    [bean setValue:userName forKey:@"username"];
    [bean setValue:passWord forKey:@"password"];
    
    [self initSegment];
    
    [self initScrollView];
    
    [self initCustomView];
    
    [self initTable];
    
    [self loadScrolData];
    
    [self loadCaseDataWithType1];
    
    [self loadAppData];
    
    [self loadClaimToalCountData];
    
    [self checkVersion];
    
}

#pragma mark - 初始化segment
-(void)initSegment{
    
    _segmentControl = [[HMSegmentedControl alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30*ScreenHeight/568)];
    _segmentControl.sectionTitles = @[@"案件处理",@"自行协商",@"远程指导",@"转现场"];
    _segmentControl.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:15]};
    _segmentControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : NAVICOLOR};
    _segmentControl.selectionIndicatorColor = NAVICOLOR;
    _segmentControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    _segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _segmentControl.selectionIndicatorHeight = 2.0;
    [self.view addSubview:_segmentControl];
    __weak typeof(self) weakSelf = self;
    [self.segmentControl setIndexChangeBlock:^(NSInteger index) {
        
        [weakSelf.scrollView scrollRectToVisible:CGRectMake(ScreenWidth * index, 0, weakSelf.view.frame.size.width, 220) animated:YES];
        
    }];
}

#pragma mark - 初始化scrollView
-(void)initScrollView{

    float scale = ScreenHeight/667;
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_segmentControl.frame), ScreenWidth, 160*scale)];
    self.scrollView.contentSize = CGSizeMake(ScreenWidth * 4, 160*scale);
    if (ScreenHeight == 667) {
        self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_segmentControl.frame), ScreenWidth, 140)];
        self.scrollView.contentSize = CGSizeMake(ScreenWidth * 4, 140);
    }
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.bounces = NO;
    [self.view addSubview:self.scrollView];
    NSLog(@"scroll%f",self.scrollView.frame.size.height);
    
    NSLog(@"SCRW%f",ScreenWidth);
    NSLog(@"SCRH%f",ScreenHeight);
}

#pragma mark - 初始化自定义View
-(void)initCustomView{

    cus1 = [[CustomView alloc]initWithFrame:self.scrollView.bounds];
//    [cus.detailBtn addTarget:self action:@selector(jumpToTotalSituation) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:cus1];
    
    cus2 = [[CustomView alloc]initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, _scrollView.frame.size.height)];
//    [cus2.detailBtn addTarget:self action:@selector(jumpToTotalSituation) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:cus2];
    
    cus3 = [[CustomView alloc]initWithFrame:CGRectMake(ScreenWidth*2, 0, ScreenWidth, _scrollView.frame.size.height)];
//    [cus3.detailBtn addTarget:self action:@selector(jumpToTotalSituation) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:cus3];
    
    cus4 = [[CustomView alloc]initWithFrame:CGRectMake(ScreenWidth*3, 0, ScreenWidth, _scrollView.frame.size.height)];
//    [cus4.detailBtn addTarget:self action:@selector(jumpToTotalSituation) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:cus4];
}

#pragma mark - 初始化taibleView
-(void)initTable{

    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.scrollView.frame), ScreenWidth, ScreenHeight-CGRectGetHeight(_segmentControl.frame)-CGRectGetHeight(_scrollView.frame)-112);
    self.tableView.bounces = NO;
    [self.view addSubview:self.tableView];
    
    UINib *totalNib = [UINib nibWithNibName:@"TotalTableViewCell" bundle:nil];
    [self.tableView registerNib:totalNib forCellReuseIdentifier:@"TotalTableViewCell"];
    UINib *nib = [UINib nibWithNibName:@"ClaimTotalCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"ClaimTotalCell"];
    
//    if (ScreenWidth == 320) {
    
        UINib *caseNib = [UINib nibWithNibName:@"CaseTableViewCell" bundle:nil];
        [self.tableView registerNib:caseNib forCellReuseIdentifier:@"CaseTableViewCell"];
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

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"正在检查更新...";
    
    [[Globle getInstance].service requestWithServiceIP:UpdateURL ServiceName:@"lbcp_getAppVersion" params:params httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {

        [hud hide:YES afterDelay:1.0];
        
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
            cus1.todayLab.text = FORMATSTR (_scrModel.data.dayave);
            cus1.weekLab.text  = FORMATSTR (_scrModel.data.weeave) ;
            cus1.monthLab.text = FORMATSTR (_scrModel.data.monave);
            
            cus2.todayLab.text = FORMATSTR (_scrModel.data.voldayave);
            cus2.weekLab.text  = FORMATSTR (_scrModel.data.volweeave);
            cus2.monthLab.text = FORMATSTR (_scrModel.data.volmonave);

            cus3.todayLab.text = FORMATSTR (_scrModel.data.poldayave);
            cus3.weekLab.text  = FORMATSTR (_scrModel.data.polweeave);
            cus3.monthLab.text = FORMATSTR (_scrModel.data.polmonave);

            cus4.todayLab.text = FORMATSTR (_scrModel.data.scedayave);
            cus4.weekLab.text  = FORMATSTR (_scrModel.data.sceweeave);
            cus4.monthLab.text = FORMATSTR (_scrModel.data.scemonave);
            
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

    
    [[Globle getInstance].service requestWithServiceIP:ServiceURL ServiceName:@"DecAnInscpsnum" params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        
        NSString *jsonStr = [Util objectToJson:result];
        NSLog(@"总数%@",jsonStr);
        
        if (nil != result) {
        
            NSDictionary *dic = [result objectForKey:@"data"];
            totlaCount = [dic objectForKey:@"cpsnum"];
            
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
    NSInteger page = scrollView.contentOffset.x/ScreenWidth;
    [self.segmentControl setSelectedSegmentIndex:page animated:YES];
}


#pragma mark - tableView DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        CaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CaseTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.line.backgroundColor = NAVICOLOR;
        [cell.todayBtn addTarget:self action:@selector(loadCaseDataWithType1) forControlEvents:UIControlEventTouchUpInside];
        [cell.untilYesterdayBtn addTarget:self action:@selector(loadCaseDataWithType2) forControlEvents:UIControlEventTouchUpInside];
        [cell setUIWithInfo:self.model];
        return cell;
    }
    else if (indexPath.section == 1){
        ClaimTotalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClaimTotalCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.totalCount.text = [NSString stringWithFormat:@"%@",totlaCount];
        return cell;
    }
    
    else{
        TotalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TotalTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setUiWithInfo:self.appModel];
        return cell;
    }
    
    return [[UITableViewCell alloc]init];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 230*ScreenHeight/568;
            break;
            
        case 1:
            return 44;
            break;
            
        case 2:
            return 44;
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
    
    return 0.00001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 5;
}



#pragma mark - tableView Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        InsuranceViewController *vc = [InsuranceViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
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
