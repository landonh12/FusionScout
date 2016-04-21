//
//  TeamLookupViewController.m
//  FusionScout
//
//  Created by Landon Haugh on 4/20/16.
//  Copyright © 2016 Landon Haugh. All rights reserved.
//

#import "TeamLookupViewController.h"
#import <Parse/Parse.h>

NSInteger teamScore2[7000];
NSInteger totalAutoGoal[7000];
NSInteger totalAutoReachedOW[7000];
NSInteger totalAutoCrossedDef[7000];
NSInteger totalTeleopCrossedDef[7000];
NSInteger totalTeleopHighGoalsMissed[7000];
NSInteger totalTeleopHighGoalsMade[7000];
NSInteger totalTeleopLowGoalsMissed[7000];
NSInteger totalTeleopLowGoalsMade[7000];
NSInteger totalTeleopEndGame[7000];
NSInteger teamNumber2;
UIAlertView *dialog;

@interface TeamLookupViewController ()

@end

@implementation TeamLookupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Clear the teamScore array for each new load
    for(int i = 0; i < 7001; i++) {
        teamScore2[i] = 0;
    }
    
    NSLog(@"Starting Query...");
    
    PFQuery *query = [PFQuery queryWithClassName:@"TeamData"];
    [query setLimit:1000];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            NSInteger teamNumber = 0;
            NSInteger autoGoal = 0;
            NSInteger autoReachedOW = 0;
            NSInteger autoCrossedDef = 0;
            NSInteger teleopCrossedDef = 0;
            NSInteger teleopHighGoalsMissed = 0;
            NSInteger teleopHighGoalsMade = 0;
            NSInteger teleopLowGoalsMissed = 0;
            NSInteger teleopLowGoalsMade = 0;
            NSInteger teleopEndGame = 0;
            
            for(NSInteger i = 0; i < 1000; i++) {
                teamNumber = [[objects[i] valueForKey:@"teamNumber"] intValue];
                autoGoal = [[objects[i] valueForKey:@"autoGoal"] intValue];
                autoReachedOW = [[objects[i] valueForKey:@"autoReachedOW"] intValue];
                autoCrossedDef = [[objects[i] valueForKey:@"autoCrossedDef"] intValue];
                teleopCrossedDef = [[objects[i] valueForKey:@"teleopCrossedDef"] intValue];
                teleopHighGoalsMissed = [[objects[i] valueForKey:@"teleopHighGoalsMissed"] intValue];
                teleopHighGoalsMade = [[objects[i] valueForKey:@"teleopHighGoalsMade"] intValue];
                teleopLowGoalsMissed = [[objects[i] valueForKey:@"teleopLowGoalsMissed"] intValue];
                teleopLowGoalsMade = [[objects[i] valueForKey:@"teleopLowGoalsMade"] intValue];
                teleopEndGame = [[objects[i] valueForKey:@"teleopEndGame"] intValue];
                
                if(teleopEndGame == 0) teleopEndGame = 0;
                if(teleopEndGame == 1) teleopEndGame = 5;
                if(teleopEndGame == 2) teleopEndGame = 15;
                
                totalAutoGoal[teamNumber] = totalAutoGoal[teamNumber] + (autoGoal * 5);
                totalAutoReachedOW[teamNumber] = totalAutoReachedOW[teamNumber] + (autoReachedOW * 2);
                totalAutoCrossedDef[teamNumber] = totalAutoCrossedDef[teamNumber] + (autoCrossedDef * 10);
                totalTeleopCrossedDef[teamNumber] = totalTeleopCrossedDef[teamNumber] + (teleopCrossedDef * 5);
                totalTeleopHighGoalsMissed[teamNumber] = totalTeleopHighGoalsMissed[teamNumber] - (teleopHighGoalsMissed * 2);
                totalTeleopHighGoalsMade[teamNumber] = totalTeleopHighGoalsMade[teamNumber] + (teleopHighGoalsMade * 5);
                totalTeleopLowGoalsMissed[teamNumber] = totalTeleopLowGoalsMissed[teamNumber] - (teleopLowGoalsMissed * 5);
                totalTeleopLowGoalsMade[teamNumber] = totalTeleopLowGoalsMade[teamNumber] + (teleopLowGoalsMade * 2);
                totalTeleopEndGame[teamNumber] = totalTeleopEndGame[teamNumber] + (teleopEndGame);
                
                teamScore2[teamNumber] = teamScore2[teamNumber] + (autoGoal * 5) + (autoReachedOW * 2) + (autoCrossedDef * 10) + (teleopCrossedDef * 5) - (teleopHighGoalsMissed * 2) + (teleopHighGoalsMade * 5) - (teleopLowGoalsMissed * 5) + (teleopLowGoalsMade * 2) + (teleopEndGame);
                
                NSLog(@"Team Number: %d Team Score: %d", teamNumber, teamScore2[teamNumber]);
            }
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed!"
                                                            message:@"There was an error connecting to Parse."
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }];
    
    dialog  = [[UIAlertView alloc] init];
    [dialog setDelegate:self];
    [dialog setTitle:@"Enter Team Number"];
    [dialog setMessage:@" "];
    [dialog addButtonWithTitle:@"Done"];
    dialog.tag = 5;
    
    dialog.alertViewStyle = UIAlertViewStylePlainTextInput;
    [dialog textFieldAtIndex:0].keyboardType = UIKeyboardTypeNumberPad;
    
    CGAffineTransform moveUp = CGAffineTransformMakeTranslation(0.0, 0.0);
    [dialog setTransform: moveUp];
    [dialog show];
    
    NSLog(@"Showing Team Stats...");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    // the user clicked one of the OK/Cancel buttons
    if (buttonIndex == 0) {
        
        UITextField *textField = [dialog textFieldAtIndex:0];
        teamNumber2 = [[textField text] intValue];
        
        NSLog(@"Team Number: %d Total Auto Goal Score: %d Total Auto Reached OW Score: %d Total Auto Crossed Def Score: %d Total Teleop Crossed Def Score: %d Total High Goal Missed Score: %d Total High Goal Made Score: %d Total Low Goal Missed Score: %d Total Low Goal Made Score: %d Total End Game Score: %d", teamNumber2, totalAutoGoal[teamNumber2], totalAutoReachedOW[teamNumber2], totalAutoCrossedDef[teamNumber2], totalTeleopCrossedDef[teamNumber2], totalTeleopHighGoalsMissed[teamNumber2], totalTeleopHighGoalsMade[teamNumber2], totalTeleopLowGoalsMissed[teamNumber2], totalTeleopLowGoalsMade[teamNumber2], totalTeleopEndGame[teamNumber2]);
        
        _teamNumberOutlet.text = [NSString stringWithFormat:@"%d", teamNumber2];
        _autoGoalOutlet.text = [NSString stringWithFormat:@"%d", totalAutoGoal[teamNumber2]];
        _autoReachedOWOutlet.text = [NSString stringWithFormat:@"%d", totalAutoReachedOW[teamNumber2]];
        _autoCrossedDefOutlet.text = [NSString stringWithFormat:@"%d", totalAutoCrossedDef[teamNumber2]];
        _teleopCrossedDefOutlet.text = [NSString stringWithFormat:@"%d", totalTeleopCrossedDef[teamNumber2]];
        _teleopHighGoalsMissedOutlet.text = [NSString stringWithFormat:@"%d", totalTeleopHighGoalsMissed[teamNumber2]];
        _teleopHighGoalsMadeOutlet.text = [NSString stringWithFormat:@"%d", totalTeleopHighGoalsMade[teamNumber2]];
        _teleopLowGoalsMissedOutlet.text = [NSString stringWithFormat:@"%d", totalTeleopLowGoalsMissed[teamNumber2]];
        _teleopLowGoalsMadeOutlet.text = [NSString stringWithFormat:@"%d", totalTeleopLowGoalsMade[teamNumber2]];
        _teleopEndGameOutlet.text = [NSString stringWithFormat:@"%d", totalTeleopEndGame[teamNumber2]];
        _totalScoreOutlet.text = [NSString stringWithFormat:@"%d", totalAutoGoal[teamNumber2] + totalAutoReachedOW[teamNumber2] + totalAutoCrossedDef[teamNumber2] + totalTeleopCrossedDef[teamNumber2] + totalTeleopHighGoalsMissed[teamNumber2] + totalTeleopHighGoalsMade[teamNumber2] + totalTeleopLowGoalsMissed[teamNumber2] + totalTeleopLowGoalsMade[teamNumber2] + totalTeleopEndGame[teamNumber2]];
        totalAutoGoal[teamNumber2] = 0;
        totalAutoReachedOW[teamNumber2] = 0;
        totalAutoCrossedDef[teamNumber2] = 0;
        totalTeleopCrossedDef[teamNumber2] = 0;
        totalTeleopHighGoalsMissed[teamNumber2] = 0;
        totalTeleopHighGoalsMade[teamNumber2] = 0;
        totalTeleopLowGoalsMissed[teamNumber2] = 0;
        totalTeleopLowGoalsMade[teamNumber2] = 0;
        totalTeleopEndGame[teamNumber2] = 0;
        
        
    } else {
        NSLog(@"cancel");
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
