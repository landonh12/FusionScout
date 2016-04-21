//
//  ScoutTableViewController.m
//  FusionScout
//
//  Created by Landon Haugh on 4/17/16.
//  Copyright © 2016 Landon Haugh. All rights reserved.
//

#import "ScoutTableViewController.h"
#import <Parse/Parse.h>

NSInteger teleopCrossedDefVal;
NSInteger teleopHighGoalsMissedVal;
NSInteger teleopHighGoalsMadeVal;
NSInteger teleopLowGoalsMissedVal;
NSInteger teleopLowGoalsMadeVal;
NSInteger teleopShotsDefVal;
NSInteger teleopShotsDisruptedVal;
NSInteger teleopPenaltiesVal;

@interface ScoutTableViewController ()

@end

@implementation ScoutTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    teleopCrossedDefVal = self.teleopCrossedDefStepper.value;
    self.teleopCrossedDef.text = [NSString stringWithFormat:@"%02lu", (unsigned long)teleopCrossedDefVal];
    
    teleopHighGoalsMissedVal = self.teleopHighGoalsMissedStepper.value;
    self.teleopHighGoalsMissed.text = [NSString stringWithFormat:@"%02lu", (unsigned long)teleopHighGoalsMissedVal];
    
    teleopHighGoalsMadeVal = self.teleopHighGoalsMadeStepper.value;
    self.teleopHighGoalsMade.text = [NSString stringWithFormat:@"%02lu", (unsigned long)teleopHighGoalsMadeVal];
    
    teleopLowGoalsMissedVal = self.teleopLowGoalsMissedStepper.value;
    self.teleopLowGoalsMissed.text = [NSString stringWithFormat:@"%02lu", (unsigned long)teleopLowGoalsMissedVal];
    
    teleopLowGoalsMadeVal = self.teleopLowGoalsMadeStepper.value;
    self.teleopLowGoalsMade.text = [NSString stringWithFormat:@"%02lu", (unsigned long)teleopLowGoalsMadeVal];
    
    teleopShotsDefVal = self.teleopShotsDefStepper.value;
    self.teleopShotsDef.text = [NSString stringWithFormat:@"%02lu", (unsigned long)teleopShotsDefVal];
    
    teleopShotsDisruptedVal = self.teleopShotsDisruptedStepper.value;
    self.teleopShotsDisrupted.text = [NSString stringWithFormat:@"%02lu", (unsigned long)teleopShotsDisruptedVal];
    
    teleopPenaltiesVal = self.teleopPenaltiesStepper.value;
    self.teleopPenalties.text = [NSString stringWithFormat:@"%02lu", (unsigned long)teleopPenaltiesVal];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0) return 2;
    if(section == 1) return 3;
    if(section == 2) return 7;
    if(section == 3) return 4;
    if(section == 4) return 1;
    else return 0;
}

- (IBAction)teleopCrossedDefSVC:(UIStepper *)sender {
    NSUInteger value = sender.value;
    self.teleopCrossedDef.text = [NSString stringWithFormat:@"%02lu", (unsigned long)value];
}

- (IBAction)teleopHighGoalsMissedSVC:(UIStepper *)sender {
    NSUInteger value = sender.value;
    self.teleopHighGoalsMissed.text = [NSString stringWithFormat:@"%02lu", (unsigned long)value];
}

- (IBAction)teleopHighGoalsMadeSVC:(UIStepper *)sender {
    NSUInteger value = sender.value;
    self.teleopHighGoalsMade.text = [NSString stringWithFormat:@"%02lu", (unsigned long)value];
}

- (IBAction)teleopLowGoalsMissedSVC:(UIStepper *)sender {
    NSUInteger value = sender.value;
    self.teleopLowGoalsMissed.text = [NSString stringWithFormat:@"%02lu", (unsigned long)value];
}

- (IBAction)teleopLowGoalsMadeSVC:(UIStepper *)sender {
    NSUInteger value = sender.value;
    self.teleopLowGoalsMade.text = [NSString stringWithFormat:@"%02lu", (unsigned long)value];
}

