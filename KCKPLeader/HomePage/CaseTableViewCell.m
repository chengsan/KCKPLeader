//
//  CaseTableViewCell.m
//  KCKPLeader
//
//  Created by Siren on 15/11/25.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "CaseTableViewCell.h"

@implementation CaseTableViewCell

-(void)setUIWithInfo:(CaseModel *)model{

    _consult_more.text = model.data.volnum.mannum;
    _consult_one.text = model.data.volnum.onenum;
    _consult_total.text = model.data.volnum.allnum;
    
    _conduct_more.text = model.data.polnum.mannum;
    _conduct_one.text = model.data.polnum.onenum;
    _conduct_total.text = model.data.polnum.allnum;
    
    _total_more.text = model.data.allnum.mannum;
    _total_one.text = model.data.allnum.onenum;
    _total_total.text = model.data.allnum.allnum;
    
    _ins_more.text = model.data.insnum.mannum;
    _ins_one.text = model.data.insnum.onenum;
    _ins_total.text = model.data.insnum.allnum;
    
    _scene_more.text = model.data.scenum.mannum;
    _scene_one.text = model.data.scenum.onenum;
    _scene_total.text = model.data.scenum.allnum;
}

-(void)awakeFromNib{
    self.todayBtn.layer.cornerRadius = 3;
    self.todayBtn.layer.borderWidth = 1;
    self.todayBtn.layer.borderColor = NAVICOLOR.CGColor;
    self.todayBtn.backgroundColor = NAVICOLOR;
    self.todayBtn.tag = 101;
    [self.todayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.untilYesterdayBtn.layer.cornerRadius = 3;
    self.untilYesterdayBtn.layer.borderWidth = 1;
    self.untilYesterdayBtn.tag = 102;
    self.untilYesterdayBtn.layer.borderColor = NAVICOLOR.CGColor;
}

- (IBAction)todayBtnClick:(id)sender {

    [self todayChangeToClick];
    [self yesterdayChangeToUnClick];

}

- (IBAction)untilYestodayBtnClick:(id)sender {

    [self yesterdayChangeToClick];
    [self todayChangeToUnClick];
    
}

-(void)todayChangeToClick{
    self.todayBtn.backgroundColor = NAVICOLOR;
    [self.todayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

-(void)todayChangeToUnClick{

    self.todayBtn.backgroundColor = [UIColor whiteColor];
    [self.todayBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
}

-(void)yesterdayChangeToClick{
    self.untilYesterdayBtn.backgroundColor = NAVICOLOR;
    [self.untilYesterdayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

-(void)yesterdayChangeToUnClick{
    
    self.untilYesterdayBtn .backgroundColor = [UIColor whiteColor];
    [self.untilYesterdayBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
