//
//  ClaimDataModel.h
//  KCKPLeader
//
//  Created by Siren on 15/12/2.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "JSONModel.h"
#import "PicModel.h"
#import "DutModel.h"
#import "InsModel.h"
#import "CpsModel.h"
@interface ClaimDataModel : JSONModel
@property (nonatomic, strong) PicModel *picnum;
@property (nonatomic, strong) DutModel *dutnum;
@property (nonatomic, strong) InsModel *insnum;
@property (nonatomic, strong) CpsModel *cpsnum;
@end
