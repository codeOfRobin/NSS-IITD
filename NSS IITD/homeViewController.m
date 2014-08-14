//
//  homeViewController.m
//  NSS IITD
//
//  Created by Robin Malhotra on 14/06/14.
//  Copyright (c) 2014 Robin's code kitchen. All rights reserved.
//

#import "homeViewController.h"
#import "KASlideShow.h"
@interface homeViewController ()
@property (weak, nonatomic) IBOutlet KASlideShow *slides;

@end

@implementation homeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.slides addImagesFromResources:@[@"a",@"b",@"c",@"d"]];
    [self.slides setDelay:1];
    [self.slides setTransitionType:KASlideShowTransitionSlide];
    [self.slides setImagesContentMode:UIViewContentModeScaleAspectFill];
    [self.slides start];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"])
    {
        // app already launched
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Thank You" message:@"Thank you for downloading our app! For one touch registration, please fill in your details. You can fill them in later as well in the 'User Details' tab in the app later" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        [alert show];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.tabBarController setSelectedIndex:2];
        // This is the first launch ever
        
        
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
