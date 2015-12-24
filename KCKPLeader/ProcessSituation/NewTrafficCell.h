//
//  NewTrafficCell.h
//  KCKPLeader
//
//  Created by Siren on 15/12/22.
//  Copyright © 2015年 程三. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewDetModel.h"
@interface NewTrafficCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;
@property (weak, nonatomic) IBOutlet UILabel *lab3;
@property (weak, nonatomic) IBOutlet UILabel *lab4;
@property (weak, nonatomic) IBOutlet UILabel *lab5;
@property (weak, nonatomic) IBOutlet UILabel *lab6;
@property (weak, nonatomic) IBOutlet UILabel *lab7;
@property (weak, nonatomic) IBOutlet UILabel *lab8;
@property (weak, nonatomic) IBOutlet UILabel *lab9;
@property (weak, nonatomic) IBOutlet UILabel *lab10;

-(void)setUIWithToday:(NewDetTodayModel *)todayModel;
-(void)setUIWithYesterday:(NewDetYesModel *)yesModel;
@end
