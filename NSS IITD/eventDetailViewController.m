//
//  eventDetailViewController.m
//  NSS IITD
//
//  Created by Robin Malhotra on 11/06/14.
//  Copyright (c) 2014 Robin's code kitchen. All rights reserved.
//

#import "eventDetailViewController.h"

@interface eventDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *startingTime;
@property (weak, nonatomic) IBOutlet UILabel *endingTime;
@property (weak, nonatomic) IBOutlet UITextView *description;
@property (strong,nonatomic) NSString *event;
@property (weak, nonatomic) IBOutlet UITextField *extraNotes;

@property (retain, nonatomic) NSMutableData *receivedData;
@property (retain, nonatomic) NSURLConnection *connection;
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
- (IBAction)register:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *name=[defaults objectForKey:@"name"];
    NSString *entryNo=[defaults objectForKey:@"entryNo"];
    NSString *emailID=[defaults objectForKey:@"emailID"];
    NSString *phoneNo=[defaults objectForKey:@"phoneNo"];
    
    
    //if there is a connection going on just cancel it.
    [self.connection cancel];
    NSArray *eventData=[self.event componentsSeparatedByString:@";"];
    //initialize new mutable data
    NSMutableData *data = [[NSMutableData alloc] init];
    self.receivedData = data;
    
    NSLog(@"%d",[eventData count]);
    //initialize url that is going to be fetched.
    NSURL *url = [NSURL URLWithString:[eventData objectAtIndex:4]];
    
    
    //initialize a request from url
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[url standardizedURL]];
    
    //set http method
    [request setHTTPMethod:@"POST"];
    //initialize a post data
    //NSString *postData = @"entry.1910052895=iOS&entry.1103196731=vajhcsd&entry.399168322=BJKSVDB&entry.1544699882=kajfnk&entry.554333590=khdsfbvkj";
    NSString *postData=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@&%@=%@&%@=%@",[eventData objectAtIndex:5],name,[eventData objectAtIndex:6],entryNo,[eventData objectAtIndex:7],emailID,[eventData objectAtIndex:8],phoneNo,[eventData objectAtIndex:9],self.extraNotes.text];
    //set request content type we MUST set this value.

    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];

    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    self.connection = connection;
    
    //start the connection
    [connection start];
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"success" message:@"You have beeen registered" delegate:self cancelButtonTitle:@"okay" otherButtonTitles: nil];
    [alert show];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *eventData=[self.event componentsSeparatedByString:@";"];
    [self.navigationItem setTitle:[eventData objectAtIndex:0]];
    [self.description setText:[eventData objectAtIndex:1]];
    [self.startingTime setText:[eventData objectAtIndex:2]];
    [self.endingTime setText:[eventData objectAtIndex:3]];
    
    // Do any additional setup after loading the view.
}
- (IBAction)tap:(id)sender
{
    [self.view endEditing:YES];
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
