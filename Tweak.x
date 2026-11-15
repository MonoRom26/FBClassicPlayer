#import <UIKit/UIKit.h>

%hook FBShortFormVideoViewController

- (void)viewDidLoad {
    %orig;
    [self dismissViewControllerAnimated:NO completion:nil];
}

%end

%hook FBVideoPlaybackController

- (BOOL)isReelsPlayerEnabled {
    return NO;
}

- (BOOL)shouldUseShortFormPlayer {
    return NO;
}

%end
