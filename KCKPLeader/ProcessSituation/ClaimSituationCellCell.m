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
    
    self.oneLab.text = model.data.picnum.onenum;
    self.moreLab.text = model.data.picnum.mannum;
    self.totalLab.text = model.data.picnum.allnum;
}

-(void)setDutUIWithInfo:(ClaimModel *)model{

    self.oneLab.text = model.data.dutnum.onenum;
    self.moreLab.text = model.data.dutnum.mannum;
    self.totalLab.text = model.data.dutnum.allnum;
}
-(void)setInsUIWithInfo:(ClaimModel *)model{

    self.oneLab.text = model.data.insnum.onenum;
    self.moreLab.text = model.data.insnum.mannum;
    self.totalLab.text = model.data.insnum.allnum;
}

-(void)setCpsUIWithInfo:(ClaimModel *)model{

    self.oneLab.text = model.data.cpsnum.onenum;
    self.moreLab.text = model.data.cpsnum.mannum;
    self.totalLab.text = model.data.cpsnum.allnum;
}

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellEditingStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
