//  Copyright (c) 2014 Tabcorp Pty. Ltd. All rights reserved.

#import "TBCCoreExampleAppDelegate.h"

#import "TBCCoreExampleViewController.h"

@implementation TBCCoreExampleAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[TBCCoreExampleViewController alloc] initWithNibName:nil bundle:nil];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
