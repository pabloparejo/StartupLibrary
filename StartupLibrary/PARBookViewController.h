//
//  BookViewController.h
//  StartupLibrary
//
//  Created by parejo on 1/5/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

@import UIKit;
#import "PARBook.h"
#import "PARLibraryViewController.h"
@interface PARBookViewController : UIViewController <   UISplitViewControllerDelegate,
                                                        PARLibraryViewControllerDelegate>
- (id) initWithModel:(PARBook *)model;
@end
