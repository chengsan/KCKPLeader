//
//  CaseTableViewCell.h
//  KCKPLeader
//
//  Created by Siren on 15/11/25.
//  Copyright © 2015年 程三. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CaseModel.h"
#import "DetDataModel.h"
@interface CaseTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *todayBtn;
@property (weak, nonatomic) IBOutlet UIButton *untilYesterdayBtn;
@property (weak, nonatomic) IBOutlet UILabel *line;

@property (weak, nonatomic) IBOutlet UILabel *consult_more;
@property (weak, nonatomic) IBOutlet UILabel *consult_one;
@property (weak, nonatomic) IBOutlet UILabel *consult_total;

@property (weak, nonatomic) IBOutlet UILabel *conduct_more;
@property (weak, nonatomic) IBOutlet UILabel *conduct_one;
@property (weak, nonatomic) IBOutlet UILabel *conduct_total;

@property (weak, nonatomic) IBOutlet UILabel *total_more;
@property (weak, nonatomic) IBOutlet UILabel *total_one;
@property (weak, nonatomic) IBOutlet UILabel *total_total;

@property (weak, nonatomic) IBOutlet UILabel *scene_more;
@property (weak, nonatomic) IBOutlet UILabel *scene_one;
@property (weak, nonatomic) IBOutlet UILabel *scene_total;

@property (weak, nonatomic) IBOutlet UILabel *ins_more;
@property (weak, nonatomic) IBOutlet UILabel *ins_one;
@property (weak, nonatomic) IBOutlet UILabel *ins_total;

@property (nonatomic, strong) DetDataModel *dataModel;

-(void)setUIWithInfo:(CaseModel *)model;


@end
