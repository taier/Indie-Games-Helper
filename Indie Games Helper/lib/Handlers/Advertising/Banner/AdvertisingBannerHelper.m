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
#import "AdvertisingBannerHelper.h"

// Google Advert
#import "GADBannerView.h"
#import "GADRequest.h"

@interface AdvertisingBannerHelper () <ADBannerViewDelegate,GADBannerViewDelegate> {
    BOOL _iADLoaded;
    BOOL _iADIsVisible;
    BOOL _googleAdvertLoaded;
    BOOL _googleAdvertIsVisible;
    ADBannerView *_iAdBannderView;
    GADBannerView  *_googleBannerView;
}

@end

@implementation AdvertisingBannerHelper

SINGLETON_GCD(AdvertisingBannerHelper);

#pragma mark Public Methods

- (void)prepareBannerAdvertInViewController:(UIViewController *)viewController withSize:(AdvertBannerSize)bannerSize {
    
    // Remove all adverts
    _iADIsVisible = NO;
    _googleAdvertIsVisible = NO;
    [_iAdBannderView removeFromSuperview];
    [_googleBannerView removeFromSuperview];
    
    // Try to prepare iAD
    _iADLoaded = NO;
    _iAdBannderView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
    _iAdBannderView.delegate = self;
    
    // Tr to prepare Google
    _googleBannerView = [[GADBannerView alloc] initWithAdSize:(bannerSize == AdvertBannerSizeSmartPortrait) ? kGADAdSizeSmartBannerPortrait: kGADAdSizeSmartBannerLandscape];
    _googleBannerView.delegate = self;
    // Check for identifier
    ASIdentifierManager *adIdentManager = [ASIdentifierManager sharedManager];
    if (adIdentManager.advertisingTrackingEnabled) {
        _googleBannerView.adUnitID = GOOGLE_ADVERT_ID;
    }
    // Set View controller
    _googleBannerView.rootViewController = viewController;
    // Try to request advert
    [_googleBannerView loadRequest:[GADRequest request]];
}

- (void)showBannerAdvertIfLoadedInViewController:(UIViewController *)viewController withBannerCenter:(CGPoint)center andSize:(AdvertBannerSize)bannerSize {
    
    // If already showing
    if(_iADIsVisible || _googleAdvertIsVisible) return;
    
    // Decide what what to show, iAD or Google
    if(_iADLoaded) {
        [self p_showiAdBannerViewInViewController:viewController withBannerCenter:center];
    } else {
        [self p_showGoogleBanneViewInViewController:viewController withBannerCenter:center];
    }
}

#pragma mark Private Methods

- (void)p_showiAdBannerViewInViewController:(UIViewController *)viewController withBannerCenter:(CGPoint)center {
    // Check, if already present
    if([viewController.view.subviews containsObject:_iAdBannderView]) return;
    // Set center
    _iAdBannderView.center = center;
    // Add to view
    [viewController.view addSubview:_iAdBannderView];
    // iAD is visible
    _iADIsVisible = YES;
}

- (void)p_showGoogleBanneViewInViewController:(UIViewController *)viewController withBannerCenter:(CGPoint)center {
    // Check, if already present
    if([viewController.view.subviews containsObject:_googleBannerView]) return;
    // Set Center
    _googleBannerView.center = center;
    // Add to view
    [viewController.view addSubview:_googleBannerView];
    // Google Advert is visible
    _googleAdvertIsVisible = YES;
}

#pragma mark iAD Banners Delegates

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    _iADLoaded = YES;
    [self.delegate advertisingBannerDidLoad];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    // iAd Failed
    _iADLoaded = NO;
    [_iAdBannderView removeFromSuperview];
}

#pragma mark Goole Banner Delegates

- (void)adViewDidReceiveAd:(GADBannerView *)view {
    _googleAdvertLoaded = YES;
    [self.delegate advertisingBannerDidLoad];
}

- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error  {
    // Google Advert Fails
    _googleAdvertLoaded = NO;
    [_googleBannerView removeFromSuperview];
}

@end
