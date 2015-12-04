//
//  TotalTableViewCell.m
//  KCKPLeader
//
//  Created by Siren on 15/11/25.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "TotalTableViewCell.h"
@implementation TotalTableViewCell

-(void)setUiWithInfo:(AppModel *)model{
    
    self.attentionLab.text = model.data.downnum;
    self.installLab.text = model.data.regnnum;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