- (IBAction)teleopShotsDefSVC:(UIStepper *)sender {
    NSUInteger value = sender.value;
    self.teleopShotsDef.text = [NSString stringWithFormat:@"%02lu", (unsigned long)value];
}

- (IBAction)teleopShotsDisruptedSVC:(UIStepper *)sender {
    NSUInteger value = sender.value;
    self.teleopShotsDisrupted.text = [NSString stringWithFormat:@"%02lu", (unsigned long)value];
}

- (IBAction)teleopPenaltiesSVC:(UIStepper *)sender {
    NSUInteger value = sender.value;
    self.teleopPenalties.text = [NSString stringWithFormat:@"%02lu", (unsigned long)value];
}

- (IBAction)saveData:(id)sender {
    
    NSLog(@"Starting Connection...");
    
    PFObject *teamData = [PFObject objectWithClassName:@"TeamData"];
    
    teamData[@"autoGoal"] = @"0";
    teamData[@"autoReachedOW"] = @"0";
    teamData[@"autoCrossedDef"] = @"0";
    teamData[@"teleopOffense"] = @"0";
    teamData[@"teleopEndGame"] = @"0";
    teamData[@"teleopDefense"] = @"0";
    
    teamData[@"teamNumber"] = _teamNumber.text;
    teamData[@"matchNumber"] = _matchNumber.text;
    
    if(_autoGoal.selectedSegmentIndex == 0) teamData[@"autoGoal"] = @"0";
    if(_autoGoal.selectedSegmentIndex == 1) teamData[@"autoGoal"] = @"1";
    if(_autoGoal.selectedSegmentIndex == 2) teamData[@"autoGoal"] = @"2";
    
    if(_autoReachedOW.isOn) teamData[@"autoReachedOW"] = @"1";
    if(_autoCrossedDef.isOn) teamData[@"autoCrossedDef"] = @"1";
    if(_teleopOffense.isOn) teamData[@"teleopOffense"] = @"1";
    
    teamData[@"teleopCrossedDef"] = _teleopCrossedDef.text;
    teamData[@"teleopHighGoalsMissed"] = _teleopHighGoalsMissed.text;
    teamData[@"teleopHighGoalsMade"] = _teleopHighGoalsMade.text;
    teamData[@"teleopLowGoalsMissed"] = _teleopLowGoalsMissed.text;
    teamData[@"teleopLowGoalsMade"] = _teleopLowGoalsMade.text;
    
    if(_teleopEndGame.selectedSegmentIndex == 0) teamData[@"teleopEndGame"] = @"0";
    if(_teleopEndGame.selectedSegmentIndex == 1) teamData[@"teleopEndGame"] = @"1";
    if(_teleopEndGame.selectedSegmentIndex == 2) teamData[@"teleopEndGame"] = @"2";
    
    if(_teleopDefense.isOn) teamData[@"teleopDefense"] = @"1";
    
    teamData[@"teleopShotsDef"] = _teleopShotsDef.text;
    teamData[@"teleopShotsDisrupted"] = _teleopShotsDisrupted.text;
    teamData[@"teleopPenalties"] = _teleopPenalties.text;
    
    [teamData saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Saved"
                                                      message:@"Data has been written to Parse."
                                                      delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            [alert show];
            NSLog(@"Connection Request Succeeded");
        } else {
            NSLog(@"%@", [error localizedDescription]);
            NSLog(@"Connection Request Failed");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed!"
                                                      message:@"There was an error connecting to Parse."
                                                      delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            [alert show];
        }
    
        }];
    
    [self dismissViewControllerAnimated: YES completion: nil];

}

-(void)dismissKeyboard {
    [self.teamNumber resignFirstResponder];
    [self.matchNumber resignFirstResponder];
    [self.teleopCrossedDef resignFirstResponder];
    [self.teleopHighGoalsMissed resignFirstResponder];
    [self.teleopHighGoalsMade resignFirstResponder];
    [self.teleopLowGoalsMissed resignFirstResponder];
    [self.teleopLowGoalsMade resignFirstResponder];
    [self.teleopShotsDef resignFirstResponder];
    [self.teleopShotsDisrupted resignFirstResponder];
    [self.teleopPenalties resignFirstResponder];
}

@end
