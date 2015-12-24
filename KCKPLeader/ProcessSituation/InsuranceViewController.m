//
//  InsuranceViewController.m
//  KCKPLeader
//
//  Created by Siren on 15/11/25.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "InsuranceViewController.h"
#import "DataStatisticsCell.h"
#import "CompanyRankCell.h"
#import "ClaimDetailViewController.h"
#import "InsDataModel.h"
@interface InsuranceViewController ()<UIScrollViewDelegate>
{
    
    NSString *userName;
    NSString *passWord;
    NSMutableDictionary *bean;
    NSMutableArray *dataAry;
    InsDataModel *model;
    NSArray *iconArray;
    
}
@property (nonatomic, strong) HMSegmentedControl *segmentControl;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITableView *companyTable;
@end

@implementation InsuranceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"保险公司处理情况";
    
    bean = [NSMutableDictionary dictionary];
    iconArray = @[@"nicon03",@"nicon04",@"nicon05",@"nicon06"];
    dataAry = [NSMutableArray array];
    userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    passWord = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    [bean setValue:userName forKey:@"username"];
    [bean setValue:passWord forKey:@"password"];
    
    [self loadInsData];

    
//    _segmentControl = [[HMSegmentedControl alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
//    _segmentControl.sectionTitles = @[@"数据统计",@"公司排行"];
//    _segmentControl.sectionTitles = @[@"数据统计"];
//    
//    _segmentControl.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:15]};
//    _segmentControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : NAVICOLOR};
//    _segmentControl.selectionIndicatorColor = NAVICOLOR;
//    _segmentControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
//    _segmentControl.selectionIndicatorHeight = 3;
//    _segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
//    [self.view addSubview:_segmentControl];
    
//    __weak typeof(self) weakSelf = self;
//    [self.segmentControl setIndexChangeBlock:^(NSInteger index) {
//        
//        [weakSelf.scrollView scrollRectToVisible:CGRectMake(ScreenWidth * index, 0, weakSelf.view.frame.size.width, 220) animated:YES];
//        
//    }];
    
    [self.tableView removeFromSuperview];
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_segmentControl.frame), ScreenWidth, ScreenHeight-64)];
//    self.scrollView.contentSize = CGSizeMake(ScreenWidth * 2, ScreenHeight-94);
//    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.bounces = NO;
    [self.view addSubview:self.scrollView];
    
    [self initTable];
}

-(void)initTable{
    
    self.tableView.frame = CGRectMake(0, 0, ScreenWidth, self.scrollView.frame.size.height);
    [self.scrollView addSubview:self.tableView];
    
    UINib *nib1 = [UINib nibWithNibName:@"DataStatisticsCell" bundle:nil];
    [self.tableView registerNib:nib1 forCellReuseIdentifier:@"DataStatisticsCell"];
    
//    self.companyTable = [[UITableView alloc]initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, self.scrollView.frame.size.height) style:UITableViewStyleGrouped];
//    self.companyTable.delegate = self;
//    self.companyTable.dataSource = self;
//    self.companyTable.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.scrollView addSubview:self.companyTable];
//    [self.companyTable registerClass:[CompanyRankCell class] forCellReuseIdentifier:@"CompanyRankCell"];
    

    //tableView的三种分界线
//    UITableViewCellSeparatorStyleNone,
//    UITableViewCellSeparatorStyleSingleLine,
//    UITableViewCellSeparatorStyleSingleLineEtched
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeLeft;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 加载保险公司处理情况数据
-(void)loadInsData{
    
    [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    
    
    [[Globle getInstance].service requestWithServiceIP:ServiceURL ServiceName:@"DecAnIns" params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        
        [MBProgressHUD hideHUDForView:self.tableView animated:YES];
        
        if (result != nil) {
            NSString *jsonStr = [Util objectToJson:result];
            NSLog(@"Detachment:%@",jsonStr);
            
            model = [[InsDataModel alloc]initWithString:jsonStr error:nil];
            
            [self.tableView reloadData];
        }
        else{
            NSLog(@"数据为空");
        }
        
    }];
    
}


#pragma mark - scrollView Delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    if (scrollView == self.scrollView) {
//        NSInteger page = scrollView.contentOffset.x/ScreenWidth;
//        [self.segmentControl setSelectedSegmentIndex:page animated:YES];
//    }
}

#pragma mark - tableView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.tableView) {
//        NSLog(@"公司个数%ld",(unsigned long)model.data.count);
        return model.data.count;
        
    }
    else{
        return 2;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tableView) {
        return 1;
    }
    else{
        return 10;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableView) {
        return 155*ScreenHeight/568;
    }
    else{
        return 35;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.tableView) {
        DataStatisticsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DataStatisticsCell"];
        cell.icon.image = [UIImage imageNamed:iconArray[indexPath.section%4]];
        CompanyModel *comMod = model.data[indexPath.section];
        [cell setUIWithInfo:comMod];
        return cell;
    }
    else{
        CompanyRankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CompanyRankCell"];
        cell.rankLab.backgroundColor = [UIColor lightGrayColor];
        if (indexPath.row==0 || indexPath.row==1 || indexPath.row==2) {
            cell.rankLab.backgroundColor = NAVICOLOR;
        }
        cell.rankLab.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
        cell.rankLab.textColor = [UIColor whiteColor];
        cell.companyNameLab.text = @"中国人民财产保险股份有限公司北京分公司";
        return cell;
    }
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (tableView == self.companyTable) {
        UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, ScreenWidth-40, 30)];
        title.textColor = NAVICOLOR;
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(15, 5, 20, 20)];
        imageV.image = [UIImage imageNamed:@"icon028"];
        [header addSubview:imageV];
        [header addSubview:title];
        if (section == 0) {
            title.text = @"时效公司排行前十名";
        }
        else{
            title.text = @"时效公司排行后十名";
        }
        return header;
    }

    
    else return nil;

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.companyTable) {
        return 30;
    }
    else{
        return 5;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.tableView) {
        ClaimDetailViewController *vc = [ClaimDetailViewController new];
        
        CompanyModel *comMod = model.data[indexPath.section];
        vc.inscode = comMod.inscode;
        vc.comName = comMod.insname;
        vc.comIcon = iconArray[indexPath.section%4];
        
        //改变导航栏返回按钮的文字，避免push过去的VCtitle无法居中
        UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
        returnButtonItem.title = @"";
        self.navigationItem.backBarButtonItem = returnButtonItem;
        
        [self.navigationController pushViewController:vc animated:YES];
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
