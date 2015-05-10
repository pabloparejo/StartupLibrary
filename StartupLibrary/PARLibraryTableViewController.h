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

@interface PARLibraryTableViewController : UITableViewController <PARLibraryViewControllerDelegate>

@property (weak, nonatomic) id<PARLibraryViewControllerDelegate> delegate;
- (id)initWithModel:(PARLibrary *) library;
- (void) configureForTabBar;
@end
