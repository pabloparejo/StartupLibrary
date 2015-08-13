//
//  PARLibraryViewController.h
//  StartupLibrary
//
//  Created by parejo on 2/5/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

@import UIKit;
#import "PARLibrary.h"
#import "PARLibraryViewControllerDelegate.h"
#import "CoreDataTableViewController.h"

@interface PARLibraryTableViewController : CoreDataTableViewController

@property (weak, nonatomic) id<PARLibraryViewControllerDelegate> delegate;
- (void) configureForTabBar;
@end
