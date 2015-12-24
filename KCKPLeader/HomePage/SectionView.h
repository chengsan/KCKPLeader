//
//  SectionView.h
//  KCKPLeader
//
//  Created by Siren on 15/12/1.
//  Copyright © 2015年 程三. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SectionViewDelegate <NSObject>

@optional
-(void)sectionClick;

@end

@interface SectionView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *count;
@property (nonatomic, weak) id<SectionViewDelegate> delegate;
@end
