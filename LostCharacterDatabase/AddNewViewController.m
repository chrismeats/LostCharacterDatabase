//
//  AddNewViewController.m
//  LostCharacterDatabase
//
//  Created by ETC ComputerLand on 8/12/14.
//  Copyright (c) 2014 cmeats. All rights reserved.
//

#import "AddNewViewController.h"
#import "MasterViewController.h"


@interface AddNewViewController ()
@property (strong, nonatomic) IBOutlet UITextField *actorTextField;
@property (strong, nonatomic) IBOutlet UITextField *passengerTextField;
@property (strong, nonatomic) IBOutlet UITextField *hairColorTextField;
@property (strong, nonatomic) IBOutlet UITextField *seatTextField;
@property (strong, nonatomic) IBOutlet UITextField *genderTextField;

@end

@implementation AddNewViewController

- (IBAction)onSaveAction:(UIBarButtonItem *)sender
{
    NSLog(@"I am here");
    Lost *lost = [NSEntityDescription insertNewObjectForEntityForName:@"Lost" inManagedObjectContext:self.managedObjectContext];
    lost.actor = self.actorTextField.text;
    lost.passenger = self.passengerTextField.text;
    lost.hairColor = self.hairColorTextField.text;
    lost.seat = self.seatTextField.text;
    lost.gender = self.genderTextField.text;
    [self.managedObjectContext save:nil];
    [self performSegueWithIdentifier:@"addUnwind" sender:self];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
