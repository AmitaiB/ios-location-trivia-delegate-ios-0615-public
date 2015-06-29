//
//  FISAddLocationViewControllerDelegate.h
//  ios-location-trivia-delegate
//
//  Created by Amitai Blickstein on 6/28/15.
//  Copyright (c) 2015 The Flatiron School. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "FISAddLocationViewController.h"
//#import "FISLocationsViewController.h"
//#import "FISLocation.h"

@class FISAddLocationViewController;

@protocol FISAddLocationViewControllerDelegate <NSObject>

@required
-(void)addLocationViewControllerDidCancel:(FISAddLocationViewController *)viewController;

-(BOOL)addLocationViewController:(FISAddLocationViewController *)viewController shouldAllowLocationNamed:(NSString *)locationName;

-(void)addLocationViewController:(FISAddLocationViewController *)viewController didAddLocationNamed:(NSString *)locationName;

@end
