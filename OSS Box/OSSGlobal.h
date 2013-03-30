//
//  OSSGlobal.h
//  OSS Box
//
//  Created by 玉澤 裕貴 on 2013/03/30.
//  Copyright (c) 2013年 srea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OSSGlobal : NSObject
+ (NSMutableArray *)getMenuPlist;
+ (NSMutableArray *)getMenuPlistStar;
+ (NSMutableArray *)getMenuPlistWithString:(NSString*)string;
@end
