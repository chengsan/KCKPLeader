//
//  DataStatisticsCell.h
//  KCKPLeader
//
//  Created by Siren on 15/11/27.
//  Copyright © 2015年 程三. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompanyModel.h"
@interface DataStatisticsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *totalNum;
@property (weak, nonatomic) IBOutlet UILabel *rate;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *userSatisfaction;


-(void)setUIWithInfo:(CompanyModel *)model;
@end
