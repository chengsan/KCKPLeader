//
//  DetDataModel.h
//  KCKPLeader
//
//  Created by Siren on 15/12/2.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "JSONModel.h"

@protocol DetDataModel


@end

@interface DetDataModel : JSONModel
@property (nonatomic, strong) NSString *groupcode;
@property (nonatomic, strong) NSString *groupname;
@end
