//
//  OSSCell.m
//  OSS Box
//
//  Created by 玉澤 裕貴 on 2013/03/29.
//  Copyright (c) 2013年 srea. All rights reserved.
//

#import "OSSCell.h"

@interface OSSCell ()

@end

@implementation OSSCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _starBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_starBtn setImage:[UIImage imageNamed:@"NavBarFavouriteNonActive.png"] forState:UIControlStateNormal];
        [_starBtn setImage:[UIImage imageNamed:@"NavBarFavouriteActive.png"] forState:UIControlStateSelected];
        [_starBtn sizeToFit];
        self.accessoryView = _starBtn;
        
        self.detailTextLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.contentView.frame = CGRectMake(0,
                                        0,
                                        self.contentView.frame.size.width - self.accessoryView.frame.size.width,
                                        self.contentView.frame.size.height);

//    CGRect frame = self.accessoryView.frame;
//    frame.origin.x -= 10;
//    [self.accessoryView setFrame:frame];
}

@end
