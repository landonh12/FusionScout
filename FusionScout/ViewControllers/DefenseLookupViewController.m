//
//  DefenseLookupViewController.m
//  FusionScout
//
//  Created by Landon Haugh on 4/21/16.
//  Copyright © 2016 Landon Haugh. All rights reserved.
//

#import "DefenseLookupViewController.h"
#import <Parse/Parse.h>

NSInteger teamScore3[7000];
NSInteger totalTeleopShotsDef[7000];
NSInteger totalTeleopShotsDisrupted[7000];
NSInteger totalTeleopPenalties[7000];
NSInteger teamNumber3;
UIAlertView *dialog2;

@interface DefenseLookupViewController ()

@end

@implementation DefenseLookupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Clear the teamScore array for each new load
    for(int i = 0; i < 7001; i++) {
        teamScore3[i] = 0;
        totalTeleopShotsDef[i] = 0;
        totalTeleopShotsDisrupted[i] = 0;
        totalTeleopPenalties[i] = 0;
    }
    
    NSLog(@"Starting Query...");
    
    PFQuery *query = [PFQuery queryWithClassName:@"TeamData"];
    [query setLimit:1000];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            NSInteger teamNumber = 0;
            NSInteger teleopShotsDef = 0;
            NSInteger teleopShotsDisrupted = 0;
            NSInteger teleopPenalties = 0;
            
            for(NSInteger i = 0; i < 1000; i++) {
                
                teamNumber = [[objects[i] valueForKey:@"teamNumber"] intValue];
                teleopShotsDef = [[objects[i] valueForKey:@"teleopShotsDef"] intValue];
                teleopShotsDisrupted = [[objects[i] valueForKey:@"teleopShotsDisrupted"] intValue];
                teleopPenalties = [[objects[i] valueForKey:@"teleopPenalties"] intValue];
                
                totalTeleopShotsDef[teamNumber] = totalTeleopShotsDef[teamNumber] + (teleopShotsDef * 5);
                totalTeleopShotsDisrupted[teamNumber] = totalTeleopShotsDisrupted[teamNumber] + (teleopShotsDisrupted * 2);
                totalTeleopPenalties[teamNumber] = totalTeleopPenalties[teamNumber] + (teleopPenalties * 10);
                
                teamScore3[teamNumber] = teamScore3[teamNumber] + (teleopShotsDef * 5) + teleopShotsDisrupted - (teleopPenalties * 10);
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
    
    dialog2  = [[UIAlertView alloc] init];
    [dialog2 setDelegate:self];
    [dialog2 setTitle:@"Enter Team Number"];
    [dialog2 setMessage:@" "];
    [dialog2 addButtonWithTitle:@"Done"];
    dialog2.tag = 5;
    
    dialog2.alertViewStyle = UIAlertViewStylePlainTextInput;
    [dialog2 textFieldAtIndex:0].keyboardType = UIKeyboardTypeNumberPad;
    
    CGAffineTransform moveUp = CGAffineTransformMakeTranslation(0.0, 0.0);
    [dialog2 setTransform: moveUp];
    [dialog2 show];
    
    NSLog(@"Showing Team Stats...");

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    // the user clicked one of the OK/Cancel buttons
    if (buttonIndex == 0) {
        
        UITextField *textField = [dialog2 textFieldAtIndex:0];
        teamNumber3 = [[textField text] intValue];
        
        _teamNumberOutlet.text = [NSString stringWithFormat:@"%d", teamNumber3];
        _teleopShotsDefOutlet.text = [NSString stringWithFormat:@"%d", totalTeleopShotsDef[teamNumber3]];
        _teleopShotsDisruptedOutlet.text = [NSString stringWithFormat:@"%d", totalTeleopShotsDisrupted[teamNumber3]];
        _teleopPentaltiesOutlet.text = [NSString stringWithFormat:@"%d", totalTeleopPenalties[teamNumber3]];
        _totalDefScoreOutlet.text = [NSString stringWithFormat:@"%d", teamScore3[teamNumber3]];
        
        totalTeleopShotsDef[teamNumber3] = 0;
        totalTeleopShotsDisrupted[teamNumber3] = 0;
        totalTeleopPenalties[teamNumber3] = 0;
        
        
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
