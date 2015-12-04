//
//  ChangePassWordViewController.h
//  KCKPLeader
//
//  Created by Siren on 15/11/26.
//  Copyright © 2015年 程三. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePassWordViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *passOld;

@property (weak, nonatomic) IBOutlet UITextField *passNew;

@property (weak, nonatomic) IBOutlet UITextField *repeatNew;

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@end
