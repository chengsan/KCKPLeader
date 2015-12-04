//
//  CompanyModel.h
//  KCKPLeader
//
//  Created by Siren on 15/12/2.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "JSONModel.h"

@protocol CompanyModel <NSObject>


@end

@interface CompanyModel : JSONModel
@property (nonatomic, copy) NSString *insname;
@property (nonatomic, copy) NSString *payrat;
@property (nonatomic, strong) NSString *cpsnum;
@property (nonatomic, copy) NSString *inscode;
@property (nonatomic, copy) NSString *cpsave;
@property (nonatomic, copy) NSString *scorat;
@end
