//
//  Util.h
//  KCKPLeader
//
//  Created by 程三 on 15/11/26.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject
+(CGFloat)getUIScreenWidth;
+(CGFloat)getUIScreenHeight;
+(float)getVersion;
+(int)getStatusBarHeight;

+ (NSString*)objectToJson:(NSObject *)object;
+(BOOL) isValidateMobile:(NSString *)mobile;
+(BOOL)isValidateEmail:(NSString *)email;
@end
