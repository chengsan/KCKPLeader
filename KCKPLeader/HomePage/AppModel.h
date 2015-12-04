//
//  AppModel.h
//  KCKPLeader
//
//  Created by Siren on 15/12/1.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "JSONModel.h"
#import "AppDataModel.h"
@interface AppModel : JSONModel
@property (nonatomic, strong) AppDataModel *data;
@end
