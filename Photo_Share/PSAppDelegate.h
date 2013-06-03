//
//  PSAppDelegate.h
//  Photo_Share
//
//  Created by Mr Drg on 3/11/13.
//  Copyright (c) 2013 Mr Drg. All rights reserved.
//
#import "PSAssetsController.h"
#import <UIKit/UIKit.h>
#import "PSAlbumsCollectionController.h"


@interface PSAppDelegate : UIResponder <UIApplicationDelegate>

-(PSAssetsController*)assetsController;
-(PSAlbumsCollectionController*)albumsController;
@end
