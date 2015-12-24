//
//  NewDetTodayModel.h
//  KCKPLeader
//
//  Created by Siren on 15/12/23.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "JSONModel.h"

@protocol NewDetTodayModel <NSObject>


@end

@interface NewDetTodayModel : JSONModel
@property (nonatomic, strong) NSString *scenum;
@property (nonatomic, strong) NSString *insnum;
@property (nonatomic, strong) NSString *picnum;
@property (nonatomic, strong) NSString *revnum;
@property (nonatomic, strong) NSString *mannum;
@property (nonatomic, strong) NSString *dounum;
@property (nonatomic, strong) NSString *volnum;
@property (nonatomic, strong) NSString *onenum;
@property (nonatomic, strong) NSString *polnum;
@property (nonatomic, strong) NSString *grouplegal;
@end
