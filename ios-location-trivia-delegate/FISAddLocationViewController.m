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
    self.saveButton.enabled = NO;
}

-(IBAction)cancelButtonTapped:(id)sender
{
    [self.delegate addLocationViewControllerDidCancel:self];
}

-(IBAction)saveButtonTapped:(id)sender
{
    [self.delegate addLocationViewController:self didAddLocationNamed:self.nameField.text];
}




-(BOOL)prefersStatusBarHidden
{
    return YES;
}



@end
