//
//  DataModel.h
//  KCKPLeader
//
//  Created by Siren on 15/12/1.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "JSONModel.h"
#import "VolnumModel.h"
#import "InsnumModel.h"
#import "AllnumModel.h"
#import "ScenumModel.h"
#import "PolnumModel.h"
@interface DataModel : JSONModel
@property (nonatomic, strong) VolnumModel *volnum;
@property (nonatomic, strong) InsnumModel *insnum;
@property (nonatomic, strong) AllnumModel *allnum;
@property (nonatomic, strong) ScenumModel *scenum;
@property (nonatomic, strong) PolnumModel *polnum;
@end
