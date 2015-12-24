//
//  NewDetModel.h
//  KCKPLeader
//
//  Created by Siren on 15/12/23.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "JSONModel.h"
#import "NewDetDataModel.h"

@interface NewDetModel : JSONModel
@property (nonatomic, strong) NewDetDataModel *data;
@end
