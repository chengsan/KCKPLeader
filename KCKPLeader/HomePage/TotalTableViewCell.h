//
//  TotalTableViewCell.h
//  KCKPLeader
//
//  Created by Siren on 15/11/25.
//  Copyright © 2015年 程三. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppModel.h"
@interface TotalTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *attentionLab;
@property (weak, nonatomic) IBOutlet UILabel *installLab;

-(void)setUiWithInfo:(AppModel *)model;
@end
