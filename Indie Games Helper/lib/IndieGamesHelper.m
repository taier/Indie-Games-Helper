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

#import "IndieGamesHelper.h"

#import "SharingHandler.h"
#import "GameCenterHandler.h"
#import "InAppPurchaseHandler.h"
#import "AdvertisingHandler.h"

@interface IndieGamesHelper () <InAppPurchaseDelegate, AdvertisingHandlerDelegate> {
     NSMutableArray *_delegatesReceiversArray;
}

@end

@implementation IndieGamesHelper

SINGLETON_GCD(IndieGamesHelper);

- (instancetype)init {
    self = [super init];
    if (self) {
        [InAppPurchaseHandler sharedInstance].delegate = self;
        [AdvertisingHandler sharedInstance].delegate = self;
        _delegatesReceiversArray = [NSMutableArray new];
    }
    return self;
}

- (void)setDelegate:(id<IndieGamesHelperDeleate>)delegate {
    if (![_delegatesReceiversArray containsObject:delegate]) {
        [_delegatesReceiversArray addObject:delegate];
    }
}

#pragma mark Share

- (void)shareFacebookInViewController:(UIViewController *)viewController andText:(NSString *)text {
    [SharingHandler shareFacebookInViewController:viewController andText:text];
}

- (void)shareTwitterInViewController:(UIViewController *)viewController andText:(NSString *)text {
    [SharingHandler shareTwitterInViewController:viewController andText:text];
}

#pragma mark Game Center

- (void)authenticateLocalUser {
    [[GameCenterHandler sharedInstance] authenticateLocalUser];
}

- (void)reportScore:(long long int)score {
    [[GameCenterHandler sharedInstance] reportScore:score];
}

- (void)showLeaderboardInViewController:(UIViewController *)viewController {
    [[GameCenterHandler sharedInstance] showLeaderboardInViewController:viewController];
}

#pragma mark In App Purchases

- (void)purchaseRemovingAD {
    [[InAppPurchaseHandler sharedInstance] purchaseRemovingAD];
}

- (void)restorePurchase {
    [[InAppPurchaseHandler sharedInstance] restorePurchase];
}

#pragma mark In App Purchases delegate

- (void)removeADSSuccess {
    if ([self.delegate respondsToSelector:@selector(removeADSSuccess)]) {
        [self.delegate removeADSSuccess];
    }
}

#pragma mark Advertising Methods

- (void)prepareFullScreenAdvertInViewController:(UIViewController *)viewController {
    [[AdvertisingHandler sharedInstance] prepareFullScreenAdvertInViewController:viewController];
}

- (void)showFullScreenAdvertIfLoadedInViewController:(UIViewController *)viewController {
    [[AdvertisingHandler sharedInstance] showFullScreenAdvertIfLoadedInViewController:viewController];
}

- (void)prepareBannerAdvertInViewController:(UIViewController *)viewController withSize:(AdvertBannerSize)bannerSize {
    [[AdvertisingHandler sharedInstance] prepareBannerAdvertInViewController:viewController withSize:bannerSize];
}

- (void)showBannerAdvertIfLoadedInViewController:(UIViewController *)viewController withBannerCenter:(CGPoint)center andSize:(AdvertBannerSize)bannerSize {
    [[AdvertisingHandler sharedInstance] showBannerAdverIfLoadedInViewController:viewController withBannerCenter:center andSize:bannerSize];
}

#pragma mark Advertising Delegates

- (void)fullScreenAdvertDidLoad {
    for (id<IndieGamesHelperDeleate> delegateReceiver in _delegatesReceiversArray) {
        if ([delegateReceiver respondsToSelector:@selector(fullScreenAdvertDidLoad)]) {
            [delegateReceiver fullScreenAdvertDidLoad];
        }
    }
}

- (void)fullScreenAdvertPresented {
    for (id<IndieGamesHelperDeleate> delegateReceiver in _delegatesReceiversArray) {
        if ([delegateReceiver respondsToSelector:@selector(fullScreenAdvertPresented)]) {
            [delegateReceiver fullScreenAdvertPresented];
        }
    }
}

- (void)fullScreenAdvertWasClosed {
    for (id<IndieGamesHelperDeleate> delegateReceiver in _delegatesReceiversArray) {
        if ([delegateReceiver respondsToSelector:@selector(fullScreenAdvertWasClosed)]) {
            [delegateReceiver fullScreenAdvertWasClosed];
        }
    }
}

- (void)advertisingBannerDidLoad {
    for (id<IndieGamesHelperDeleate> delegateReceiver in _delegatesReceiversArray) {
        if ([delegateReceiver respondsToSelector:@selector(advertisingBannerDidLoad)]) {
            [delegateReceiver advertisingBannerDidLoad];
        }
    }
}

@end
