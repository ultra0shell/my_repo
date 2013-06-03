//
//  PSLoginViewController.m
//  Photo_Share
//
//  Created by ultra0shell on 6/3/13.
//  Copyright (c) 2013 Mr Drg. All rights reserved.
//

#import "PSLoginViewController.h"
#import <Parse/Parse.h>
#import "PSUserSettingsController.h"
#import "PSAppDelegate.h"

@interface PSLoginViewController ()
{
    
    IBOutlet UIButton *loginButton;
    IBOutlet UIActivityIndicatorView *activity;
    PSUserSettingsController *userSettingsController;
    PSAppDelegate *delegate;
}
@end

@implementation PSLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
//        delegate =(PSAppDelegate*)[[UIApplication sharedApplication]delegate];
//        userSettingsController = [delegate settingsController];
//        
//        [loginButton addTarget:self action:@selector(logInButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    delegate =(PSAppDelegate*)[[UIApplication sharedApplication]delegate];
    userSettingsController = [delegate settingsController];
    
    [loginButton addTarget:self action:@selector(logInButtonAction:) forControlEvents:UIControlEventTouchUpInside];

}

-(void)logInButtonAction:(UIButton*)sender
{
    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location"];
    
    // Login PFUser using facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        [activity stopAnimating]; // Hide loading indicator
        
        if (!user) {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:@"Uh oh. The user cancelled the Facebook login." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:[error description] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            }
        } else if (user.isNew) {
            NSLog(@"User with facebook signed up and logged in!");
           self.tabBarController.selectedIndex = 3;
        } else {
            NSLog(@"User with facebook logged in!");
            self.tabBarController.selectedIndex = 3;
        }
    }];
    
    [activity startAnimating]; // Show loading indicator until login is finished
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [loginButton release];
    [activity release];
    [super dealloc];
}
@end
