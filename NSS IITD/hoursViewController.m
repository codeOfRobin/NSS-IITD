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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *URL=@"http://www.nssiitd.in/nsshours/teststudent.php?entry_no=2012TT10951";
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:URL]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error){
                NSString *dataString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"%@",dataString);
                self.dataArray=[dataString componentsSeparatedByString:@";"];
                
                for (NSString *string in self.dataArray) {
                    
                    NSLog(@"%@",string);
                    
                }
                
                NSLog(@"lasdt valiuse is %@",[self.dataArray objectAtIndex:2]);
                [self.hoursLabel setText:[self.dataArray objectAtIndex:4]];
        
            }] resume];
    

    
    
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
