//
//  PARCreateNoteViewController.h
//  
//
//  Created by Pablo Parejo Camacho on 14/8/15.
//
//

@import UIKit;
@class PARBook;

@interface PARCreateNoteViewController : UIViewController

@property (strong, nonatomic) PARBook *book;

-(instancetype) initWithBook:(PARBook *) book;

@end
