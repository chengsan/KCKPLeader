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
#import "DayPicModel.h"
#import "DayDutModel.h"
#import "DayInsModel.h"
#import "DayCpsModel.h"
@interface ClaimDataModel : JSONModel
@property (nonatomic, strong) PicModel *picnum;//拍照
@property (nonatomic, strong) DutModel *dutnum;//定责
@property (nonatomic, strong) InsModel *insnum;//保险报案
@property (nonatomic, strong) CpsModel *cpsnum;//结案

@property (nonatomic, strong) DayPicModel *daypicnum;//当天拍照
@property (nonatomic, strong) DayDutModel *daydutnum;//当天定责
@property (nonatomic, strong) DayInsModel *dayinsnum;//当天保险报案
@property (nonatomic, strong) DayCpsModel *daycpsnum;//当天结案
@end
