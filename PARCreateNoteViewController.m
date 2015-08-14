//
//  PARCreateNoteViewController.m
//  
//
//  Created by Pablo Parejo Camacho on 14/8/15.
//
//

#import "PARCreateNoteViewController.h"
#import "PARBook.h"
#import "PARNote.h"
#import "AppDelegate.h"
@import CoreLocation;

@interface PARCreateNoteViewController () < UINavigationControllerDelegate,
                                            UIImagePickerControllerDelegate,
                                            CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *noteImage;
@property (weak, nonatomic) IBOutlet UITextField *noteText;
@property (weak, nonatomic) IBOutlet UILabel *noteAddress;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic) CLLocationCoordinate2D coordinate;

@end

@implementation PARCreateNoteViewController

-(instancetype) initWithBook:(PARBook *) book{
    if (self = [super init]) {
        self.book = book;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tap];
}



#pragma mark - IBAction
- (IBAction)addImage:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePicker.allowsEditing = NO;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}


- (IBAction)addLocation:(id)sender {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.delegate = self;
    
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    
}
- (IBAction)saveNote:(id)sender {
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    PARNote *note = [PARNote noteWithContext:appDelegate.managedObjectContext
                                        book:self.book
                                        text:self.noteText.text];
    note.image = self.noteImage;
    note.latitude = [NSNumber numberWithDouble:self.coordinate.latitude];
    note.longitude = [NSNumber numberWithDouble:self.coordinate.longitude ];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)close:(id)sender {
    // We could add "Are you sure..." if any field is set
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UIImagePickerControllerDelegate

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.noteImage.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

# pragma mark - CLLocationManagerDelegate

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location = [locations lastObject];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location
                   completionHandler:^(NSArray *placemarks, NSError *error){
                       if (placemarks.count > 0) {
                           CLPlacemark *placemark = [placemarks firstObject];
                           self.noteAddress.text = [NSString stringWithFormat:@"%@, %@", [placemark thoroughfare], [placemark locality]];
                           
                           self.coordinate = location.coordinate;
                       }
                       
                   }];
}


# pragma mark - Utils

-(void) hideKeyboard{
    [self.view endEditing:YES];
}


@end
