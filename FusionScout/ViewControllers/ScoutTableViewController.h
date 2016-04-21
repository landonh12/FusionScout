//
//  ScoutTableViewController.h
//  FusionScout
//
//  Created by Landon Haugh on 4/17/16.
//  Copyright © 2016 Landon Haugh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScoutTableViewController : UITableViewController

//Team Number and Match Number UITextField's
@property (weak, nonatomic) IBOutlet UITextField *teamNumber;
@property (weak, nonatomic) IBOutlet UITextField *matchNumber;

//Autonomous controls - Switches and Segmented control
@property (weak, nonatomic) IBOutlet UISwitch *autoReachedOW;
@property (weak, nonatomic) IBOutlet UISwitch *autoCrossedDef;
@property (weak, nonatomic) IBOutlet UISegmentedControl *autoGoal;

//Teleop Offense UISwitch
@property (weak, nonatomic) IBOutlet UISwitch *teleopOffense;

//Teleop Defenses Crossed UITextField and UIStepper
@property (weak, nonatomic) IBOutlet UITextField *teleopCrossedDef;
@property (weak, nonatomic) IBOutlet UIStepper *teleopCrossedDefStepper;
- (IBAction)teleopCrossedDefSVC:(UIStepper *)sender;

//Teleop High Goals Missed UITextField and UIStepper
@property (weak, nonatomic) IBOutlet UITextField *teleopHighGoalsMissed;
@property (weak, nonatomic) IBOutlet UIStepper *teleopHighGoalsMissedStepper;
- (IBAction)teleopHighGoalsMissedSVC:(UIStepper *)sender;

//Teleop High Goals Made UITextField and UIStepper
@property (weak, nonatomic) IBOutlet UITextField *teleopHighGoalsMade;
@property (weak, nonatomic) IBOutlet UIStepper *teleopHighGoalsMadeStepper;
- (IBAction)teleopHighGoalsMadeSVC:(UIStepper *)sender;

//Teleop Low Goals Missed UITextField and UIStepper
@property (weak, nonatomic) IBOutlet UITextField *teleopLowGoalsMissed;
@property (weak, nonatomic) IBOutlet UIStepper *teleopLowGoalsMissedStepper;
- (IBAction)teleopLowGoalsMissedSVC:(UIStepper *)sender;

//Teleop Low Goals Made UITextField and UIStepper
@property (weak, nonatomic) IBOutlet UITextField *teleopLowGoalsMade;
@property (weak, nonatomic) IBOutlet UIStepper *teleopLowGoalsMadeStepper;
- (IBAction)teleopLowGoalsMadeSVC:(UIStepper *)sender;

//Teleop End Game UISegmentedControl
@property (weak, nonatomic) IBOutlet UISegmentedControl *teleopEndGame;

//Teleop Defense UISwitch
@property (weak, nonatomic) IBOutlet UISwitch *teleopDefense;

//Teleop Shots Defended UITextField and UIStepper
@property (weak, nonatomic) IBOutlet UITextField *teleopShotsDef;
@property (weak, nonatomic) IBOutlet UIStepper *teleopShotsDefStepper;
- (IBAction)teleopShotsDefSVC:(UIStepper *)sender;

//Teleop Shots Disrupted UITextField and UIStepper
@property (weak, nonatomic) IBOutlet UITextField *teleopShotsDisrupted;
@property (weak, nonatomic) IBOutlet UIStepper *teleopShotsDisruptedStepper;
- (IBAction)teleopShotsDisruptedSVC:(UIStepper *)sender;

//Teleop Penalties UITextField and UIStepper
@property (weak, nonatomic) IBOutlet UITextField *teleopPenalties;
@property (weak, nonatomic) IBOutlet UIStepper *teleopPenaltiesStepper;
- (IBAction)teleopPenaltiesSVC:(UIStepper *)sender;

- (IBAction)saveData:(id)sender;

@end
