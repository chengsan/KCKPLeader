//
//  ClaimDetailModel.h
//  KCKPLeader
//
//  Created by Siren on 15/12/2.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "JSONModel.h"
#import "DataDetail.h"
@interface ClaimDetailModel : JSONModel
@property (nonatomic, strong) DataDetail *data;
@end
