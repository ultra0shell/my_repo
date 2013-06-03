//
//  PSAssetsController.h
//  Photo_Share
//
//  Created by Mr Drg on 3/11/13.
//  Copyright (c) 2013 Mr Drg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface PSAssetsController : UICollectionViewController

@property(nonatomic,retain)NSMutableArray *albumAssets;
//@property(nonatomic,retain)NSMutableArray *albumPics;
@property(assign)NSInteger    index;

-(void)prepareGroupForAssets:(ALAssetsGroup *)group;

@end
