//
//  MainMenuTableViewController.m
//  FusionScout
//
//  Created by Landon Haugh on 4/17/16.
//  Copyright © 2016 Landon Haugh. All rights reserved.
//

#import "MainMenuTableViewController.h"
#import "ScoutTableViewController.h"

@interface MainMenuTableViewController ()

@end

@implementation MainMenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (IBAction)saveDataAndClose:(UIStoryboardSegue *)sender {
    
}

@end
