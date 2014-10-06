//
//  FirstViewController.m
//  TestFormV2
//
//  Created by Conor Linehan on 16/09/2014.
//  Copyright (c) 2014 Conor Linehan. All rights reserved.
//

#import "FirstViewController.h"
#import "AppDelegate.h"

@interface FirstViewController ()

@property (nonatomic, strong) AppDelegate *appDelegate;

-(void)sendMyForm;
-(void)didReceiveDataWithNotification:(NSNotification *)notification;

@property (nonatomic,strong) NSDictionary *myForm;

@property (nonatomic,strong) NSArray *teamNames;
@property (nonatomic,strong) NSArray *countryNames;
@property (nonatomic,strong) NSArray *letterNames;
@property (nonatomic,strong) UIPickerView *teamPicker;
@property (nonatomic,strong) UIPickerView *countryPicker;
@property (nonatomic,strong) UIPickerView *letterPicker;






@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    _username.delegate = self;
    
    
    _teamPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    _countryPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    _letterPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    _country.inputView = _countryPicker;
    _teamName.inputView = _teamPicker;
    _matrixLetter.inputView = _letterPicker;
    
    _teamPicker.dataSource = self;
    _teamPicker.delegate = self;
    _countryPicker.dataSource = self;
    _countryPicker.delegate = self;
    _letterPicker.dataSource = self;
    _letterPicker.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveDataWithNotification:)
                                                 name:@"MCDidReceiveDataNotification"
                                               object:nil];
    
    _teamNames = @[@"Alpha",@"Beta",@"Charlie",@"Delta",@"Epsilon"];
    _letterNames = @[@"A",@"B",@"C",@"D",@"E",@"F"];
    _countryNames = @[@"AUS", @"AUT", @"BEL", @"CZE", @"FRA", @"GBR", @"GER", @"KUW", @"LUX", @"NED", @"NOR", @"RUS", @"SUI", @"USA"];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark textField delegates

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark IBAction Methods

-(IBAction)sendMessage:(id)sender
{
    [self fillForm];
    [self sendMyForm];
}

-(IBAction)cancelMessage:(id)sender
{
    
}

#pragma mark SendForm

-(void)fillForm
{
    _myForm = @{@"Username": self.username.text,
                @"TeamName": self.teamName.text,
                @"Country" : self.country.text,
                @"MatrixLetter": self.matrixLetter.text};
}

-(void)sendMyForm
{
    /*
    NSData *dataToSend = [_username.text dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *allPeers = _appDelegate.mcManager.session.connectedPeers;
    NSError *error;
     */
    
    NSLog(@"Entered");
    
    NSMutableData *dataToSend = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:dataToSend];
    [archiver encodeObject:_myForm forKey:@"Form"];
    [archiver finishEncoding];
    NSLog(@"2");
    NSArray *allPeers = _appDelegate.mcManager.session.connectedPeers;
    NSError *error;
    
    [_appDelegate.mcManager.session sendData:dataToSend
                                     toPeers:allPeers
                                    withMode:MCSessionSendDataReliable
                                       error:&error];
    
    _teamName.text = @"";
    _country.text = @"";
    _username.text = @"";
    _matrixLetter.text = @"";
    
}

-(void)didReceiveDataWithNotification:(NSNotification *)notification
{
    /*
    MCPeerID *peerID = [[notification userInfo] objectForKey:@"peerID"];
    NSString *peerDisplayName = peerID.displayName;
    
    NSData *receivedData = [[notification userInfo] objectForKey:@"data"];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:receivedData];
    NSDictionary *dictionary = [unarchiver decodeObjectForKey:@"Form"];
    [unarchiver finishDecoding];
     */
    
 //   NSLog(@"recived %@",dictionary[@"Username"]);
    
   // NSString *receivedText = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    
  //  NSLog(@"Recieved Data %@",receivedText);
    
}

#pragma mark picker delegates

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ([pickerView isEqual:_letterPicker]) {
        return [_letterNames count];
    } else if ([pickerView isEqual:_countryPicker]) {
        return [_countryNames count];
    } else if ([pickerView isEqual:_teamPicker]){
        return [_teamNames count];
    } else {
        return 1;
    }
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([pickerView isEqual:_letterPicker]) {
        _matrixLetter.text = [_letterNames objectAtIndex:row];
        [_matrixLetter resignFirstResponder];

        
    } else if ([pickerView isEqual:_countryPicker]) {
        _country.text = [_countryNames objectAtIndex:row];
        [_country resignFirstResponder];

        
    } else if ([pickerView isEqual:_teamPicker]){
        _teamName.text = [_teamNames objectAtIndex:row];
        [_teamName resignFirstResponder];

        
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if ([pickerView isEqual:_letterPicker]) {
        return [_letterNames objectAtIndex:row];
    } else if ([pickerView isEqual:_countryPicker]) {
        return [_countryNames objectAtIndex:row];
    } else if ([pickerView isEqual:_teamPicker]){
        return [_teamNames objectAtIndex:row];
    } else {
        return @"";
    }
}







@end
