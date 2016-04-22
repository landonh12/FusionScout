//
//  DefenseLookupViewController.h
//  FusionScout
//
//  Created by Landon Haugh on 4/21/16.
//  Copyright © 2016 Landon Haugh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DefenseLookupViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *teamNumberOutlet;
@property (weak, nonatomic) IBOutlet UITextField *teleopShotsDefOutlet;
@property (weak, nonatomic) IBOutlet UITextField *teleopShotsDisruptedOutlet;
@property (weak, nonatomic) IBOutlet UITextField *teleopPentaltiesOutlet;
@property (weak, nonatomic) IBOutlet UITextField *totalDefScoreOutlet;

@end
