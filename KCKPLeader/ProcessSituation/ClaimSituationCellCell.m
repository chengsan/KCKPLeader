//
//  ClaimSituationCellCell.m
//  KCKPLeader
//
//  Created by Siren on 15/11/27.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "ClaimSituationCellCell.h"

@implementation ClaimSituationCellCell

-(void)setPicUIWithInfo:(ClaimModel *)model{
    
    self.oneLab.text   = model.data.daypicnum.onenum;
    self.moreLab.text  = model.data.daypicnum.mannum;
    self.totalLab.text = model.data.daypicnum.allnum;
    
    self.yesOneLab.text   = model.data.picnum.onenum;
    self.yesMoreLab.text  = model.data.picnum.mannum;
    self.yesTotalLab.text = model.data.picnum.allnum;
}

-(void)setDutUIWithInfo:(ClaimModel *)model{

    self.oneLab.text   = model.data.daydutnum.onenum;
    self.moreLab.text  = model.data.daydutnum.mannum;
    self.totalLab.text = model.data.daydutnum.allnum;
    
    self.yesOneLab.text   = model.data.dutnum.onenum;
    self.yesMoreLab.text  = model.data.dutnum.mannum;
    self.yesTotalLab.text = model.data.dutnum.allnum;
}
-(void)setInsUIWithInfo:(ClaimModel *)model{

    self.oneLab.text   = model.data.dayinsnum.onenum;
    self.moreLab.text  = model.data.dayinsnum.mannum;
    self.totalLab.text = model.data.dayinsnum.allnum;
    
    self.yesOneLab.text   = model.data.insnum.onenum;
    self.yesMoreLab.text  = model.data.insnum.mannum;
    self.yesTotalLab.text = model.data.insnum.allnum;
}

-(void)setCpsUIWithInfo:(ClaimModel *)model{

    self.oneLab.text   = model.data.daycpsnum.onenum;
    self.moreLab.text  = model.data.daycpsnum.mannum;
    self.totalLab.text = model.data.daycpsnum.allnum;
    
    self.yesOneLab.text   = model.data.cpsnum.onenum;
    self.yesMoreLab.text  = model.data.cpsnum.mannum;
    self.yesTotalLab.text = model.data.cpsnum.allnum;
}





- (void)awakeFromNib {
    // Initialization code
    [AppDelegate storyBoradAutoLay:self];
    
    self.selectionStyle = UITableViewCellEditingStyleNone;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
