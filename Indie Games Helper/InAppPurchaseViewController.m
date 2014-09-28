//
//  InAppPurchaseViewController.m
//  Indie Games Helper
//
//  Created by Denis on 27/09/2014.
//  Copyright (c) 2014 deniss.kaibagarovs@gmail.com, Denis Kaibagarovs. All rights reserved.
//

#import "InAppPurchaseViewController.h"
#import "IndieGamesHelper.h"

@implementation InAppPurchaseViewController

- (IBAction)onBuyButtonPress:(id)sender {
    [[IndieGamesHelper sharedInstance] purchaseRemovingAD];
}

- (IBAction)onRestoreButtonPress:(id)sender {
    [[IndieGamesHelper sharedInstance] restorePurchase];
}

@end
