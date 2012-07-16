//
//  GVLoadingView.h
//  Loader
//
//  Created by Gabriel Vincent on 14/07/12.
//  Copyright (c) 2012 _A_Z. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GVLoadingView;

typedef enum {
    GVLoadingViewShowAnimationAppear,
	GVLoadingViewShowAnimationFade,
	GVLoadingViewShowAnimationShutter,
	GVLoadingViewShowAnimationDrop,
	GVLoadingViewShowAnimationNone
} GVLoadingViewShowAnimation;

typedef enum {
    GVLoadingViewDismissAnimationDisappear,
	GVLoadingViewDismissAnimationFade,
	GVLoadingViewDismissAnimationShutter,
	GVLoadingViewDismissAnimationNone
} GVLoadingViewDismissAnimation;

@protocol GVLoadingViewDelegate <NSObject>

@end

@interface GVLoadingView : UIView <GVLoadingViewDelegate> {
	CGRect finalFrame;
	__unsafe_unretained UIViewController <GVLoadingViewDelegate> *delegate;
	UIButton *reloadButton;
	UITapGestureRecognizer *reloadTapGesture;
	BOOL isFirstCall;
}

@property (nonatomic, unsafe_unretained) UIViewController <GVLoadingViewDelegate> *delegate;
@property (nonatomic) SEL reloadMethod;

// Message label
@property (nonatomic, strong) UILabel *messageLabel;

// Activity indicator view
@property (nonatomic, strong) UIActivityIndicatorView *spinner;

// View
@property (nonatomic) CGFloat animationTime;
@property (nonatomic, strong) UIImage *reloadImage;

- (void) showWithAnimation:(GVLoadingViewShowAnimation)animation;
- (void) dismissWithAnimation:(GVLoadingViewDismissAnimation)animation;
- (void) enterReloadModeWithMessage:(NSString *) reloadMessage;
- (void) exitReloadModeWithMessage:(NSString *) reloadMessage;

@end
