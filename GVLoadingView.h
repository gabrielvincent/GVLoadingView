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
	UIActivityIndicatorView *spinner;
	UIButton *reloadButton;
	UITapGestureRecognizer *reloadTapGesture;
}

@property (nonatomic, unsafe_unretained) UIViewController <GVLoadingViewDelegate> *delegate;
@property (nonatomic) SEL reloadMethod;

// Message label
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic) CGSize messageLabelShadowOffset;
@property (nonatomic, strong) UIColor *messageLabelShadowColor;
@property (nonatomic, strong) UIFont *messageLabelFont;
@property (nonatomic, strong) UIColor *messageLabelColor;

// Activity indicator view
@property (nonatomic, strong) UIColor *spinnerColor;

// View
@property (nonatomic) CGFloat animationTime;
@property (nonatomic, strong) UIImage *reloadImage;

- (void) showWithAnimation:(GVLoadingViewShowAnimation)animation;
- (void) dismissWithAnimation:(GVLoadingViewDismissAnimation)animation;
- (void) enterReloadModeWithMessage:(NSString *) reloadMessage;
- (void) exitReloadModeWithMessage:(NSString *) reloadMessage;

@end
