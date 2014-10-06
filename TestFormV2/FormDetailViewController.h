//
//  FormDetailViewController.h
//  TestFormV2
//
//  Created by Conor Linehan on 17/09/2014.
//  Copyright (c) 2014 Conor Linehan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FormDetailViewController : UIViewController

@property (weak,nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak,nonatomic) IBOutlet UILabel *countryLabel;
@property (weak,nonatomic) IBOutlet UILabel *teamLabel;
@property (weak,nonatomic) IBOutlet UILabel *letterLabel;
@property (weak,nonatomic) NSDictionary *form;

-(IBAction)done;


@end
