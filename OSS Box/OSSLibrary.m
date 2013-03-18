//
//  OSSLibrary.m
//  OSS Box
//
//  Created by tamazawayuuki on 2013/03/16.
//  Copyright (c) 2013年 srea. All rights reserved.
//

#import "OSSLibrary.h"

@implementation OSSLibrary

- (void)setName:(NSString *)name
{
    _name = name;
    [self dataLoadForPlist];
}

- (void)dataLoadForPlist
{
    //MBBox PList
    NSString *path = [[NSBundle mainBundle] pathForResource:_name ofType:@"plist"];
    NSDictionary *libraryData = [NSDictionary dictionaryWithContentsOfFile:path];
    
    _name = [libraryData objectForKey:@"name"];
    _author = [libraryData objectForKey:@"author"];
    _url = [libraryData objectForKey:@"url"];
    _version = [libraryData objectForKey:@"version"];
    _arc = [libraryData objectForKey:@"arc"] ? @"対応" :@"非対応";
    _targetOS = [libraryData objectForKey:@"targetOS"];
    _licenseType = [libraryData objectForKey:@"licenseType"];
    _licenseBody = [libraryData objectForKey:@"licenseBody"];
    _detailText = [libraryData objectForKey:@"detailText"];
    _controller = [libraryData objectForKey:@"controller"];
}

@end
