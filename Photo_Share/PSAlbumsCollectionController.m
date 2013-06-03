//
//  PSAlbumsCollectionController.m
//  Photo_Share
//
//  Created by Mr Drg on 3/11/13.
//  Copyright (c) 2013 Mr Drg. All rights reserved.
//

#import "PSAlbumsCollectionController.h"
#import "PSAlbumLayout.h"
#import "PSCollectionCell.h"
#import <QuartzCore/QuartzCore.h>
#import "PSAppDelegate.h"
#import "PSAssetsController.h"


@interface PSAlbumsCollectionController ()
{
    PSAppDelegate  *appDelegate;
    PSAssetsController *assetsController;
}
@end

@implementation PSAlbumsCollectionController

-(id)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITabBarItem *item1 = [[UITabBarItem alloc]initWithTitle:@"Albums" image:[UIImage imageNamed:@"tab-icon1"] tag:0];
    [item1 setFinishedSelectedImage:[UIImage imageNamed:@"tab-icon1"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab-icon1"]];
    self.tabBarItem = item1;
    [item1 release];
    
    _mediaLibrary = [ALAssetsLibrary new];
    _mediaGallery = [NSMutableArray  new];

    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default-568h@2x.png"]];
    [self.collectionView setBackgroundView:background];
    [background release];
    [self.collectionView registerClass:[PSCollectionCell class] forCellWithReuseIdentifier:@"myCell"];
    
    void (^assetGroupEnumerator)(ALAssetsGroup *, BOOL *) =  ^(ALAssetsGroup *group, BOOL *stop)
    {
        if (group) {

            [_mediaGallery addObject: group];
        }
        [self.collectionView reloadData];
    };
    
    [_mediaLibrary enumerateGroupsWithTypes: ALAssetsGroupAlbum usingBlock:assetGroupEnumerator                      
                                                              failureBlock: ^(NSError *error)
     {
         NSLog(@"Failure");
     }];

}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _mediaGallery.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    appDelegate= (PSAppDelegate *)[[UIApplication sharedApplication] delegate];
    assetsController = [appDelegate assetsController];
    
    PSCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    
    ALAssetsGroup *group  = [_mediaGallery objectAtIndex:indexPath.row];
    CGImageRef imgRef     = [group posterImage];
    UIImage *imgFromRef   = [UIImage imageWithCGImage:imgRef];
  
    cell.albumImage.image = imgFromRef;
 
    return cell;
    
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _group  = [_mediaGallery objectAtIndex:indexPath.row];

    [self.navigationController pushViewController:assetsController animated:YES];
    [assetsController prepareGroupForAssets:_group];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_mediaGallery        release];
    [_mediaLibrary        release];
    [super dealloc];
}

@end
