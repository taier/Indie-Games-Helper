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
#import "AdvertisingBannerHelper.h"

@interface AdvertisingHandler () <AdvertisingFullScreenDelegate, AdvertisingBannerDelegate>

@end

@implementation AdvertisingHandler

SINGLETON_GCD(AdvertisingHandler);

- (instancetype)init {
    self = [super init];
    if (self) {
        [AdvertisingFullScreenHelper sharedInstance].delegate = self;
        [AdvertisingBannerHelper sharedInstance].delegate = self;
    }
    return self;
}

#pragma mark Public methods

- (void)prepareFullScreenAdvertInViewController:(UIViewController *)viewController {
    [[AdvertisingFullScreenHelper sharedInstance] prepareFullScreenAdvertInViewController:viewController];
}

- (void)showFullScreenAdvertIfLoadedInViewController:(UIViewController *)viewController {
    [[AdvertisingFullScreenHelper sharedInstance] showFullScreenAdvertIfLoadedInViewController:viewController];
}

- (void)prepareBannerAdvertInViewController:(UIViewController *)viewController withSize:(AdvertBannerSize)bannerSize {
    [[AdvertisingBannerHelper sharedInstance] prepareBannerAdvertInViewController:viewController withSize:bannerSize];
}

- (void)showBannerAdverIfLoadedInViewController:(UIViewController *)viewController withBannerCenter:(CGPoint)center andSize:(AdvertBannerSize)bannerSize {
    [[AdvertisingBannerHelper sharedInstance] showBannerAdvertIfLoadedInViewController:viewController withBannerCenter:center andSize:bannerSize];
}

#pragma mark Full Screen Delegates

- (void)fullScreenAdvertDidLoad {
    [self.delegate fullScreenAdvertDidLoad];
}

- (void)fullScreenAdvertPresented {
    [self.delegate fullScreenAdvertPresented];
}

- (void)fullScreenAdvertWasClosed {
    [self.delegate fullScreenAdvertWasClosed];
}

#pragma mark Banner View Delegates

- (void)advertisingBannerDidLoad {
    [self.delegate advertisingBannerDidLoad];
}

@end
