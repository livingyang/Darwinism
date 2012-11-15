//
//  ViewController.m
//  study_JQueryUI
//
//  Created by 青宝 中 on 12-10-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize webView;
@synthesize lastUrl;

- (void)dealloc
{
    self.lastUrl = nil;
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    [self.webView loadHTMLString:@"aaa" baseURL:nil];
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"jquery/index.html"]];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    self.webView.scrollView.bounces = NO;
    self.webView.delegate = self;
    
    [self updateToShowInfo];
//    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"jquery.mobile-1.2.0/demos/index.html"]];
    
//    self.textField.enablesReturnKeyAutomatically = YES;
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
    NSLog(@"url last = %@, canBack = %d", [self.lastUrl lastPathComponent], self.webView.canGoBack);

    [self performSelector:@selector(updateToShowInfo) withObject:nil afterDelay:1];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    self.lastUrl = request.URL.absoluteString;
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"webview = %@, canBack = %d", self.webView, self.webView.canGoBack);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webview = %@, canBack = %d", self.webView, self.webView.canGoBack);
}

@end
