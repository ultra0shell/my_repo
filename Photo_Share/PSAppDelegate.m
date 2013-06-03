//
//  PSAppDelegate.m
//  Photo_Share
//
//  Created by Mr Drg on 3/11/13.
//  Copyright (c) 2013 Mr Drg. All rights reserved.
//

#import "PSAppDelegate.h"

#import "PSAlbumsCollectionController.h"

#import "PSFriendsTableController.h"

#import "PSRequestsTableController.h"

#import "PSUserSettingsController.h"

#import "PSAlbumLayout.h"

#import "PSAssetsController.h"

#import <Parse/Parse.h>

#import "PSLoginViewController.h"

#import <FacebookSDK/FacebookSDK.h>


@interface PSAppDelegate ()
{
    UIWindow *window;
    PSAssetsController *assetsController;
    PSAlbumsCollectionController *albumsController;
    PSLoginViewController *loginController;
    PSUserSettingsController     *userSettings;
}
@end



@implementation PSAppDelegate


- (void)dealloc
{
    [window release];
    [assetsController release];
    [super dealloc];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    window = [ [UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    
    [Parse setApplicationId:@"czJEyuNkNri3ILsLbImDIWA6QeWEW6UGL0brgzjz" clientKey:@"iMV0K2kikp7G96OQma4QbPQNWkuyOJ42USpO5Uc3"];
    [PFFacebookUtils initializeFacebook];
    
    PSAlbumLayout *albumLayout = [[[PSAlbumLayout alloc]init]autorelease];
    
    albumsController   = [[[PSAlbumsCollectionController alloc]initWithCollectionViewLayout:albumLayout]autorelease];
    loginController = [[PSLoginViewController alloc]initWithNibName:@"PSLoginViewController" bundle:nil];
    
    
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.itemSize = CGSizeMake(70,70);
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.minimumLineSpacing = 5;
    
    assetsController = [[PSAssetsController alloc]initWithCollectionViewLayout:flowLayout];
    [flowLayout release];
    
    PSFriendsTableController     *friendsController  = [[[PSFriendsTableController alloc]initWithNibName:@"PSFriendsTableController" bundle:nil]autorelease];
    
    PSRequestsTableController    *requestsController = [[[PSRequestsTableController alloc]initWithNibName:@"PSRequestsTableController" bundle:nil]autorelease];
    
    userSettings  = [[PSUserSettingsController alloc]initWithNibName:@"PSUserSettingsController" bundle:nil];
    
    UINavigationController       *navController      = [[UINavigationController alloc]initWithRootViewController:albumsController];
    UIImage *navBarImage = [UIImage imageNamed:@"menubar.png"];
    
    [[UINavigationBar appearance] setBackgroundImage:navBarImage forBarMetrics:UIBarMetricsDefault];
    
    NSArray *tabBarViews = [NSArray arrayWithObjects:navController,friendsController,requestsController,userSettings, nil];
    
    UITabBarController *tabController = [[UITabBarController alloc]init];
    [tabController setViewControllers:tabBarViews];
    [tabController.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar.png"]];
    [tabController.tabBar setSelectionIndicatorImage:[UIImage imageNamed:@"tabbar-active.png"]];
    
     window.rootViewController = tabController;
    
    [window makeKeyAndVisible];
    [tabController release];
    
    return YES;
    
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [PFFacebookUtils handleOpenURL:url];
}

-(PSAssetsController*)assetsController
{
    return assetsController;
}

-(PSAlbumsCollectionController*)albumsController
{
    return albumsController;
}

-(PSUserSettingsController*)settingsController
{
    return userSettings;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [FBSession.activeSession handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{

    [FBSession.activeSession close];
}

@end
