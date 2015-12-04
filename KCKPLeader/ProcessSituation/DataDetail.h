//
//  DataDetail.h
//  KCKPLeader
//
//  Created by Siren on 15/12/2.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "JSONModel.h"
#import "NumModel.h"
#import "ProModel.h"
@interface DataDetail : JSONModel
@property (nonatomic, strong) NumModel *num;
@property (nonatomic, strong) ProModel *pro;
@property (nonatomic, strong) NSString *payrat;
@end
