//
//  NewTrafficViewController.h
//  KCKPLeader
//
//  Created by Siren on 15/12/22.
//  Copyright © 2015年 程三. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewTrafficViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UIScrollView *scroll;

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIView *naviView;
@property (nonatomic, strong) NSString *titleStr;
@property (nonatomic, strong) UILabel *titlLab;
@end
