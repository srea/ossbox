//
//  OSSFavorite.h
//  OSS Box
//
//  Created by 玉澤 裕貴 on 2013/03/29.
//  Copyright (c) 2013年 srea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OSSFavorite : NSObject
+ (BOOL) getStatusWitLibraryName:(NSString*)name;
+ (void) saveToStatus:(BOOL)status andLibraryName:(NSString*)name;
@end
