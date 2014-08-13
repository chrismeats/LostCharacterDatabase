//
//  MasterViewController.m
//  LostCharacterDatabase
//
//  Created by ETC ComputerLand on 8/12/14.
//  Copyright (c) 2014 cmeats. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"
#import "Lost.h"
#import "AddNewViewController.h"
#import "LostTableViewCell.h"

@interface MasterViewController ()
@property NSArray *losts;
@property NSArray *sortKeys;
@property (strong, nonatomic) IBOutlet UIPickerView *sortPickerView;
@end

@implementation MasterViewController

-(void)viewDidLoad
{
    [super viewDidLoad];

    // Sort keys needs to follow same indexing order as segmented control in storyboard
    self.sortKeys = [[NSArray alloc] initWithObjects:@"passenger", @"actor", @"hairColor", @"seat", nil];

    [self loadCoreData:self.sortKeys[0]];
    if (!self.losts.count) {
        [self setupCoreDataFromPlist];
        [self loadCoreData:self.sortKeys[0]];
    }
}

-(void)loadCoreData:(NSString *)sortKey
{
    NSSortDescriptor *nameSortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortKey ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:nameSortDescriptor];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Lost"];
    request.sortDescriptors = sortDescriptors;
    self.losts = [self.managedObjectContext executeFetchRequest:request error:nil];
    [self.tableView reloadData];
}

-(void)setupCoreDataFromPlist
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"lost" ofType:@"plist"];
    NSArray *losts = [[NSArray alloc] initWithContentsOfFile:path];

    for (NSDictionary *lostDic in losts) {
        Lost *lost = [NSEntityDescription insertNewObjectForEntityForName:@"Lost" inManagedObjectContext:self.managedObjectContext];
        lost.actor = lostDic[@"actor"];
        lost.passenger = lostDic[@"passenger"];
        [self.managedObjectContext save:nil];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    AddNewViewController *dvc = segue.destinationViewController;
    dvc.managedObjectContext = self.managedObjectContext;
}

-(IBAction)unwindFromAdd:(UIStoryboardSegue *)sender
{
    [self loadCoreData:self.sortKeys[0]];
}
- (IBAction)onChangeSort:(UISegmentedControl *)segmentedControl
{
    [self loadCoreData:self.sortKeys[segmentedControl.selectedSegmentIndex]];
}

#pragma mark -- Table View Delegate

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.losts.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    Lost *lost = self.losts[indexPath.row];
    cell.textLabel.text = lost.passenger;
    cell.detailTextLabel.text = lost.actor;
    cell.hairColorTextLabel.text = lost.hairColor;
    cell.seatTextLabel.text = lost.seat;
    cell.genderTextLabel.text = lost.gender;
    return cell;
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"%@", self.losts[indexPath.row]);
    [self.managedObjectContext deleteObject:self.losts[indexPath.row]];
    [self.managedObjectContext save:nil];
    [self loadCoreData:self.sortKeys[0]];
    [self.tableView reloadData];
//    [self.managedObjectContext delete:self.losts[indexPath.row]];
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"SMOKE MONSTER";
}


@end
