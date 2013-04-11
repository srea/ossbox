//
//  RootViewController.m
//  SVWebViewController
//
//  Created by Sam Vermette on 21.02.11.
//  Copyright 2011 Sam Vermette. All rights reserved.
//

#import "SVWebDemoViewController.h"
#import <SVWebViewController.h>

@implementation SVWebDemoViewController


- (void)pushWebViewController {
    NSURL *URL = [NSURL URLWithString:@"http://en.wikipedia.org/wiki/Friday_(Rebecca_Black_song)"];
	SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:URL];
	[self.navigationController pushViewController:webViewController animated:YES];
}


- (void)presentWebViewController {
	NSURL *URL = [NSURL URLWithString:@"http://en.wikipedia.org/wiki/Friday_(Rebecca_Black_song)"];
	SVModalWebViewController *webViewController = [[SVModalWebViewController alloc] initWithURL:URL];
	webViewController.modalPresentationStyle = UIModalPresentationPageSheet;
    webViewController.availableActions = SVWebViewControllerAvailableActionsOpenInSafari | SVWebViewControllerAvailableActionsOpenInSafari | SVWebViewControllerAvailableActionsCopyLink | SVWebViewControllerAvailableActionsMailLink;
    webViewController.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    webViewController.toolbar.tintColor = [UIColor darkGrayColor];
	[self presentModalViewController:webViewController animated:YES];	
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}


@end

