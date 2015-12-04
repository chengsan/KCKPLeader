//
//  ClaimSituationCellCell.h
//  KCKPLeader
//
//  Created by Siren on 15/11/27.
//  Copyright © 2015年 程三. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClaimModel.h"
@interface ClaimSituationCellCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *oneLab;
@property (weak, nonatomic) IBOutlet UILabel *moreLab;
@property (weak, nonatomic) IBOutlet UILabel *totalLab;


-(void)setPicUIWithInfo:(ClaimModel *)model;
-(void)setDutUIWithInfo:(ClaimModel *)model;
-(void)setInsUIWithInfo:(ClaimModel *)model;
-(void)setCpsUIWithInfo:(ClaimModel *)model;
@end
