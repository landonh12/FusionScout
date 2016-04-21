//
//  TeamRankingsTableViewController.m
//  FusionScout
//
//  Created by Landon Haugh on 4/19/16.
//  Copyright © 2016 Landon Haugh. All rights reserved.
//

#import "TeamRankingsTableViewController.h"
#import <Parse/Parse.h>

NSInteger teamScore[7000];
NSInteger teamRank[75];
NSInteger teamNumberRank[75];
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

@interface TeamRankingsTableViewController ()

@end

@implementation TeamRankingsTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}

- (IBAction)rankTeams:(id)sender {
    
    NSInteger j = 0;
    
    for(int i = 0; i < 7000; i++) {
        if(teamScore[i] != -1) {
            teamRank[j] = teamScore[i];
            teamNumberRank[j] = i;
            //NSLog(@"Rank: %d Team: %d Score: %ld", j, i, (long)teamRank[j]);
            j = j + 1;
        }
    }
    
    NSInteger buffer;
    NSInteger buffer2;
    
    int i;
    bool swapped = TRUE;
    while (swapped){
        swapped = FALSE;
        for (i = 0; i < 75; i++)
        {
            if (teamRank[i-1] > teamRank[i])
            {
                buffer = teamRank[i-1];
                teamRank[i-1] = teamRank[i];
                teamRank[i] = buffer;
                
                buffer2 = teamNumberRank[i-1];
                teamNumberRank[i-1] = teamNumberRank[i];
                teamNumberRank[i] = buffer2;
                
                swapped = TRUE;
            }
            //bubbleSortCount ++; //Increment the count everytime a switch is done, this line is not required in the production implementation.
        }
    }
    
    int z = 0;
    
    for(int i = 75; i > 0; i--) {
        z = z + 1;
        NSLog(@"Rank: %d Team: %d Score: %d", z, teamNumberRank[i - 1], teamRank[i - 1]);
    }
    
    [self.tableView reloadData];
}

- (IBAction)getTeams:(id)sender {
    NSLog(@"Starting Query...");
    
    for(int i = 0; i < 7001; i++) {
        teamScore[i] = -1;
    }
    
    PFQuery *query = [PFQuery queryWithClassName:@"TeamData"];
    [query setLimit:1000];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            for(NSInteger i = 0; i < 7001; i++) {
                
                teamNumber = 0;
                autoGoal = 0;
                autoReachedOW = 0;
                autoCrossedDef = 0;
                teleopCrossedDef = 0;
                teleopHighGoalsMissed = 0;
                teleopHighGoalsMade = 0;
                teleopLowGoalsMissed = 0;
                teleopLowGoalsMade = 0;
                teleopEndGame = 0;
                
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
                
                teamScore[teamNumber] = teamScore[teamNumber] + (autoGoal * 5) + (autoReachedOW * 2) + (autoCrossedDef * 10) + (teleopCrossedDef * 5) - (teleopHighGoalsMissed * 2) + (teleopHighGoalsMade * 5) - (teleopLowGoalsMissed * 5) + (teleopLowGoalsMade * 2) + (teleopEndGame) + 1;
                
                NSLog(@"Team Number: %ld Team Score: %ld", (long)teamNumber, (long)teamScore[teamNumber]);
                
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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 75;
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
 
    int z = -1;
    
    for(int i = 75; i > 0; i--) {
        z = z + 1;
        if(indexPath.row == z)
            cell.textLabel.text = [NSString stringWithFormat:@"Rank: %d Team: %d Score: %d", z + 1, teamNumberRank[i - 1], teamRank[i - 1]];
    }
 
    return cell;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
