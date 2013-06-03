//
//  PSAssetsCell.m
//  Photo_Share
//
//  Created by Mr Drg on 3/20/13.
//  Copyright (c) 2013 Mr Drg. All rights reserved.
//

#import "PSAssetsCell.h"

@implementation PSAssetsCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      _assetImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, frame.size.width, frame.size.height)];
        [self.contentView addSubview:_assetImageView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
