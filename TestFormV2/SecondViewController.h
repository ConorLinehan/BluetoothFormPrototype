//
//  SecondViewController.h
//  TestFormV2
//
//  Created by Conor Linehan on 16/09/2014.
//  Copyright (c) 2014 Conor Linehan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FormDetailViewController.h"

@interface SecondViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (weak,nonatomic) IBOutlet UITableView *tableView;

@end
