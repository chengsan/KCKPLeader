//
//  CustomView.m
//  KCKPLeader
//
//  Created by Siren on 15/11/28.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "CustomView.h"
#import "TotalSituationViewController.h"
@implementation CustomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [AppDelegate storyBoradAutoLay:self];
        
        CGFloat chartWidth = (ScreenWidth-80)/3;
        self.todayChartV = [[UIImageView alloc]initWithFrame:CGRectMake(20, 8, chartWidth, chartWidth) ];
        self.todayChartV.image = [UIImage imageNamed:@"180"];
        self.todayChartV.backgroundColor = [UIColor clearColor];
       
        [self addSubview:self.todayChartV];
        
        self.todayLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, chartWidth, chartWidth)];
        self.todayLab.center = self.todayChartV.center;
//        self.todayLab.textColor = RGBA(249, 144, 0, 1.0);
        self.todayLab.textColor = RGBA(49, 120, 255, 1.0);
        self.todayLab.textAlignment = NSTextAlignmentCenter;
        self.todayLab.numberOfLines = 0;
        self.todayLab.text = @"";
        self.todayLab.font = [UIFont systemFontOfSize:12];
        [self addSubview:_todayLab];
        
        self.todayAverage = [[UILabel alloc]initWithFrame:CGRectMake(_todayChartV.frame.origin.x, CGRectGetMaxY(_todayChartV.frame)+5, chartWidth, 21)];
        self.todayAverage.text = @"当天平均时效";
        self.todayAverage.textAlignment = NSTextAlignmentCenter;
        self.todayAverage.font = [UIFont systemFontOfSize:12];
        [self addSubview:_todayAverage];
        
        self.weekChartV = [[UIImageView alloc]initWithFrame:CGRectMake(40+chartWidth, _todayChartV.frame.origin.y, chartWidth, chartWidth) ];
        self.weekChartV.image = [UIImage imageNamed:@"180"];
        [self addSubview:self.weekChartV];
        
        self.weekLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, chartWidth, chartWidth)];
        self.weekLab.center = self.weekChartV.center;
        self.weekLab.textColor = RGBA(49, 120, 255, 1.0);
        self.weekLab.textAlignment = NSTextAlignmentCenter;
        self.weekLab.text = @"";
        self.weekLab.numberOfLines = 0;
        self.weekLab.font = [UIFont systemFontOfSize:12];
        [self addSubview:_weekLab];
        
        self.weekAverage = [[UILabel alloc]initWithFrame:CGRectMake(_weekChartV.frame.origin.x, CGRectGetMaxY(_weekChartV.frame)+5, chartWidth, 21)];
        self.weekAverage.text = @"本周平均时效";
        self.weekAverage.textAlignment = NSTextAlignmentCenter;
        self.weekAverage.font = [UIFont systemFontOfSize:12];
        [self addSubview:_weekAverage];
        
        self.monthChartV = [[UIImageView alloc]initWithFrame:CGRectMake(60+2*chartWidth, _todayChartV.frame.origin.y, chartWidth, chartWidth) ];
        self.monthChartV.image = [UIImage imageNamed:@"180"];
        [self addSubview:self.monthChartV];
        
        self.monthLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, chartWidth, chartWidth)];
        self.monthLab.center = self.monthChartV.center;
//        self.monthLab.textColor = RGBA(111, 171, 0, 1.0);
        self.monthLab.textColor = RGBA(49, 120, 255, 1.0);
        self.monthLab.textAlignment = NSTextAlignmentCenter;
        self.monthLab.text = @"";
        self.monthLab.numberOfLines = 0;
        self.monthLab.font = [UIFont systemFontOfSize:12];
        [self addSubview:_monthLab];
        
        self.monthAverage = [[UILabel alloc]initWithFrame:CGRectMake(_monthChartV.frame.origin.x, CGRectGetMaxY(_monthChartV.frame)+5, chartWidth, 21)];
        self.monthAverage.text = @"本月平均时效";
        self.monthAverage.textAlignment = NSTextAlignmentCenter;
        self.monthAverage.font = [UIFont systemFontOfSize:12];
        [self addSubview:_monthAverage];
        
        if (ScreenHeight>568) {
            _monthAverage.font = [UIFont systemFontOfSize:16];
            _weekAverage.font = [UIFont systemFontOfSize:16];
            _todayAverage.font = [UIFont systemFontOfSize:16];
            
        }
        
        
//        self.icon =[[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.frame)-31, 21, 21)];
//        self.icon.image = [UIImage imageNamed:@"sign"];
//        [self addSubview:self.icon];
//        
//        self.iconRightLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_icon.frame)+5, _icon.frame.origin.y, 110, 21)];
//        self.iconRightLab.text = @"事故总体情况";
//        [self addSubview:self.iconRightLab];
//        
//        self.accidentTimes = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_iconRightLab.frame)+2, _icon.frame.origin.y, 30, 21)];
//        self.accidentTimes.text = @"140";
//        self.accidentTimes.textColor = NAVICOLOR;
//        [self addSubview:self.accidentTimes];
//        
//        self.times = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_accidentTimes.frame), _icon.frame.origin.y, 21, 21)];
//        self.times.text = @"次";
//        [self addSubview:self.times];
//
//
//        self.detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        self.detailBtn.frame = CGRectMake(ScreenWidth-90,  _icon.frame.origin.y, 50, 21);
//        [self.detailBtn setTitle:@"查看详情>>" forState:UIControlStateNormal];
//        [self.detailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        self.detailBtn.titleLabel.font = [UIFont systemFontOfSize:13];
//        [self.detailBtn sizeToFit];
//        [self addSubview:_detailBtn];
        
    }
    return self;
}





@end
