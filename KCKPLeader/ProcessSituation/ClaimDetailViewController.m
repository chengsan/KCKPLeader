//
//  ClaimDetailViewController.m
//  KCKPLeader
//
//  Created by Siren on 15/11/25.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "ClaimDetailViewController.h"
#import "ClaimDetailModel.h"
@interface ClaimDetailViewController ()
{
    
    NSString *userName;
    NSString *passWord;
    NSMutableDictionary *bean;
    NSMutableArray *dataAry;
    ClaimDetailModel *model;
    
    
    
}

@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation ClaimDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    UIColor *color = RGBA(235, 235, 235, 1.0);
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.pieChart];
    [AppDelegate storyBoradAutoLay:self.view];
    
    self.title = @"理赔详情";
    
    bean = [NSMutableDictionary dictionary];
    dataAry = [NSMutableArray array];
    userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    passWord = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    [bean setValue:userName forKey:@"username"];
    [bean setValue:passWord forKey:@"password"];
    [bean setValue:self.inscode forKey:@"inscode"];
//    NSLog(@"bean%@",bean);
//    NSLog(@"%@",self.comIcon);
//    NSLog(@"%@",self.comName);
    

    [self loadInsDetailData];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 加载保险公司处理情况数据
-(void)loadInsDetailData{
    
    __weak typeof(self) weakSelf = self;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"正在加载...";
    [[Globle getInstance].service requestWithServiceIP:ServiceURL ServiceName:@"DecAnInsinfo" params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        
        [hud hide:YES afterDelay:0];
    
        if (result != nil) {
            NSString *jsonStr = [Util objectToJson:result];
            NSLog(@"信息:%@",jsonStr);
            model = [[ClaimDetailModel alloc]initWithString:jsonStr error:nil];
    
            weakSelf.conpanyLab.text = weakSelf.comName;
            weakSelf.companyIcon.image = [UIImage imageNamed:weakSelf.comIcon];
            
            
            NSInteger oneDay = [model.data.num.oneday integerValue];
            NSInteger twoDay = [model.data.num.twoday integerValue];
            NSInteger thrDay = [model.data.num.thrday integerValue];
            NSInteger moreDay = [model.data.num.manday integerValue];
            NSInteger unCla = [model.data.num.noclam integerValue];
            
            NSString *totlaTime = [NSString stringWithFormat:@"总计处理\n%zi次",oneDay+twoDay+thrDay+moreDay+unCla];
            
            UIColor *color1 = RGBA(233, 142, 0, 1.0);
            UIColor *color2 = RGBA(94, 156, 0, 1.0);
            UIColor *color3 = RGBA(215, 35, 48, 1.0);
            UIColor *color4 = RGBA(100, 37, 133, 1.0);
            UIColor *color5 = RGBA(27, 89, 252, 1.0);
            
//            [NSString stringWithFormat:@"1天%ld次",oneDay]
            PNPieChartDataItem *item1 = [PNPieChartDataItem dataItemWithValue:oneDay color:color1 description:@""];
            
            PNPieChartDataItem *item2 = [PNPieChartDataItem dataItemWithValue:twoDay color:color2 description:@""];
            
            PNPieChartDataItem *item3 = [PNPieChartDataItem dataItemWithValue:thrDay color:color3 description:@""];
            
            PNPieChartDataItem *item4 = [PNPieChartDataItem dataItemWithValue:moreDay color:color4 description:@""];
            
            PNPieChartDataItem *item5 = [PNPieChartDataItem dataItemWithValue:unCla color:color5 description:@""];
            
            NSArray *items = @[item1,item2,item3,item4,item5];
            
            weakSelf.pieChart = [[PNPieChart alloc]initWithFrame:CGRectMake(self.conpanyLab.origin.x+80*SCALE, CGRectGetMaxY(self.conpanyLab.frame)+10*SCALE, 150*SCALE, 150*SCALE) items:items];
            weakSelf.pieChart.showAbsoluteValues = NO;
            weakSelf.pieChart.showOnlyValues = NO;
            weakSelf.pieChart.labelPercentageCutoff = 20;
//            if (totlaTime == 0) {
//                weakSelf.pieChart.labelPercentageCutoff = 20;
//            }
//            else{
//                weakSelf.pieChart.labelPercentageCutoff = 0.1;
//            }

            weakSelf.pieChart.descriptionTextColor = [UIColor whiteColor];
            weakSelf.pieChart.descriptionTextFont = [UIFont systemFontOfSize:13];
            [weakSelf.pieChart strokeChart];
            [weakSelf.view addSubview:weakSelf.pieChart];
            
            weakSelf.totalCount = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 50)];
            weakSelf.totalCount.textColor = [UIColor orangeColor];
            weakSelf.totalCount.text = totlaTime;
            weakSelf.totalCount.textAlignment = NSTextAlignmentCenter;
            weakSelf.totalCount.font = [UIFont systemFontOfSize:13];
            weakSelf.totalCount.center = weakSelf.pieChart.center;
            weakSelf.totalCount.numberOfLines = 2;
            [weakSelf.view addSubview:weakSelf.totalCount];
            
            
            _one_time.text = model.data.num.oneday;
            _two_time.text = model.data.num.twoday;
            _three_time.text = model.data.num.thrday;
            _more_time.text = model.data.num.manday;
            _uncla_time.text = model.data.num.noclam;
            
            _one_pro.text = model.data.pro.oneday;
            _two_pro.text = model.data.pro.twoday;
            _three_pro.text = model.data.pro.thrday;
            _more_pro.text = model.data.pro.manday;
            _uncla_pro.text = model.data.pro.noclam;
            
            _claimRate.text = [NSString stringWithFormat:@"赔付率为%@",model.data.payrat];
            
        }
        else{
            NSLog(@"数据为空");
        }
//        [AppDelegate storyBoradAutoLay:self.view];
        
    }];
    
    
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
