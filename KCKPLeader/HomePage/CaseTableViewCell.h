//
//  CaseTableViewCell.h
//  KCKPLeader
//
//  Created by Siren on 15/11/25.
//  Copyright © 2015年 程三. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CaseTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *todayBtn;
@property (weak, nonatomic) IBOutlet UIView *UntilYesterdayBtn;
@property (weak, nonatomic) IBOutlet UILabel *line;

@property (weak, nonatomic) IBOutlet UILabel *consult_more;
@property (weak, nonatomic) IBOutlet UILabel *consult_one;
@property (weak, nonatomic) IBOutlet UILabel *consult_total;

@property (weak, nonatomic) IBOutlet UILabel *conduct_more;
@property (weak, nonatomic) IBOutlet UILabel *conduct_one;
@property (weak, nonatomic) IBOutlet UILabel *conduct_total;

@property (weak, nonatomic) IBOutlet UILabel *total_more;
@property (weak, nonatomic) IBOutlet UILabel *total_one;
@property (weak, nonatomic) IBOutlet UILabel *total_total;


@end
