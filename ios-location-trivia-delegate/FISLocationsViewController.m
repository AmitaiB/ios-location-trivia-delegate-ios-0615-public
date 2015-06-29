//
//  FISLocationsViewController.m
//  ios-location-trivia-delegate
//
//  Created by Timothy Clem on 6/23/15.
//  Copyright (c) 2015 The Flatiron School. All rights reserved.
//

#import "FISLocationsViewController.h"
#import "FISLocation.h"
#import "FISAddLocationViewController.h"
#import "FISAddLocationViewControllerDelegate.h"

@interface FISLocationsViewController () <FISAddLocationViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *triviaLocations;
@property (nonatomic, strong) NSMutableArray *triviaLocationNamesLowerCase;

@end

@implementation FISLocationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    FISLocation *empireStateBuilding = [[FISLocation alloc] initWithName:@"Empire State Building" trivia:@[ @"1,454 Feet Tall", @"Cost $24,718,000 to build" ]];

    FISLocation *bowlingGreen = [[FISLocation alloc] initWithName:@"Bowling Green" trivia:@[ @"NYC's oldest park", @"Made a park in 1733", @"Charging Bull was created in 1989" ]];

    self.triviaLocations = [@[ empireStateBuilding, bowlingGreen ] mutableCopy];
}

#pragma mark - Override setter

-(void)setTriviaLocations:(NSMutableArray *)triviaLocations
{
    _triviaLocations = triviaLocations;
    
    NSMutableArray *locationNamesTemp = [[NSMutableArray alloc] init];
    for (FISLocation *triviaLocation in triviaLocations) {
        [locationNamesTemp addObject:[(NSString*)triviaLocation.name lowercaseString]];
    }
    _triviaLocationNamesLowerCase = locationNamesTemp;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.triviaLocations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LocationCell" forIndexPath:indexPath];

    FISLocation *location = self.triviaLocations[indexPath.row];
    cell.textLabel.text = location.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu facts", location.trivia.count];
    
    return cell;
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"locationsToAddLocationsSegueID"]) {
        FISAddLocationViewController *addLocationVC = segue.destinationViewController;
        addLocationVC.delegate = self;
    }
}

#pragma mark - Delegate protocol methods

-(void)addLocationViewControllerDidCancel:(FISAddLocationViewController *)viewController
{
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)addLocationViewController:(FISAddLocationViewController *)viewController shouldAllowLocationNamed:(NSString *)locationName
{
    BOOL isAlreadyInList = [self.triviaLocationNamesLowerCase containsObject:[(NSString*)locationName lowercaseString]]; 
    if (isAlreadyInList) {
        return viewController.saveButton.enabled = NO;
    } else
        return viewController.saveButton.enabled = YES;
}

-(void)addLocationViewController:(FISAddLocationViewController *)viewController didAddLocationNamed:(NSString *)locationName
{
    FISLocation *newLocation = [[FISLocation alloc] initWithName:locationName trivia:@[]];
    [self.triviaLocations addObject:newLocation];
    [viewController dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
}


@end
