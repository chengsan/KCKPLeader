//
//  ClaimModel.h
//  KCKPLeader
//
//  Created by Siren on 15/12/2.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "JSONModel.h"
#import "ClaimDataModel.h"
@interface ClaimModel : JSONModel
@property (nonatomic, strong) ClaimDataModel *data;
@end
