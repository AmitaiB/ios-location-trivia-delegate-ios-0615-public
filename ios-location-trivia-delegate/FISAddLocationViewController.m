//
//  FISAddLocationViewController.m
//  ios-location-trivia-delegate
//
//  Created by Timothy Clem on 6/23/15.
//  Copyright (c) 2015 The Flatiron School. All rights reserved.
//

#import "FISAddLocationViewController.h"

@interface FISAddLocationViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;

@end

@implementation FISAddLocationViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.nameField.delegate = self;
//    self.saveButton.enabled = NO;
}

-(IBAction)cancelButtonTapped:(id)sender
{
    [self.delegate addLocationViewControllerDidCancel:self];
}

-(IBAction)saveButtonTapped:(id)sender
{
    
    if (![self.nameField.text isEqualToString:@""] &&
        [self.delegate addLocationViewController:self shouldAllowLocationNamed:self.nameField.text]) {
        [self.delegate addLocationViewController:self didAddLocationNamed:self.nameField.text];
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.nameField) {
        if([self.delegate addLocationViewController:self shouldAllowLocationNamed:self.nameField.text]) {
            self.saveButton.enabled = YES;
        } else {
            self.saveButton.enabled = NO;
        };
    }
    
    return YES;
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}



@end
