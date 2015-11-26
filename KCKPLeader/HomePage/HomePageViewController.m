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
@interface HomePageViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) HMSegmentedControl *segmentControl;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation HomePageViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"首页";
    
    _segmentControl = [[HMSegmentedControl alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
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
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, ScreenWidth, 220)];
    self.scrollView.contentSize = CGSizeMake(ScreenWidth * 4, 220);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.bounces = NO;
    [self.view addSubview:self.scrollView];
    
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 220)];
    [self setApperanceForLabel:label1];
    label1.text = @"Case";
    [self.scrollView addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, 220)];
    [self setApperanceForLabel:label2];
    label2.text = @"Talk";
    [self.scrollView addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth * 2, 0, ScreenWidth, 220)];
    [self setApperanceForLabel:label3];
    label3.text = @"Conduct";
    [self.scrollView addSubview:label3];
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth * 3, 0, ScreenWidth, 220)];
    [self setApperanceForLabel:label4];
    label4.text = @"Scene";
    [self.scrollView addSubview:label4];
    
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.scrollView.frame), ScreenWidth, 295);
    self.tableView.bounces = NO;
    
    [self.view addSubview:self.tableView];
    
    UINib *caseNib = [UINib nibWithNibName:@"CaseTableViewCell" bundle:nil];
    [self.tableView registerNib:caseNib forCellReuseIdentifier:@"CaseTableViewCell"];
    
    UINib *totalNib = [UINib nibWithNibName:@"TotalTableViewCell" bundle:nil];
    [self.tableView registerNib:totalNib forCellReuseIdentifier:@"TotalTableViewCell"];
    
}

- (void)setApperanceForLabel:(UILabel *)label {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    label.backgroundColor = color;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:21.0f];
    label.textAlignment = NSTextAlignmentCenter;
}

#pragma mark - scrollView Delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x/ScreenWidth;
    [self.segmentControl setSelectedSegmentIndex:page animated:YES];
}


#pragma mark - tableView DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        CaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CaseTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.line.backgroundColor = NAVICOLOR;
        return cell;
    }
    else{
        TotalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TotalTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    return [[UITableViewCell alloc]init];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 230;
            break;
        case 1:
            return 50;
            break;
            
        default:
            break;
    }
    return 40;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 0.00001;
    }
    else {
        return 5;
    }
    
}



#pragma mark - tableView Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

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
