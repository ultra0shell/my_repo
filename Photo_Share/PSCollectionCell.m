//
//  PSCollectionCell.m
//  Photo_Share
//
//  Created by Mr Drg on 3/18/13.
//  Copyright (c) 2013 Mr Drg. All rights reserved.
//

#import "PSCollectionCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation PSCollectionCell


-(void)dealloc
{
    [_albumImage release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _albumImage = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, frame.size.width, frame.size.height)];
//        _albumImage.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        
        [self.contentView addSubview:_albumImage];
        self.contentView.layer.cornerRadius = 10;
 
//        self.contentView.layer.shadowOffset  = CGSizeMake(5, 10);
//        self.contentView.layer.shadowColor   = [[UIColor blackColor] CGColor];
//        self.contentView.layer.shadowRadius  = 2;
//        self.contentView.layer.shadowOpacity = .55f;
//        
//        CGRect shadowFrame = self.contentView.layer.bounds;
//        CGPathRef shadowPath = [UIBezierPath bezierPathWithRect:shadowFrame].CGPath;
//        self.contentView.layer.shadowPath = shadowPath;

    }
    return self;
}



@end
