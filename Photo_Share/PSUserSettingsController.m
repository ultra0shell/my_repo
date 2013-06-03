//
//  PSUserSettingsController.m
//  Photo_Share
//
//  Created by Mr Drg on 3/11/13.
//  Copyright (c) 2013 Mr Drg. All rights reserved.
//

#import "PSUserSettingsController.h"
#import <Parse/Parse.h>

@interface PSUserSettingsController ()
{
    UIImage *testImage;
    NSData *imageData;
}
@end

@implementation PSUserSettingsController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UITabBarItem *item1 = [[UITabBarItem alloc]initWithTitle:@"Settings" image:[UIImage imageNamed:@"tab-icon4"] tag:0];
        [item1 setFinishedSelectedImage:[UIImage imageNamed:@"tab-icon4"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab-icon4"]];
        self.tabBarItem = item1;
        [item1 release];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    testImage = [UIImage imageNamed:@"avatar3.png"];
    imageData = UIImageJPEGRepresentation(testImage, 1);
    
    [self uploadImage];
}

-(void)uploadImage
{
    PFFile *imageFile = [PFFile fileWithData:imageData];
    PFObject *object = [PFObject objectWithClassName:@"Photo"];
    [object setObject:imageFile forKey:@"image_file"];
    [object saveInBackground];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)logOutButtonPressed:(UIButton *)sender
{
    [PFUser logOut];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
