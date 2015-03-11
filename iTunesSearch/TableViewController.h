//
//  ViewController.h
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface TableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>


@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIToolbar *BBuscarr;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *LTexto;
- (IBAction)BBuscar:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *LTexto2;

@end

