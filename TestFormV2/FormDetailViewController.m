//
//  FormDetailViewController.m
//  TestFormV2
//
//  Created by Conor Linehan on 17/09/2014.
//  Copyright (c) 2014 Conor Linehan. All rights reserved.
//

#import "FormDetailViewController.h"

@interface FormDetailViewController ()

@end

@implementation FormDetailViewController

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
    
    
    NSLog(@"username %@",_form[@"Username"]);
    
    _countryLabel.text = _form[@"Country"];
    _usernameLabel.text = _form[@"Username"];
    _teamLabel.text = _form[@"TeamName"];
    _letterLabel.text = _form[@"MatrixLetter"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)done
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
