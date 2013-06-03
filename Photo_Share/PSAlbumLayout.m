//
//  PSAlbumLayout.m
//  Photo_Share
//
//  Created by Mr Drg on 3/15/13.
//  Copyright (c) 2013 Mr Drg. All rights reserved.
//

#import "PSAlbumLayout.h"


@interface PSAlbumLayout ()

@end

@implementation PSAlbumLayout


-(void)dealloc
{
    [super dealloc];
}

- (id)init
{
    self = [super init];
    
    if (self) {
        [self setup];
    }
    return self;
}



- (void)setup
{
    self.sectionInset = UIEdgeInsetsMake(22.0f, 22.0f, 13.0f, 22.0f);
    self.itemSize     = CGSizeMake(70.0f, 70.0f);
    self.minimumInteritemSpacing = 10.0f;
    self.minimumLineSpacing      = 20.0f;

}


@end
