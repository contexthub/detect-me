//
//  DMAppDelegate.m
//  DetectMe
//
//  Created by Jeff Kibuule on 8/3/14.
//  Copyright (c) 2014 ChaiOne. All rights reserved.
//

#import "DMAppDelegate.h"
#import "DMConstants.h"

@interface DMAppDelegate ()
@end

@implementation DMAppDelegate
            
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
#ifdef DEBUG
    // The debug flag is automatically set by the compiler, indicating which push gateway server your device will use
    // Xcode deployed builds use the sandbox/development server
    // TestFlight/App Store builds use the production server
    // ContextHub records which environment a device is using so push works properly
    // This must be called BEFORE [ContextHub registerWithAppId:]
    [[ContextHub sharedInstance] setDebug:TRUE];
#endif
    
    // Register the app id of the application you created on https://app.contexthub.com
    [ContextHub registerWithAppId:@"YOUR-BEACON-APP-ID-HERE"];
    
    //Set the app delegate as the Datasource and Delegate of the Sensor Pipeline so that we can tap into the events.
    [[CCHSensorPipeline sharedInstance] setDelegate:self];
    [[CCHSensorPipeline sharedInstance] setDataSource:self];
    
    //This tells ContextHub about the tags you will use to identify the Beacons that you want to automatically monitor.
    if (![[CCHSensorPipeline sharedInstance] addElementsWithTags:@[DMBeaconTag]]) {
        NSLog(@"DM: Failed to add subscription to \"%@\" tag", DMBeaconTag);
    } else {
        NSLog(@"DM: Subscribed to tag \"%@\" tag", DMBeaconTag);
    }
    
    return YES;
}

#pragma mark - Sensor Pipeline Delegate

- (BOOL)sensorPipeline:(CCHSensorPipeline *)sensorPipeline shouldPostEvent:(NSDictionary *)event {
    // If you'd like to keep events from hitting the server, you can return NO here.
    // This is a good spot to filter events.
    //NSLog(@"DM: Should post event %@", event);
    
    return YES;
}

- (void)sensorPipeline:(CCHSensorPipeline *)sensorPipeline willPostEvent:(NSDictionary *)event {
    // If you want to access event data directl before it will be posted to the server, you can do that here
    //NSLog(@"DM: Will post event %@", event);
}

- (void)sensorPipeline:(CCHSensorPipeline *)sensorPipeline didPostEvent:(NSDictionary *)event {
    // If you want to access event data directly after it has been posted to the server, you can do that here
    //NSLog(@"DM: Did post event %@", event);
}

#pragma mark - Sensor Pipeline Data Source

- (NSDictionary *)sensorPipeline:(CCHSensorPipeline *)sensorPipeline payloadForEvent:(NSDictionary *)event {
    // Add custom data structures to the events, and they will end up on the server in the payload property
    return @{};
}

@end