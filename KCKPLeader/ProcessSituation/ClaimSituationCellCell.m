//
//  ClaimSituationCellCell.m
//  KCKPLeader
//
//  Created by Siren on 15/11/27.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "ClaimSituationCellCell.h"

#define FORMATTIME(str) [NSString stringWithFormat:@"%@次",str]
@implementation ClaimSituationCellCell

-(void)setPicUIWithInfo:(ClaimModel *)model{
    
    self.oneLab.text   = FORMATTIME(model.data.daypicnum.onenum);
    self.moreLab.text  = FORMATTIME(model.data.daypicnum.mannum);
    self.totalLab.text = FORMATTIME(model.data.daypicnum.allnum);
    
    self.yesOneLab.text   = FORMATTIME(model.data.picnum.onenum);
    self.yesMoreLab.text  = FORMATTIME(model.data.picnum.mannum);
    self.yesTotalLab.text = FORMATTIME(model.data.picnum.allnum);
}

-(void)setDutUIWithInfo:(ClaimModel *)model{

    self.oneLab.text   = FORMATTIME(model.data.daydutnum.onenum);
    self.moreLab.text  = FORMATTIME(model.data.daydutnum.mannum);
    self.totalLab.text = FORMATTIME(model.data.daydutnum.allnum);
    
    self.yesOneLab.text   = FORMATTIME(model.data.dutnum.onenum);
    self.yesMoreLab.text  = FORMATTIME(model.data.dutnum.mannum);
    self.yesTotalLab.text = FORMATTIME(model.data.dutnum.allnum);
}
-(void)setInsUIWithInfo:(ClaimModel *)model{

    self.oneLab.text   = FORMATTIME(model.data.dayinsnum.onenum);
    self.moreLab.text  = FORMATTIME(model.data.dayinsnum.mannum);
    self.totalLab.text = FORMATTIME(model.data.dayinsnum.allnum);
    
    self.yesOneLab.text   = FORMATTIME(model.data.insnum.onenum);
    self.yesMoreLab.text  = FORMATTIME(model.data.insnum.mannum);
    self.yesTotalLab.text = FORMATTIME(model.data.insnum.allnum);
}

-(void)setCpsUIWithInfo:(ClaimModel *)model{

    self.oneLab.text   = FORMATTIME(model.data.daycpsnum.onenum);
    self.moreLab.text  = FORMATTIME(model.data.daycpsnum.mannum);
    self.totalLab.text = FORMATTIME(model.data.daycpsnum.allnum);
    
    self.yesOneLab.text   = FORMATTIME(model.data.cpsnum.onenum);
    self.yesMoreLab.text  = FORMATTIME(model.data.cpsnum.mannum);
    self.yesTotalLab.text = FORMATTIME(model.data.cpsnum.allnum);
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
