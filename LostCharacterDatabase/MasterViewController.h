//
//  MasterViewController.h
//  LostCharacterDatabase
//
//  Created by ETC ComputerLand on 8/12/14.
//  Copyright (c) 2014 cmeats. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
