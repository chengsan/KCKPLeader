//
//  CustomView.h
//  KCKPLeader
//
//  Created by Siren on 15/11/28.
//  Copyright © 2015年 程三. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollModel.h"
@interface CustomView : UIView


@property (nonatomic, strong)  UIImageView *todayChartV;
@property (nonatomic, strong)  UIImageView *weekChartV;
@property (nonatomic, strong)  UIImageView *monthChartV;


@property (nonatomic, strong)  UILabel *todayLab;
@property (nonatomic, strong)  UILabel *weekLab;
@property (nonatomic, strong)  UILabel *monthLab;

@property (nonatomic, strong)  UILabel *todayAverage;
@property (nonatomic, strong)  UILabel *weekAverage;
@property (nonatomic, strong)  UILabel *monthAverage;

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *iconRightLab;
@property (nonatomic, strong) UILabel *accidentTimes;
@property (nonatomic, strong) UILabel *times;

@property (nonatomic, strong) UIButton *detailBtn;


@end
