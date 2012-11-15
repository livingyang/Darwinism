//
//  ViewController.h
//  study_JQueryUI
//
//  Created by 青宝 中 on 12-10-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GADBannerViewDelegate.h"

@class GADBannerView, GADRequest;
@interface ViewController : UIViewController <UIWebViewDelegate, GADBannerViewDelegate>

@property (nonatomic, assign) IBOutlet UIWebView *webView;
@property (nonatomic, retain) NSString *lastUrl;

@property (strong, nonatomic) GADBannerView *adBanner;

- (GADRequest *)createRequest;

@end
