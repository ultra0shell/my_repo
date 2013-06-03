//
//  PSAlbumsCollectionController.h
//  Photo_Share
//
//  Created by Mr Drg on 3/11/13.
//  Copyright (c) 2013 Mr Drg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSAssetsController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface PSAlbumsCollectionController : UICollectionViewController 

@property(nonatomic,retain) ALAssetsLibrary *mediaLibrary;
@property(nonatomic,retain) NSMutableArray  *mediaGallery;
@property(nonatomic,retain) ALAssetsGroup   *group;
@end
