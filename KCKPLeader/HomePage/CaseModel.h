//
//  CaseModel.h
//  KCKPLeader
//
//  Created by Siren on 15/12/1.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "JSONModel.h"
#import "DataModel.h"
@interface CaseModel : JSONModel
@property (strong, nonatomic) DataModel *data;
@end
