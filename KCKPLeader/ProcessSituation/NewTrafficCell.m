//
//  NewTrafficCell.m
//  KCKPLeader
//
//  Created by Siren on 15/12/22.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "NewTrafficCell.h"

@implementation NewTrafficCell
-(void)setUIWithToday:(NewDetTodayModel *)todayModel{
    
    _lab1.text  = todayModel.grouplegal;
    _lab2.text  = todayModel.volnum;
    _lab3.text  = todayModel.polnum;
    _lab4.text  = todayModel.onenum;
    _lab5.text  = todayModel.dounum;
    _lab6.text  = todayModel.mannum;
    _lab7.text  = todayModel.insnum;
    _lab8.text  = todayModel.scenum;
    _lab9.text  = todayModel.revnum;
    _lab10.text = todayModel.picnum;
}

-(void)setUIWithYesterday:(NewDetYesModel *)yesModel{
    
    _lab1.text  = yesModel.grouplegal;
    _lab2.text  = yesModel.volnum;
    _lab3.text  = yesModel.polnum;
    _lab4.text  = yesModel.onenum;
    _lab5.text  = yesModel.dounum;
    _lab6.text  = yesModel.mannum;
    _lab7.text  = yesModel.insnum;
    _lab8.text  = yesModel.scenum;
    _lab9.text  = yesModel.revnum;
    _lab10.text = yesModel.picnum;
}

- (void)awakeFromNib {
    // Initialization code

    [AppDelegate storyBoradAutoLay:self];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




@end
