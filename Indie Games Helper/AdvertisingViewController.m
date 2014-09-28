//
//  AdvertisingViewController.m
//  Indie Games Helper
//
//  Created by Denis on 27/09/2014.
//  Copyright (c) 2014 deniss.kaibagarovs@gmail.com, Denis Kaibagarovs. All rights reserved.
//

#import "AdvertisingViewController.h"
#import "IndieGamesHelper.h"

@interface AdvertisingViewController () <IndieGamesHelperDeleate>

@end

@implementation AdvertisingViewController

- (void)viewDidLoad {
    [IndieGamesHelper sharedInstance].delegate = self;
    [[IndieGamesHelper sharedInstance] prepareFullScreenAdvertInViewController:self];
    [[IndieGamesHelper sharedInstance] prepareBannerAdvertInViewController:self withSize:AdvertBannerSizeSmartPortrait];
}

#pragma mark Buttons

- (IBAction)onShowFullScreenAdvertPress:(id)sender {
    [[IndieGamesHelper sharedInstance] showFullScreenAdvertIfLoadedInViewController:self];
}

#pragma mark Advertising delegates

- (void)advertisingBannerDidLoad {
    [[IndieGamesHelper sharedInstance] showBannerAdvertIfLoadedInViewController:self withBannerCenter:CGPointMake(160, 220) andSize:AdvertBannerSizeSmartPortrait];
}

@end
