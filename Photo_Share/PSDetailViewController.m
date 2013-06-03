//
//  PSDetailViewController.m
//  Photo_Share
//
//  Created by Mr Drg on 3/21/13.
//  Copyright (c) 2013 Mr Drg. All rights reserved.
//

#import "PSDetailViewController.h"
#import "PSAssetsController.h"
#import "PSAlbumsCollectionController.h"
#import "PSAppDelegate.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface PSDetailViewController ()
{
    UIImage                  *smallImage;
    PSAssetsController       *assetsController;
    IBOutlet UIScrollView    *scrollingView;
    NSMutableArray           *pageViews;
}
-(void)loadPage:(NSInteger)pageIndex;
-(void)removePage:(NSInteger)pageIndex;
-(void)loadVisiblePages;

@end

@implementation PSDetailViewController


-(void)dealloc
{
    [pageViews release];
    [_albumPics release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil

{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        pageViews  = [NSMutableArray new];
        _albumPics = [NSMutableArray new];
        
        PSAppDelegate *delegate = (PSAppDelegate *)[[UIApplication sharedApplication] delegate];
        assetsController = [delegate assetsController];
      
     }
    return self;
}


-(void)prepareElementsForGroup:(ALAssetsGroup *)group
{
//    [_albumPics removeAllObjects];
    
    void (^assetEnumerator)(ALAsset *, NSUInteger, BOOL *) = ^(ALAsset *result, NSUInteger index, BOOL *stop)
    {
       if (result != NULL) {
    
            ALAssetRepresentation *rep = [result defaultRepresentation];
            CGImageRef ref = [rep fullScreenImage];
            UIImage *image = [UIImage imageWithCGImage:ref];            
            
               [_albumPics addObject:image];
                   NSLog(@"%@ This is my array",_albumPics);
      }
        
  };
    
    [group enumerateAssetsUsingBlock:assetEnumerator];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    for (int i = 0; i < _albumPics.count ; ++i) {
        [pageViews addObject:[NSNull null]];
    }
    
//    NSLog(@"%@",assetsController);
//    detailImageView.image = smallImage;
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//        
//        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
//       
//        ALAsset *asset = [assetsController.albumAssets objectAtIndex:assetsController.index];
//        ALAssetRepresentation *representation = [asset defaultRepresentation];
//        CGImageRef fullrep = [representation fullScreenImage];
//        UIImage *bigImage = [[UIImage alloc] initWithCGImage:fullrep];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            detailImageView.contentMode = UIViewContentModeScaleAspectFill;
//            detailImageView.image = bigImage;
//            [bigImage release];
//            
//        });
//        
//        [pool release];
//        NSLog(@"dnsjkalndjksmndkasmdkls;adjklsdjkanfjdhbgfhjlbsnlkfjdkls;fjklds");
//    
//    });
 
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    NSLog(@"%d",_albumPics.count);
    CGSize pagesScrollViewSize = scrollingView.frame.size;
    scrollingView.contentSize = CGSizeMake(pagesScrollViewSize.width * _albumPics.count,
                                           pagesScrollViewSize.height);
     
    [self loadVisiblePages];
}

-(void)loadPage:(NSInteger)pageIndex
{

    if (pageIndex < 0 || pageIndex >= _albumPics.count) {
        return;
    }
    
    UIView *pageView = [pageViews objectAtIndex:pageIndex];
    
    if ((NSNull*)pageView == [NSNull null]) {
        CGRect frame = scrollingView.bounds;
        frame.origin.x = frame.size.width * pageIndex;
        frame.origin.y = 0.0f;
     
        UIImageView *newPageView = [[UIImageView alloc] initWithImage:[_albumPics objectAtIndex:pageIndex]];
            newPageView.contentMode = UIViewContentModeScaleAspectFit;
            newPageView.frame = frame;
            [scrollingView addSubview:newPageView];
        
            [pageViews replaceObjectAtIndex:pageIndex withObject:newPageView];
            [newPageView release];
 
    }
}

-(void)removePage:(NSInteger)pageIndex
{

    if (pageIndex < 0 || pageIndex >= _albumPics.count) {
        return;
    }
    
    UIView *pageView = [pageViews objectAtIndex:pageIndex];
    
    if ((NSNull*)pageView != [NSNull null]) {
        [pageView removeFromSuperview];
        [pageViews replaceObjectAtIndex:pageIndex withObject:[NSNull null]];
    }
}

- (void)loadVisiblePages
{
   
    CGFloat pageWidth = scrollingView.bounds.size.width;
    NSInteger page = (scrollingView.contentOffset.x / pageWidth);

    NSInteger firstPage = page - 1;
    NSInteger lastPage  = page + 1;
    
    for (NSInteger i=0; i<firstPage; i++) {
        [self removePage:i];
    }
	
    for (NSInteger i=firstPage; i<=lastPage; i++) {
        [self loadPage:i];
    }
	
    for (NSInteger i=lastPage+1; i<_albumPics.count; i++) {
        [self removePage:i];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self loadVisiblePages];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
