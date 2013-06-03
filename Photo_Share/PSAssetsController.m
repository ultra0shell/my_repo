//
//  PSAssetsController.m
//  Photo_Share
//
//  Created by Mr Drg on 3/11/13.
//  Copyright (c) 2013 Mr Drg. All rights reserved.
//

#import "PSAssetsController.h"
#import "PSAssetsCell.h"
#import "PSDetailViewController.h"
#import "PSAlbumsCollectionController.h"
#import "PSAppDelegate.h"

@interface PSAssetsController ()
{
    ALAssetsLibrary *assetsLibrary;
    UIImage *img;
    PSAlbumsCollectionController *albumsCollectionController;
}
@end

@implementation PSAssetsController

-(void)dealloc
{
    [_albumAssets release];
    [assetsLibrary release];
    [super dealloc];
}

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
    _albumAssets  = [NSMutableArray new];
    assetsLibrary = [ALAssetsLibrary new];
    
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default-568h@2x.png"]];
    [self.collectionView setBackgroundView:background];
    
    [background release];
    
    NSLog(@ "dsklanjdskaldfjkns");
    
    [self.collectionView registerClass:[PSAssetsCell class] forCellWithReuseIdentifier:@"cell"];
    
//    void (^assetEnumerator)( ALAsset *, NSUInteger, BOOL *) = ^(ALAsset *result, NSUInteger index, BOOL *stop)
//    {
//        if (result != NULL)
//        {
//            NSLog(@"See Asset: %@", result);
//            
//            [_albumPics addObject:result];
//        }
//    };
//    NSLog(@"%d", _albumPics.count);
//    void (^assetGroupEnumerator)( ALAssetsGroup *, BOOL *) =  ^(ALAssetsGroup *group, BOOL *stop)
//    {
//        if(group != nil)
//        {
//            [group enumerateAssetsUsingBlock: assetEnumerator];
//        }
//        [self.collectionView reloadData];
//    };
//    
//    [assetsLibrary enumerateGroupsWithTypes: ALAssetsGroupAlbum
//                                 usingBlock: assetGroupEnumerator
//                               failureBlock: ^(NSError *error)
//     {
//         NSLog(@"Failure");
//     }];
}

-(void)prepareGroupForAssets:(ALAssetsGroup *)group
{
     
    [_albumAssets removeAllObjects];
    
    void (^assetEnumerator)(ALAsset *, NSUInteger, BOOL *) = ^(ALAsset *result, NSUInteger index, BOOL *stop)
    {
        if (result != NULL) {
             [_albumAssets addObject: result];
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^ {
//            ALAssetRepresentation *rep = [result defaultRepresentation];
//            CGImageRef ref = [rep fullScreenImage];
//            UIImage *image = [UIImage imageWithCGImage:ref];
//            [_albumPics addObject:image];
//           });
    }
         
        [self.collectionView reloadData];
};
    
    [group enumerateAssetsUsingBlock: assetEnumerator];
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"%lu", (unsigned long)_albumAssets.count);
   return _albumAssets.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    PSAssetsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    ALAsset *asset = [_albumAssets objectAtIndex:indexPath.row];
    CGImageRef refFromAsset = [asset thumbnail];
    UIImage *finalImage = [UIImage imageWithCGImage:refFromAsset];

    cell.assetImageView.image = finalImage;
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _index = indexPath.row;
    
//    ALAsset *asset = [_albumAssets objectAtIndex:indexPath.row];
//    
//    CGImageRef refFromAsset = [asset thumbnail];
//    
//    UIImage *smallImg = [UIImage imageWithCGImage:refFromAsset];
    
    PSAppDelegate *delegate = (PSAppDelegate *)[[UIApplication sharedApplication] delegate];
    albumsCollectionController = [delegate albumsController];

    PSDetailViewController *detailController = [[PSDetailViewController alloc]initWithNibName:@"PSDetailViewController" bundle:nil];
    
    [detailController prepareElementsForGroup:albumsCollectionController.group];
    [self.navigationController pushViewController:detailController animated:YES];
    [detailController release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
