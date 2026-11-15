#import <UIKit/UIKit.h>
#import <objc/runtime.h>

// 1. Disable Unified Video / Reels full-screen routing flags in v473.0.0
%hook FBUnifiedVideoPlayerConfig

- (BOOL)isUnifiedPlayerEnabled {
    return NO;
}

- (BOOL)shouldUseReelsPlayerForVerticalVideo {
    return NO;
}

- (BOOL)enableShortFormPlayer {
    return NO;
}

%end

// 2. Prevent 9:16 vertical videos from triggering the Short-Form / Reels container
%hook FBVideoPlayerRouter

- (BOOL)shouldRouteToReelsForVideo:(id)video {
    return NO;
}

- (BOOL)isShortFormVideo:(id)video {
    return NO;
}

%end

// 3. Hook common v473.0.0 Reels / Short-Form ViewControllers
%hook FBReelsPlayerViewController

- (BOOL)shouldAutorotate {
    return YES;
}

%end

// 4. Hook UIViewController presentation to catch and inspect/block the v473 Reels modal if pushed
%hook UIViewController

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    NSString *vcName = NSStringFromClass([viewControllerToPresent class]);
    
    // Check if Facebook v473 is trying to open its Reels / Unified Short-Form modal
    if ([vcName containsString:@"Reels"] || 
        [vcName containsString:@"ShortForm"] || 
        [vcName containsString:@"UnifiedVideo"]) {
        NSLog(@"[FBClassicPlayer] Intercepted 9:16 player VC: %@", vcName);
    }
    
    %orig;
}

%end
