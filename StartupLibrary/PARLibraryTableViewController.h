//
//  PARLibraryViewController.h
//  StartupLibrary
//
//  Created by parejo on 2/5/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

@import UIKit;
#import "PARLibrary.h"

@class PARLibraryTableViewController;

@protocol PARLibraryTableViewControllerDelegate <NSObject>

@optional
- (void) libraryViewController:(PARLibraryTableViewController *) libraryVC
                 didSelectBook:(PARBook *) book;
@end

@interface PARLibraryTableViewController : UITableViewController <PARLibraryTableViewControllerDelegate>

@property (weak, nonatomic) id<PARLibraryTableViewControllerDelegate> delegate;
- (id)initWithModel:(PARLibrary *) library;

@end
