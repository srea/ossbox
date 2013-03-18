//
//  Created by Matt Greenfield on 24/05/12
//  Copyright (c) 2012 Big Paua. All rights reserved
//  http://bigpaua.com/
//

#import <Foundation/Foundation.h>

@interface MGButton : UIButton

@property (nonatomic, copy) NSString *toUrl;
@property (nonatomic, copy) NSString *toPlist;
@property (nonatomic, copy) NSString *toSelector;
@property (nonatomic, assign) CGFloat maxWidth;
@property (nonatomic, retain) id misc;

@end
