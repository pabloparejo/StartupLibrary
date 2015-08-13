//
//  BookViewController.m
//  StartupLibrary
//
//  Created by parejo on 1/5/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//


@import Social;
#import "PARBookViewController.h"
#import "PARWebViewController.h"
#import "PARBookViewController.h"
#import "ReaderViewController.h"

#define SELF_TITLE @"Book"
#define BUY_BOOK_TITLE @"Book's Store"

@interface PARBookViewController ()

@property (strong, nonatomic) PARBook *model;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UIButton *category;
@property (weak, nonatomic) IBOutlet UILabel *summary;
@property (weak, nonatomic) IBOutlet UIImageView *bookImage;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *imageLoading;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *bookLoading;

@end

@implementation PARBookViewController

- (id) initWithModel:(PARBook *)model{
    if (self = [super init]) {
        _model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = SELF_TITLE;
    [self syncViewWithModel];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //Default DisplayMode to SplitVC
    if (self.splitViewController.displayMode != UISplitViewControllerDisplayModeAllVisible) {
        self.navigationItem.leftItemsSupplementBackButton = YES;
        self.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    }
    
    [self.bookLoading stopAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions


- (IBAction)openBook:(id)sender {
    [self.bookLoading startAnimating];
    [self.model downloadBookPDF:^{
        ReaderViewController *readerVC = [[ReaderViewController alloc] initWithReaderDocument:self.model.document];
        [self.navigationController pushViewController:readerVC animated:YES];
        [self.bookLoading stopAnimating];
    }];
}

- (IBAction)buyBook:(id)sender {
    PARWebViewController *webVC = [[PARWebViewController alloc] initWithURL:[NSURL URLWithString:self.model.webURL] title:BUY_BOOK_TITLE];
    [self.navigationController pushViewController:webVC animated:YES];
}

- (IBAction)shareBook:(id)sender {
    SLComposeViewController *vc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    if (vc) {
        [vc setInitialText:[NSString stringWithFormat:@"I am loving the book %@!", self.model.title]];
        [vc addURL:[NSURL URLWithString:self.model.webURL]];
        
        [self presentViewController:vc animated:YES completion:nil];
    }else{
        NSLog(@"Twitter account has not been set");
    }
}


#pragma mark - UISplitViewControllerDelegate

-(void) splitViewController:(UISplitViewController *)splitVC
    willChangeToDisplayMode:(UISplitViewControllerDisplayMode)displayMode{
    if (displayMode != UISplitViewControllerDisplayModeAllVisible) {
        self.navigationItem.leftItemsSupplementBackButton = YES;
        self.navigationItem.leftBarButtonItem = splitVC.displayModeButtonItem;
    }
    
}

#pragma mark - PARLibraryViewControllerDelegate

-(void) libraryViewController:(PARLibraryTableViewController *)libraryVC didSelectBook:(PARBook *)book{
    self.model = book;
    
    // We go back to display new book's info
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self syncViewWithModel];
}


#pragma mark - Utils

-(void)syncViewWithModel{
    [self.model retrieveDetail];
    self.bookImage.image = nil;
    [self.bookLoading stopAnimating];
    [self.imageLoading startAnimating];
    if (self.model.image != nil) {
        self.bookImage.image = self.model.image;
        [self.imageLoading stopAnimating];
    }else{
        [self.model downloadCoverImage:^{
            self.bookImage.image = self.model.image;
            [self.imageLoading stopAnimating];
        }];
    }
    [self.category setTitle:[self.model category] forState:UIControlStateNormal];
    self.titleLabel.text = [self.model title];
    self.author.text = [self.model author];
    self.summary.text = [self.model summary];
}


@end
