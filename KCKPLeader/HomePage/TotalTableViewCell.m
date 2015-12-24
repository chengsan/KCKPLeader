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
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_installLab.frame), 11, 40, _installLab.frame.size.height)];
    lab.text = @"人次";
    lab.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:lab];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
