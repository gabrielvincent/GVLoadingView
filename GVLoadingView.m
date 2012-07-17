//
//  GVLoadingView.m
//  Loader
//
//  Created by Gabriel Vincent on 14/07/12.
//  Copyright (c) 2012 _A_Z. All rights reserved.
//

#define OriginX self.frame.origin.x
#define OriginY self.frame.origin.y
#define Width self.frame.size.width
#define Height self.frame.size.height
#define HiddenFrame CGRectMake(self.frame.origin.x, self.superview.frame.size.height, self.frame.size.width, self.frame.size.height);
#define SuperviewHeight self.superview.frame.size.height

#import "GVLoadingView.h"

@implementation GVLoadingView
@synthesize delegate, reloadMethod;
@synthesize messageLabel;
@synthesize spinner;
@synthesize animationTime;
@synthesize reloadImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		finalFrame = frame;
		messageLabel = [[UILabel alloc] init];
		spinner = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    }
    return self;
}

- (id) init {
	self = [super init];
    if (self) {
		isFirstCall = YES;
		messageLabel = [[UILabel alloc] init];
		spinner = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
	[super setFrame:frame];
    if (!CGRectIsNull(frame) && isFirstCall) {
		finalFrame = frame;
		isFirstCall = NO;
	}
}

- (void)drawRect:(CGRect)rect
{
	// View configuration
    
	// Message label configuration
    messageLabel.frame = CGRectMake(0, 0, Width, Height);
    messageLabel.backgroundColor = [UIColor clearColor];
    messageLabel.textAlignment = UITextAlignmentCenter;
	
	// Activity Indicator View configuration
	spinner.center = CGPointMake(20, Height/2);
	
	[self addSubview:messageLabel];
	[self addSubview:spinner];
	[spinner startAnimating];
}

- (void) exitReloadModeWithMessage:(NSString *) reloadMessage; {
	
	messageLabel.text = reloadMessage;
	
	spinner.center = CGPointMake(20, self.frame.size.height/2);
	[spinner startAnimating];
	
	[reloadButton removeFromSuperview];
	[self addSubview:spinner];
	
}

- (void) enterReloadModeWithMessage:(NSString *) reloadMessage {
	reloadTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:delegate action:reloadMethod];
	[self addGestureRecognizer:reloadTapGesture];
	
	messageLabel.text = reloadMessage;
	reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
	reloadButton.frame = CGRectMake(0, 0, reloadImage.size.width, reloadImage.size.height);
	[reloadButton setImage:reloadImage forState:UIControlStateNormal];
	reloadButton.center = spinner.center;
	[reloadButton addTarget:delegate action:reloadMethod forControlEvents:UIControlEventTouchUpInside];
	
	[self addSubview:reloadButton];
	[spinner stopAnimating];
	[spinner removeFromSuperview];
}

- (void) showWithAnimation:(GVLoadingViewShowAnimation)animation {
	
	[delegate.view addSubview:self];
	
	if (animation == GVLoadingViewShowAnimationNone) {
		self.frame = finalFrame;
	}
	else {
		
		if (animation == GVLoadingViewShowAnimationAppear) {
			self.frame = CGRectMake(OriginX, SuperviewHeight, Width, Height);
		}
		else if (animation == GVLoadingViewShowAnimationFade) {
			self.frame = finalFrame;
			self.alpha = 0.0;
		}
		else if (animation == GVLoadingViewShowAnimationShutter) {
			self.frame = CGRectMake(OriginX, SuperviewHeight, Width, finalFrame.size.height);
			self.frame = CGRectMake(self.frame.origin.x, SuperviewHeight-Height, Width, 0);
		}
		else if (animation == GVLoadingViewShowAnimationDrop) {
			self.frame = CGRectMake(OriginX, finalFrame.origin.y-40, Width, Height);
			self.alpha = 0.0;
		}
		
		
		[UIView animateWithDuration:animationTime animations:^{ 
			self.frame = finalFrame;
			self.alpha = 1.0;
		} completion:^(BOOL finished){
			
			if (animation == GVLoadingViewShowAnimationDrop) {
				
				[UIView animateWithDuration:animationTime animations:^{ 
					self.frame = CGRectMake(OriginX, OriginY-7, Width, Height+4);
				} completion:^(BOOL finished) {
					[UIView animateWithDuration:animationTime animations:^{ 
						self.frame = CGRectMake(OriginX, OriginY+7, Width, Height-4);
					} completion:^(BOOL finished) {
						[UIView animateWithDuration:animationTime animations:^{ 
							self.frame = CGRectMake(OriginX, OriginY-2, Width, Height+2);
						} completion:^(BOOL finished) {
							[UIView animateWithDuration:animationTime animations:^{ 
								self.frame = CGRectMake(OriginX, OriginY+2, Width, Height-2);
							}];
						}];
					}];
				}];
			}
			
		}];
	}
}

- (void) dismissWithAnimation:(GVLoadingViewDismissAnimation)animation {
	
	
	if (animation == GVLoadingViewDismissAnimationNone) {
		self.frame = HiddenFrame;
		[self removeFromSuperview];
	}
	else {
		
		if (animation == GVLoadingViewDismissAnimationDisappear) {
			[UIView animateWithDuration:animationTime animations:^{ 
				self.frame = HiddenFrame;
			}];
		}
		else if (animation == GVLoadingViewDismissAnimationFade) {
			[UIView animateWithDuration:animationTime animations:^{
				self.alpha = 0.0;
			}];
		}
		else if (animation == GVLoadingViewDismissAnimationShutter) {
			[UIView animateWithDuration:animationTime animations:^{ 
				self.frame = CGRectMake(self.frame.origin.x, SuperviewHeight-Height, Width, 0);
				self.alpha = 0.0;
			}];
		}
		
		[self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:animationTime];
	}
}

@end
