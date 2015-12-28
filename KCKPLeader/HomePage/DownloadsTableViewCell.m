//
//  DownloadsTableViewCell.m
//  KCKPLeader
//
//  Created by OSch on 15/12/25.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "DownloadsTableViewCell.h"
#import "AppDelegate.h"
@implementation DownloadsTableViewCell

- (void)awakeFromNib {
    
    [AppDelegate storyBoradAutoLay:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
