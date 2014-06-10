//
//  eventViewController.m
//  NSS IITD
//
//  Created by Robin Malhotra on 10/06/14.
//  Copyright (c) 2014 Robin's code kitchen. All rights reserved.
//

#import "eventViewController.h"

@interface eventViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong,nonatomic) NSMutableArray *events;
@end

@implementation eventViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.events=[[NSMutableArray alloc]init];
    [self.segmentedControl addTarget:self
                         action:@selector(pickOne:)
               forControlEvents:UIControlEventValueChanged];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView reloadData];
    
    
    NSString *URL=@"http://localhost/nss/upcoming_events.php";
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:URL]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error){
                NSString *dataString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"%@",dataString);

                NSArray *dataArray=[dataString componentsSeparatedByString:@"break"];
                [self.events removeAllObjects];
                
                for (NSString *string in dataArray)
                {
                    [self.events addObject:string];
                    
                }
                [self.events removeLastObject];
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            }] resume];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pickOne:(UISegmentedControl *)segmentedControl
{
    if(segmentedControl.selectedSegmentIndex==0)
    {
        NSString *URL=@"http://localhost/nss/upcoming_events.php";
        
        NSURLSession *session = [NSURLSession sharedSession];
        [[session dataTaskWithURL:[NSURL URLWithString:URL]
                completionHandler:^(NSData *data,
                                    NSURLResponse *response,
                                    NSError *error){
                    NSString *dataString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    
                    NSArray *dataArray=[dataString componentsSeparatedByString:@"break"];
                    [self.events removeAllObjects];

                    for (NSString *string in dataArray)
                    {
                        [self.events addObject:string];
                        
                    }
                    [self.events removeLastObject];
                    
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView reloadData];
                    });
                }] resume];
    }
    
    else if (segmentedControl.selectedSegmentIndex==1)
    {
        NSString *URL=@"http://localhost/nss/current_events.php";
        
        NSURLSession *session = [NSURLSession sharedSession];
        [[session dataTaskWithURL:[NSURL URLWithString:URL]
                completionHandler:^(NSData *data,
                                    NSURLResponse *response,
                                    NSError *error){
                    NSString *dataString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    NSLog(@"%@",dataString);
                    NSArray *dataArray=[dataString componentsSeparatedByString:@"break"];
                    [self.events removeAllObjects];
                    
                    for (NSString *string in dataArray)
                    {
                        [self.events addObject:string];
                        
                    }
                    [self.events removeLastObject];
                    
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView reloadData];
                    });
                }] resume];
    }
    
    
}

//-(NSMutableArray *)getArrayFromString
//{
//    
//}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.events count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eventCell" forIndexPath:indexPath];
    UILabel *nameLabel=(UILabel *)[cell.contentView viewWithTag:1];
    UILabel *STLabel=(UILabel *)[cell.contentView viewWithTag:2];
    UILabel *ETLabel=(UILabel *)[cell.contentView viewWithTag:3];
    
    NSString *eventString=[self.events objectAtIndex:indexPath.row];
    NSArray *eventData=[eventString componentsSeparatedByString:@";"];
    
    [nameLabel setText:[eventData objectAtIndex:0]];
  
    [STLabel setText:[eventData objectAtIndex:2]];
    [ETLabel setText:[eventData objectAtIndex:3]];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    NSString *event=[self.events objectAtIndex:path.row];
    [segue.destinationViewController setValue:event forKey:@"event"];
    
}


@end
