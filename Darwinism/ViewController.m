//
//  ViewController.m
//  study_JQueryUI
//
//  Created by 青宝 中 on 12-10-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "GADBannerView.h"
#import "GADRequest.h"

#define kSampleAdUnitID @"a14e365a26a7b67"

@interface ViewController ()

@end

@implementation ViewController

@synthesize webView;
@synthesize lastUrl;

- (void)dealloc
{
    self.lastUrl = nil;
    self.adBanner.delegate = nil;
    self.adBanner = nil;
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self updateToShowInfo];
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"jquery/index.html"]];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    self.webView.scrollView.bounces = NO;
    self.webView.delegate = self;
    self.lastUrl = url.absoluteString.lastPathComponent;
    
    // admob
    // Initialize the banner at the bottom of the screen.
    CGPoint origin = CGPointMake(0.0,
                                 self.view.frame.size.height -
                                 CGSizeFromGADAdSize(kGADAdSizeBanner).height);
    
    // Use predefined GADAdSize constants to define the GADBannerView.
    self.adBanner = [[[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner
                                                    origin:origin]
                     autorelease];
    
    // Note: Edit SampleConstants.h to provide a definition for kSampleAdUnitID
    // before compiling.
    self.adBanner.adUnitID = kSampleAdUnitID;
    self.adBanner.delegate = self;
    [self.adBanner setRootViewController:self];
    [self.view addSubview:self.adBanner];
    self.adBanner.center =
    CGPointMake(self.view.center.x, self.adBanner.center.y);
    [self.adBanner loadRequest:[self createRequest]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)updateToShowInfo
{
    [self.adBanner setHidden:!(self.webView.canGoBack && [self.lastUrl.lastPathComponent rangeOfString:@"video"].length != 0)];

    [self performSelector:@selector(updateToShowInfo) withObject:nil afterDelay:0.1];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    self.lastUrl = request.URL.absoluteString;
    
    return YES;
}

#pragma mark GADRequest generation

// Here we're creating a simple GADRequest and whitelisting the application
// for test ads. You should request test ads during development to avoid
// generating invalid impressions and clicks.
- (GADRequest *)createRequest {
    GADRequest *request = [GADRequest request];
    
    // Make the request for a test ad. Put in an identifier for the simulator as
    // well as any devices you want to receive test ads.
    request.testDevices =
    [NSArray arrayWithObjects:
     // TODO: Add your device/simulator test identifiers here. They are
     // printed to the console when the app is launched.
     nil];
    return request;
}

#pragma mark GADBannerViewDelegate callbacks

// We've received an ad successfully.
- (void)adViewDidReceiveAd:(GADBannerView *)adView {
    NSLog(@"Received ad successfully");
}

- (void)adView:(GADBannerView *)view
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"Failed to receive ad with error: %@", [error localizedFailureReason]);
}


@end
