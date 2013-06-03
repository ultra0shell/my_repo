//
//  PSDetailViewController.h
//  Photo_Share
//
//  Created by Mr Drg on 3/21/13.
//  Copyright (c) 2013 Mr Drg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface PSDetailViewController : UIViewController <UIScrollViewDelegate>

-(void)prepareElementsForGroup:(ALAssetsGroup *)group;

@property(nonatomic,retain)NSMutableArray *albumPics;

@end
