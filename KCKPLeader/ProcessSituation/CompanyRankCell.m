//
//  CompanyRankCell.m
//  KCKPLeader
//
//  Created by Siren on 15/11/27.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "CompanyRankCell.h"

@implementation CompanyRankCell

//- (void)awakeFromNib {
//    // Initialization code
//    
//
//}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat spacing = 20.0f;
        self.rankLab = [UILabel new];
        self.rankLab.font = [UIFont systemFontOfSize:13];
        self.rankLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.rankLab];
        [self.rankLab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.left.bottom.equalTo(self.contentView).insets(UIEdgeInsetsMake(9, spacing, 10, 0));
            make.width.equalTo(@16);
            make.height.equalTo(@16);
            
        }];
        
        self.companyNameLab = [UILabel new];
        
        //根据屏幕宽度设置字体大小 小于6的字体大小为13  
        if (ScreenWidth<375) {
            self.companyNameLab.font = [UIFont systemFontOfSize:13];
        }
        else if(ScreenWidth==375){
            self.companyNameLab.font = [UIFont systemFontOfSize:15];
        }
        
        [self.contentView addSubview:self.companyNameLab];
        [self.companyNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.bottom.right.equalTo(self.contentView).insets(UIEdgeInsetsMake(10, 0, 10, 20));
            make.left.equalTo(self.rankLab.mas_right).with.offset(10);
            
        }];
    }
    
    return self;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
