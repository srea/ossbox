//
//  OSSLibrary.h
//  OSS Box
//
//  Created by tamazawayuuki on 2013/03/16.
//  Copyright (c) 2013年 srea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OSSLibrary : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *targetOS;
@property (nonatomic, strong) NSString *arc;
@property (nonatomic, strong) NSString *licenseType;
@property (nonatomic, strong) NSString *licenseBody;
@property (nonatomic, strong) NSString *detailText;
@property (nonatomic, strong) NSString *controller;

@end
