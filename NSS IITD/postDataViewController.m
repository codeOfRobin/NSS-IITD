//
//  postDataViewController.m
//  NSS IITD
//
//  Created by Robin Malhotra on 23/05/14.
//  Copyright (c) 2014 Robin's code kitchen. All rights reserved.
//

#import "postDataViewController.h"

@interface postDataViewController ()

@end

@implementation postDataViewController

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
    NSString *URL=@"http://www.nssiitd.in/Android/exampl.php";
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:URL]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error){
                NSString *dataString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                NSLog(@"%@",dataString);

                
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
