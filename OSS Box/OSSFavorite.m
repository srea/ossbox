//
//  OSSFavorite.m
//  OSS Box
//
//  Created by 玉澤 裕貴 on 2013/03/29.
//  Copyright (c) 2013年 srea. All rights reserved.
//

#import "OSSFavorite.h"

@implementation OSSFavorite

+ (BOOL)getStatusWitLibraryName:(NSString *)name
{
    BOOL status;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([ud objectForKey:name]) {
        status = [ud boolForKey:name];
        return status;
    }
    return NO;
}

+ (void)saveToStatus:(BOOL)status andLibraryName:(NSString *)name
{
    // statusに応じてなんかやる。
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setBool:status forKey:name];
    [ud synchronize];
    return;
}

@end
