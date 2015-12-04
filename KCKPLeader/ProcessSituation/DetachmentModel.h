//
//  DetachmentModel.h
//  KCKPLeader
//
//  Created by Siren on 15/12/2.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "JSONModel.h"
#import "DetDataModel.h"
@interface DetachmentModel : JSONModel
@property (nonatomic, strong) NSArray<DetDataModel> *data;
@end
