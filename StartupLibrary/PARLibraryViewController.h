//
//  PARLibraryViewController.h
//  StartupLibrary
//
//  Created by parejo on 2/5/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

@import UIKit;
#import "PARLibrary.h"

@class PARLibraryViewController;

@protocol PARLibraryViewControllerDelegate <NSObject>

@optional
- (void) libraryViewController:(PARLibraryViewController *) libraryVC
                 didSelectBook:(PARBook *) book;
@end

@interface PARLibraryViewController : UITableViewController <PARLibraryViewControllerDelegate>

@property (weak, nonatomic) id<PARLibraryViewControllerDelegate> delegate;
- (id)initWithModel:(PARLibrary *) library;

@end
