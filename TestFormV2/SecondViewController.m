//
//  SecondViewController.m
//  TestFormV2
//
//  Created by Conor Linehan on 16/09/2014.
//  Copyright (c) 2014 Conor Linehan. All rights reserved.
//

#import "SecondViewController.h"
#import "AppDelegate.h"

@interface SecondViewController ()

@property (nonatomic,strong) AppDelegate *appDelegate;

-(void)didReceiveDataWithNotification:(NSNotification *)notification;

@property (nonatomic,strong) NSMutableArray *myForms;

@end

@implementation SecondViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    _myForms = [[NSMutableArray alloc] init];
    
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveDataWithNotification:)
                                                 name:@"MCDidReceiveDataNotification"
                                               object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didReceiveDataWithNotification:(NSNotification *)notification
{
    
    MCPeerID *peerID = [[notification userInfo] objectForKey:@"peerID"];
    NSString *peerDisplayName = peerID.displayName;
    
    NSData *receivedData = [[notification userInfo] objectForKey:@"data"];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:receivedData];
    NSDictionary *dictionary = [unarchiver decodeObjectForKey:@"Form"];
    [unarchiver finishDecoding];
    
    NSLog(@"recived %@",dictionary[@"Username"]);
    
    [_myForms addObject:dictionary];
    
    [_tableView reloadData];
    
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_myForms count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Entered");
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    NSDictionary *dictionary = [_myForms objectAtIndex:indexPath.row];
    
    cell.textLabel.text = dictionary[@"Username"];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"showDetailSegue"])
    {
        UINavigationController *navigationController =
        (UINavigationController *)segue.destinationViewController;
        
        FormDetailViewController *controller =
        (FormDetailViewController *)navigationController.topViewController;
        
        NSIndexPath *indexPath = [_tableView indexPathForCell:sender];
        
        controller.form = _myForms[indexPath.row];
    }
    
}

@end
