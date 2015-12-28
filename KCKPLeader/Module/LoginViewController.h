//
//  LoginViewController.h
//  KCKPLeader
//
//  Created by Siren on 15/11/26.
//  Copyright © 2015年 程三. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userField;
@property (weak, nonatomic) IBOutlet UITextField *passField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


@property (weak, nonatomic) IBOutlet UIButton *remindPass;
@property (weak, nonatomic) IBOutlet UIImageView *remOn;

@property (weak, nonatomic) IBOutlet UIImageView *automaticLogImage;

@property (weak, nonatomic) IBOutlet UIButton *automaticLogBtn;


@end
