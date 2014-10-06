//
//  FirstViewController.h
//  TestFormV2
//
//  Created by Conor Linehan on 16/09/2014.
//  Copyright (c) 2014 Conor Linehan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SecondViewController.h"

@interface FirstViewController : UIViewController <UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *teamName;
@property (weak, nonatomic) IBOutlet UITextField *country;
@property (weak, nonatomic) IBOutlet UITextField *matrixLetter;
@property (weak, nonatomic) IBOutlet UILabel *myLabel;

-(IBAction)sendMessage:(id)sender;
-(IBAction)cancelMessage:(id)sender;

@end
