/*
 The MIT License (MIT)
 
 Copyright (c) 2014 deniss.kaibagarovs@gmail.com, Denis Kaibagarovs.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 */

#import "AdvertisingHandler.h"
#import "AdvertisingFullScreenHelper.h"
#import "iADViewController.h"
#import "GADInterstitial.h"

@interface AdvertisingFullScreenHelper () <iADVControllerDelegate, ADInterstitialAdDelegate, GADInterstitialDelegate> {
    
    BOOL _iADLoaded;
    BOOL _googleAdvertLoaded;
    ADInterstitialAd *_iADInterstitial;
    iADViewController *_iADViewController;
    GADInterstitial *_googleAdverInterstitial;
}

@end

@implementation AdvertisingFullScreenHelper

SINGLETON_GCD(AdvertisingFullScreenHelper);

#pragma mark Public Methods

- (void)prepareFullScreenAdvertInViewController:(UIViewController *)viewController {
    // Remove old stuff
    _iADLoaded = NO;
    _googleAdvertLoaded = NO;
    _iADInterstitial = nil;
    _googleAdverInterstitial = nil;
    
    // Prepare iAD
    [self p_prepareiAD];
    // Prepare Google advert
    [self p_prepareGoogleAdvert];
}

- (void)showFullScreenAdvertIfLoadedInViewController:(UIViewController *)viewController {
    if(_iADLoaded) {
        [self p_showiADFulScreenInViewController:viewController];
    } else if (_googleAdvertLoaded) {
        [self p_showGoogleAdvertInViewController:viewController];
    }
}

#pragma mark Private Methods

- (void)p_initiADController {
    // Init View Controller for iAD
    _iADViewController = nil;
    _iADViewController = [[iADViewController alloc]init];
    _iADViewController.delegate = self;
}

- (void)p_cycleInterstitial {
    // Clean up the old interstitial...
    _iADInterstitial = nil;
    // and create a new interstitial. We set the delegate so that we can be notified of when
    _iADInterstitial = [[ADInterstitialAd alloc] init];
    _iADInterstitial.delegate = self;
}

- (void)p_prepareiAD {
    [self p_initiADController];
    [self p_cycleInterstitial];
}

- (void)p_prepareGoogleAdvert {
    // Init google Advert
    _googleAdverInterstitial = [[GADInterstitial alloc] init];
    _googleAdverInterstitial.delegate = self;
    // Check for Indentifier
    ASIdentifierManager *adIdentManager = [ASIdentifierManager sharedManager];
    if (adIdentManager.advertisingTrackingEnabled) {
        _googleAdverInterstitial.adUnitID = GOOGLE_ADVERT_ID;
    }
    // Try to request
    GADRequest *request = [GADRequest request];
    [_googleAdverInterstitial loadRequest:request];
}

- (void)p_showiADFulScreenInViewController:(UIViewController *)viewController {
    [viewController presentViewController:_iADViewController animated:YES completion:nil];
    [_iADInterstitial presentInView:_iADViewController.view];
    [self.delegate fullScreenAdvertPresented];
}

- (void)p_showGoogleAdvertInViewController:(UIViewController *)viewController {
    [_googleAdverInterstitial presentFromRootViewController:viewController];
    [self.delegate fullScreenAdvertPresented];
}

#pragma mark iADController Delegates

- (void)d_iADwasClosed {
    [self.delegate fullScreenAdvertWasClosed];
}

#pragma mark iADInterstitialViewDelegate Delegates

- (void)interstitialAdDidUnload:(ADInterstitialAd *)interstitialAd
{
    [self p_cycleInterstitial];
}

- (void)interstitialAd:(ADInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
    _iADLoaded = NO;
    [self p_cycleInterstitial];
}

-(void)interstitialAdDidLoad:(ADInterstitialAd *)interstitialAd {
    _iADLoaded = YES;
    [self.delegate fullScreenAdvertDidLoad];
}

#pragma mark Google Advert Deleagtes 

- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
    _googleAdvertLoaded = YES;
    [self.delegate fullScreenAdvertDidLoad];
}

- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error {
    _googleAdvertLoaded = NO;
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial {
    // Send delegate
    [self.delegate fullScreenAdvertWasClosed];
    // Request new advert
    [self p_prepareGoogleAdvert];
}

@end
