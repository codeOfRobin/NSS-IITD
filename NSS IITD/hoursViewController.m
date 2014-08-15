//
//  hoursViewController.m
//  NSS IITD
//
//  Created by Robin Malhotra on 22/05/14.
//  Copyright (c) 2014 Robin's code kitchen. All rights reserved.
//

#import "hoursViewController.h"

@interface hoursViewController ()
@property (strong, nonatomic) IBOutlet UILabel *hoursLabel;
@property (strong,nonatomic) NSArray *dataArray;
@end

@implementation hoursViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)checkHours:(id)sender
{
    NSString *preURL=@"http://nss.iitd.ac.in/nsshrs/index.php/hours-json?entry=";
    NSString *entryno=[[NSUserDefaults standardUserDefaults] stringForKey:@"entryNo"];
    NSString *URL=[NSString stringWithFormat:@"%@%@",preURL,entryno];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:URL]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error){
                if (data!=nil)
                {
                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    NSLog(@"%@",newStr);
                    
                    NSDictionary *jsonDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    if ([jsonDict isKindOfClass:[NSDictionary class]] )
                    {
                        NSString *hours=[[NSString alloc] init];
                        hours=[NSString stringWithFormat:@"%@",[jsonDict objectForKey:@"hours"]];
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"hours" message:hours delegate:self cancelButtonTitle:@"okay" otherButtonTitles:nil];
                        [alert show];
                        });
                    }
                    
                }
            }] resume];


}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.hoursLabel setHidden:YES];
    
    
    // Do any additional setup after loading the view.
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
