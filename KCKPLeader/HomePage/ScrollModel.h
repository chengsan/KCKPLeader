//
//  ScrollModel.h
//  KCKPLeader
//
//  Created by Siren on 15/12/1.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "JSONModel.h"
#import "ScrollDataModel.h"
@interface ScrollModel : JSONModel
@property (nonatomic, strong) ScrollDataModel *data;
@end
