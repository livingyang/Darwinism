//
//  ViewController.h
//  study_JQueryUI
//
//  Created by 青宝 中 on 12-10-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, assign) IBOutlet UIWebView *webView;
@property (nonatomic, retain) NSString *lastUrl;

@end
