//
//  ClaimDetailViewController.h
//  KCKPLeader
//
//  Created by Siren on 15/11/25.
//  Copyright © 2015年 程三. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClaimDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *companyIcon;
@property (weak, nonatomic) IBOutlet UILabel *conpanyLab;


@property (weak, nonatomic) IBOutlet UILabel *lab;
@property (weak, nonatomic) IBOutlet UILabel *timesLab;
@property (weak, nonatomic) IBOutlet UILabel *proportionLab;

@property (weak, nonatomic) IBOutlet UILabel *oneLab;
@property (weak, nonatomic) IBOutlet UILabel *twoLab;
@property (weak, nonatomic) IBOutlet UILabel *threeLab;
@property (weak, nonatomic) IBOutlet UILabel *moreLab;
@property (weak, nonatomic) IBOutlet UILabel *unClaimLab;

@property (weak, nonatomic) IBOutlet UILabel *claimRate;

@property (weak, nonatomic) IBOutlet UILabel *one_time;
@property (weak, nonatomic) IBOutlet UILabel *two_time;
@property (weak, nonatomic) IBOutlet UILabel *three_time;
@property (weak, nonatomic) IBOutlet UILabel *more_time;
@property (weak, nonatomic) IBOutlet UILabel *uncla_time;

@property (weak, nonatomic) IBOutlet UILabel *one_pro;
@property (weak, nonatomic) IBOutlet UILabel *two_pro;
@property (weak, nonatomic) IBOutlet UILabel *three_pro;
@property (weak, nonatomic) IBOutlet UILabel *more_pro;
@property (weak, nonatomic) IBOutlet UILabel *uncla_pro;

@property (strong, nonatomic) IBOutlet PNPieChart *pieChart;

//@property (nonatomic, strong) PNPieChart *pieChart;

@property (nonatomic, strong) UILabel *totalCount;
@property (nonatomic, strong) UILabel *totlaLab;

@property (nonatomic, strong) NSString *inscode;//保险公司代码
@property (nonatomic, strong) NSString *comName;//保险公司名称
@property (nonatomic, strong) NSString *comIcon;//保险公司icon
@end
