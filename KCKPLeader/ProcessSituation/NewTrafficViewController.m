//
//  NewTrafficViewController.m
//  KCKPLeader
//
//  Created by Siren on 15/12/22.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "NewTrafficViewController.h"
#import "NewTrafficCell.h"
#import "NewDetModel.h"
@interface NewTrafficViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSString *userName;
    NSString *passWord;
    NSMutableDictionary *bean;
    
    
}


@property (nonatomic, strong) HMSegmentedControl *segmentControl;
@property (nonatomic, strong) NSMutableArray *dataArray;;
@property (nonatomic, strong) NSMutableArray *yesData;
@end

@implementation NewTrafficViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [_backBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    self.table.bounces = NO;
    _dataArray = [NSMutableArray array];
    _yesData = [NSMutableArray array];
    
    
    
    
    _table.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _table.layer.borderWidth = 0.5;
    [self.table registerNib:[UINib nibWithNibName:@"NewTrafficCell" bundle:nil] forCellReuseIdentifier:@"NewTrafficCell"];
    
    
    bean = [NSMutableDictionary dictionary];
    userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    passWord = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    [bean setValue:userName forKey:@"username"];
    [bean setValue:passWord forKey:@"password"];
    
    NSLog(@"ScreenHeight%f",ScreenHeight);
    NSLog(@"ScreenWidth%f",ScreenWidth);
    NSLog(@"table%f",self.table.frame.size.width);
    
    if (ScreenHeight == 480) {
        _scroll.frame = CGRectMake(_scroll.frame.origin.x, _scroll.frame.origin.y, _scroll.frame.size.width*SCALE+1, _scroll.frame.size.height);
        _scroll.contentSize = CGSizeMake(_table.frame.size.width, _table.frame.size.height);
        _scroll.bounces = NO;
        
        _naviView.frame = CGRectMake1(_naviView.frame.origin.x, _naviView.frame.origin.y, _naviView.frame.size.width, _naviView.frame.size.height);
        _backView.frame = CGRectMake1(_backView.frame.origin.x, _backView.frame.origin.y, _backView.frame.size.width, _backView.frame.size.height);
        
         _backView.frame = CGRectMake(_backView.frame.origin.x, _backView.frame.origin.y, ScreenHeight, 40);
        
        NSLog(@"navWidth %f",_naviView.frame.size.width);
        NSLog(@"backWidth %f",_backView.frame.size.width);
    }
    else{
        for (UIView *temp in self.view.subviews) {
            temp.frame = CGRectMake1(temp.frame.origin.x, temp.frame.origin.y, temp.frame.size.width, temp.frame.size.height);
            for (UIView *temp1 in temp.subviews) {
                
                    temp1.frame = CGRectMake1(temp1.frame.origin.x, temp1.frame.origin.y, temp1.frame.size.width, temp1.frame.size.height);
            }
        }
    }
    
    _titlLab = [[UILabel alloc]initWithFrame:CGRectMake1(568/2-200, 0, 400, 40)];
    _titlLab.textAlignment = NSTextAlignmentCenter;
    _titlLab.textColor = [UIColor whiteColor];
    _titlLab.text = _titleStr;
    [_naviView addSubview:_titlLab];
    
   [self initSegment];
   
    /**
     *  加载支队处理情况
     */
    if ([_titleStr isEqualToString:@"交通事故支队处理情况"]) {
        [self loadDetachmentData];
    }
    /**
     *  加载大队处理情况
     */
    else{
        [self loadMilitaryData];
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 初始化segment
-(void)initSegment{
    
    _segmentControl = [[HMSegmentedControl alloc]initWithFrame:CGRectMake(0, 0, 568*SCALE, 40)];
    _segmentControl.sectionTitles = @[@"今天",@"截止到昨天"];
    _segmentControl.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:15]};
    _segmentControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : NAVICOLOR};
    _segmentControl.selectionIndicatorColor = NAVICOLOR;
    _segmentControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    _segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _segmentControl.selectionIndicatorHeight = 2.0;
    [_backView addSubview:_segmentControl];
    
    __weak typeof(self) weakSelf = self;
    [self.segmentControl setIndexChangeBlock:^(NSInteger index) {
        
        [weakSelf.table reloadData];
        
    }];
}

- (IBAction)btnClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationLandscapeRight;
}

- (BOOL)shouldAutorotate
{
    return NO;
}


#pragma mark - 加载数据
-(void)loadDetachmentData{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.table animated:YES];

    [[Globle getInstance].service requestWithServiceIP:ServiceURL ServiceName:@"DecAnDetachment" params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        
        [hud hide:YES afterDelay:0];
        
        if (result != nil) {
            NSString *jsonStr = [Util objectToJson:result];
//            NSLog(@"Detachment:%@",jsonStr);
            NewDetModel *model = [[NewDetModel alloc]initWithString:jsonStr error:nil];
            
            for (NewDetTodayModel *todayMod in model.data.today) {
                [_dataArray addObject:todayMod];
            }
            for (NewDetYesModel *yesMod in model.data.yesterday) {
                [_yesData addObject:yesMod];
            }
            
            [self.table reloadData];
        }
    
    }];
    
}

#pragma mark - 加载大队数据
-(void)loadMilitaryData{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.table animated:YES];
    
    [[Globle getInstance].service requestWithServiceIP:ServiceURL ServiceName:@"DecAnBrigade" params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        
        [hud hide:YES afterDelay:0];
        
        if (result != nil) {
            NSString *jsonStr = [Util objectToJson:result];
//            NSLog(@"Detachment:%@",jsonStr);
            NewDetModel *model = [[NewDetModel alloc]initWithString:jsonStr error:nil];
            
            for (NewDetTodayModel *todayMod in model.data.today) {
                [_dataArray addObject:todayMod];
            }
            for (NewDetYesModel *yesMod in model.data.yesterday) {
                [_yesData addObject:yesMod];
            }
            
            [self.table reloadData];
        }
        
    }];
}

#pragma mark - table代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewTrafficCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewTrafficCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
  
    if (_segmentControl.selectedSegmentIndex == 0) {
            NewDetTodayModel *model = _dataArray[indexPath.row];
        [cell setUIWithToday:model];
    }
    else{
        NewDetYesModel *model = _yesData[indexPath.row];
        [cell setUIWithYesterday:model];
    }
    
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.000001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 33*SCREEN_WIDTH/568;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell  respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)])
    {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

CG_INLINE CGRect//注意：这里的代码要放在.m文件最下面的位置
CGRectMake1(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    float autoSizeScaleX = ScreenHeight/568;
    float autoSizeScaleY = ScreenWidth/320;
    CGRect rect;
    rect.origin.x = x * autoSizeScaleX;
    rect.origin.y = y * autoSizeScaleY;
    rect.size.width = width * autoSizeScaleX;
    rect.size.height = height * autoSizeScaleY;
    return rect;
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
