//
//  OSSCell.m
//  OSS Box
//
//  Created by 玉澤 裕貴 on 2013/03/29.
//  Copyright (c) 2013年 srea. All rights reserved.
//

#import "OSSCell.h"

@implementation OSSCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _starBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_starBtn setImage:[UIImage imageNamed:@"NavBarFavouriteNonActive.png"] forState:UIControlStateNormal];
        [_starBtn setImage:[UIImage imageNamed:@"NavBarFavouriteActive.png"] forState:UIControlStateSelected];
        [_starBtn sizeToFit];
        self.accessoryView = _starBtn;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//
//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    CGRect frame = self.accessoryView.frame;
//    frame.origin.x -= 10;
//    [self.accessoryView setFrame:frame];
//}

@end
