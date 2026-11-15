#import <UIKit/UIKit.h>

@interface FBShortFormVideoViewController : UIViewController
@end

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
