//
//  OSSGlobal.m
//  OSS Box
//
//  Created by 玉澤 裕貴 on 2013/03/30.
//  Copyright (c) 2013年 srea. All rights reserved.
//

#import "OSSGlobal.h"
#import "OSSFavorite.h"

@implementation OSSGlobal

+ (NSMutableArray *)getMenuPlist
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"OSSListDev" ofType:@"plist"];
    return [NSMutableArray arrayWithContentsOfFile:path];
}

+ (NSMutableArray *)getMenuPlistStar
{
    NSMutableArray *starArray = [NSMutableArray array];
    NSMutableArray *object = [[OSSGlobal getMenuPlist] mutableCopy];
    for (NSMutableDictionary*section in [object reverseObjectEnumerator]) {
        [starArray addObject:section];
        for (NSMutableDictionary*row in [[section objectForKey:@"rows"] reverseObjectEnumerator]) {
            NSUInteger num = 0;
            BOOL flag = [OSSFavorite getStatusWitLibraryName:[row objectForKey:@"name"]];
            if (!flag) {
                [[section objectForKey:@"rows"] removeObject:row];
            }
            num++;
        }
        if ([[section objectForKey:@"rows"] count] <= 0) {
            [starArray removeObject:section];
        }
    }
    return (NSMutableArray*)[[starArray reverseObjectEnumerator] allObjects];
}

+ (NSMutableArray *)getMenuPlistWithString:(NSString *)string
{
    NSMutableArray *starArray = [NSMutableArray array];
    NSMutableArray *object = [[OSSGlobal getMenuPlist] mutableCopy];
    for (NSMutableDictionary*section in [object reverseObjectEnumerator]) {
        [starArray addObject:section];
        for (NSMutableDictionary*row in [[section objectForKey:@"rows"] reverseObjectEnumerator]) {
            NSUInteger num = 0;
            NSRange range = [[row objectForKey:@"name"] rangeOfString:string options:NSCaseInsensitiveSearch];
            if(range.length <= 0) {
                [[section objectForKey:@"rows"] removeObject:row];
            }
            num++;
        }
        if ([[section objectForKey:@"rows"] count] <= 0) {
            [starArray removeObject:section];
        }
    }
    return (NSMutableArray*)[[starArray reverseObjectEnumerator] allObjects];
}

@end
