//
//  BaseViewController.h
//  EProcess
//
//  Created by Siren on 15/11/25.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;

@end
