//
//  PARCreateNoteViewController.m
//  
//
//  Created by Pablo Parejo Camacho on 14/8/15.
//
//

#import "PARCreateNoteViewController.h"
#import "PARNote.h"
#import "AppDelegate.h"

@interface PARCreateNoteViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *noteImage;
@property (weak, nonatomic) IBOutlet UITextField *noteText;

@property (weak, nonatomic) IBOutlet UILabel *noteAddress;
@end

@implementation PARCreateNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


#pragma mark - UIImagePickerControllerDelegate

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.noteImage.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}


- (IBAction)addLocation:(id)sender {
}
- (IBAction)saveNote:(id)sender {
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    PARNote *note = [PARNote noteWithContext:appDelegate.managedObjectContext text:self.noteText.text];
    note.image = self.noteImage;
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

# pragma mark - Utils

-(void) hideKeyboard{
    [self.view endEditing:YES];
}


@end
