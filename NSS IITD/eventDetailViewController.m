//
//  eventDetailViewController.m
//  NSS IITD
//
//  Created by Robin Malhotra on 11/06/14.
//  Copyright (c) 2014 Robin's code kitchen. All rights reserved.
//

#import "eventDetailViewController.h"

@interface eventDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *myTitle;
@property (weak, nonatomic) IBOutlet UILabel *startingTime;
@property (weak, nonatomic) IBOutlet UILabel *endingTime;
@property (weak, nonatomic) IBOutlet UITextView *description;
@property (strong,nonatomic) NSString *event;
@end

@implementation eventDetailViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
    
    NSArray *eventData=[self.event componentsSeparatedByString:@";"];
    
    [self.myTitle setText:[eventData objectAtIndex:0]];
    [self.description setText:[eventData objectAtIndex:1]];
    [self.startingTime setText:[eventData objectAtIndex:2]];
    [self.endingTime setText:[eventData objectAtIndex:3]];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

}


@end
