//
//  TeamLookupViewController.h
//  FusionScout
//
//  Created by Landon Haugh on 4/20/16.
//  Copyright © 2016 Landon Haugh. All rights reserved.
//

#import <UIKit/UIKit.h>

UITextField *nameField;

@interface TeamLookupViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *teamNumberOutlet;
@property (weak, nonatomic) IBOutlet UITextField *autoGoalOutlet;
@property (weak, nonatomic) IBOutlet UITextField *autoReachedOWOutlet;
@property (weak, nonatomic) IBOutlet UITextField *autoCrossedDefOutlet;
@property (weak, nonatomic) IBOutlet UITextField *teleopCrossedDefOutlet;
@property (weak, nonatomic) IBOutlet UITextField *teleopHighGoalsMissedOutlet;
@property (weak, nonatomic) IBOutlet UITextField *teleopHighGoalsMadeOutlet;
@property (weak, nonatomic) IBOutlet UITextField *teleopLowGoalsMissedOutlet;
@property (weak, nonatomic) IBOutlet UITextField *teleopLowGoalsMadeOutlet;
@property (weak, nonatomic) IBOutlet UITextField *teleopEndGameOutlet;
@property (weak, nonatomic) IBOutlet UITextField *totalScoreOutlet;


@end
