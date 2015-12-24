//
//  NewDetDataModel.h
//  KCKPLeader
//
//  Created by Siren on 15/12/23.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "JSONModel.h"
#import "NewDetTodayModel.h"
#import "NewDetYesModel.h"

@interface NewDetDataModel : JSONModel

@property (nonatomic, strong) NSArray<NewDetTodayModel> *today;
@property (nonatomic, strong) NSArray<NewDetYesModel> *yesterday;

@end
