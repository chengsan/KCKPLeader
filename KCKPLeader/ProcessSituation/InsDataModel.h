//
//  InsDataModel.h
//  KCKPLeader
//
//  Created by Siren on 15/12/2.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "JSONModel.h"
#import "CompanyModel.h"
@interface InsDataModel : JSONModel
@property (nonatomic, strong) NSArray<CompanyModel> *data;
@end
