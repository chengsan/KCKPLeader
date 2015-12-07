//
//  DataStatisticsCell.m
//  KCKPLeader
//
//  Created by Siren on 15/11/27.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "DataStatisticsCell.h"

@implementation DataStatisticsCell

-(void)setUIWithInfo:(CompanyModel *)model{
    
    self.titleLab.text         = model.insname;
    self.totalNum.text         = model.cpsnum;
    self.rate.text             = model.payrat;
    self.time.text             = model.cpsave;
    self.userSatisfaction.text = model.scorat;
    
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
