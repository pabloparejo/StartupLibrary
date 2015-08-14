//
//  BookViewController.m
//  StartupLibrary
//
//  Created by parejo on 1/5/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//


@import Social;
@import MapKit;
#import "PARBookViewController.h"
#import "PARWebViewController.h"
#import "PARBookViewController.h"
#import "PARCreateNoteViewController.h"
#import "ReaderViewController.h"
#import "AppDelegate.h"
#import "PARNote.h"

#define SELF_TITLE @"Book"
#define BUY_BOOK_TITLE @"Book's Store"

@interface PARBookViewController () <MKMapViewDelegate>

@property (strong, nonatomic) PARBook *model;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UIButton *category;
@property (weak, nonatomic) IBOutlet UILabel *summary;
@property (weak, nonatomic) IBOutlet UIImageView *bookImage;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *imageLoading;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *bookLoading;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;


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
    [self updateMap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)buyBook:(id)sender {
    PARWebViewController *webVC = [[PARWebViewController alloc] initWithURL:[NSURL URLWithString:self.model.webURL] title:BUY_BOOK_TITLE];
    [self.navigationController pushViewController:webVC animated:YES];
}

- (IBAction)newNote:(id)sender {
    PARCreateNoteViewController *noteVC = [[PARCreateNoteViewController alloc] initWithBook:self.model];
    [self presentViewController:noteVC animated:YES completion:nil];
}


- (IBAction)openBook:(id)sender {
    [self.bookLoading startAnimating];
    [self.model downloadBookPDF:^{
        ReaderViewController *readerVC = [[ReaderViewController alloc] initWithReaderDocument:self.model.document];
        [self.navigationController pushViewController:readerVC animated:YES];
        [self.bookLoading stopAnimating];
    }];
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
- (void)updateMap{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([PARNote class])];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"createdAt" ascending:YES]];
    request.predicate = [NSPredicate predicateWithFormat:@"book = %@", self.model];
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    
    NSArray *notes = [appDelegate.managedObjectContext executeFetchRequest:request error:nil];
    
    [notes enumerateObjectsUsingBlock:^(PARNote *obj, NSUInteger idx, BOOL *stop) {
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        CLLocationDegrees lat = [obj.latitude doubleValue];
        CLLocationDegrees lon = [obj.longitude doubleValue];
        
        
        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(lat, lon);
        annotation.coordinate = coord;
        annotation.title = obj.text;
        [self.mapView addAnnotation:annotation];
        
        if (idx == notes.count - 1) {
            MKCoordinateRegion region = MKCoordinateRegionMake(coord, MKCoordinateSpanMake(1, 1));
            self.mapView.region = region;
        }

    }];
    
    
    
    self.mapView.mapType = MKMapTypeHybrid;
    self.mapView.showsUserLocation = YES;
    self.mapView.showsBuildings = YES;
    self.mapView.pitchEnabled = YES;
    
    self.mapView.delegate = self;
}


-(void)syncViewWithModel{
    [self.model retrieveDetail];
    [self updateMap];
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
