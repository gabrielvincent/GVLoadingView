GVLoadingView
=============

ARC Compatibility
-----------------

GVLoadingView is compatible with ARC

Thread Safety
-------------

GVLoadingView does not use threading. You may need to manage threading yourself in order to avoid UI blocking.

Installation
------------

To install GVLoadingView, simply drag the <code>GVLoadingView.h</code> and <code>GVLoadingView.m</code> to your project. When asked, check the following fileds:
- Copy items into destination group's folder (if needed)
- Create groups for any added folders
- Add to targets (check all the desired targets)

Configuration
-------------

Configuration of GVLoadingView is very simple. Go te .h file where you want GVLoadingView to appear and import it:
<pre>#import "GVLoadingView.h"</pre>
In your <code>@interface</code>, instantiate an object of GVLoadingView class:

<pre>
@interface MyViewController : UIViewController {
	GVLoadingView *loadingView;
}
</pre>

Initialize the object:

<pre>loadingView = [[GVLoadingView alloc] init];</pre>

To modify the behavior and the appearance of GVLoadingView, you can use the following properties:

<pre>Setting the loadingView background color:</pre>
<code>loadingView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];</code>
If you want the loadingView to have transparency, set it in it's background color, so it will be kept even if you want to use the showing animation <code>GVLoadingViewShowAnimationFade</code>

<pre>@property (nonatomic, strong) UILabel *messageLabel;</pre>
This is the <code>UILabel</code> that will show any message you wish. To set it's properties:<br>

<code>loadingView.messageLabel.text = @"Loading...";</code><br>
<code>loadingView.messageLabel.textColor = [UIColor whiteColor];</code><br>
<code>loadingView.messageLabel.font = [UIFont boldSystemFontOfSize:14];</code><br>
<code>loadingView.messageLabel.shadowOffset = CGSizeMake(0, -1);</code><br>
<code>loadingView.messageLabel.shadowColor = [UIColor blackColor];</code><br>

If no text is set, no message will show.

<pre>@property (nonatomic, strong) UIActivityIndicatorView *spinner;</pre>
This is the <code>UIActivityIndicatorView</code> that will appear to the left of the <code>messageLabel</code>. It can be customized as well:<br>

<code>loadingView.spinner.activityIndicatorViewStyle = UIActivityInidcatorViewStyleWhite;</code><br>
<code>loadingView.spinner.color = [UIColor darkGrayColor];</code><br>

<pre>@property (nonatomic) CGFloat *animationTime;</pre>
A <code>float</code> value that defines the time that will take for the animations to complete. It ranges from 0.0 to 1.0.

<pre>@property (nonatomic, strong) UIImage *reloadImage;</pre>
This is the <code>UIImage</code> that will appear in place of the <code>UIActivityIndicatorView</code> when GVLoadingView enters reload mode. This image must be 20x23 pixels size on non-retine devices and 40x46 on retina devices.

<pre>@property (nonatomic) SEL *reloadMethod;</pre>
When GVLoadingView is in reload mode, it's whole area will be clickable. A tap on it's surface will trigger a method in the container view controller. To define this method, set the reloadMethod property:<br>

<code>loadingView.reloadMethod = @selector(anyMethodYouWant);</code><br>
When the user tap GVLoadingView in reload mode, it will call the <code>anyMethodYouWant</code> method.

<pre>@property (nonatomic, unsafe_unretained) UIViewController <GVLoadingViewDelegate> *delegate;</pre>
This is the GVLoadingView's delegate. It must be set to the class that owns the method that must be called when the user taps GVLoadingView in reload mode.
<code>loadingView.delegate = (id)self;</code>

Methods
-------

<pre>- (void) showWithAnimation:(GVLoadingViewShowAnimation)animation;</pre>
This method will automatically add the <code>loadingView</code> to the <code>superview</code> and perform the chosen animation. The available animations for showing the <code>loadingView</code> are:

<code>GVLoadingViewShowAnimationAppear</code><br>
The loadingView will come from the bottom of the screen, sliding in to the frame set.

<code>GVLoadingViewShowAnimationFade</code><br>
The loadingView will fade from completely transparent to completely opaque. If you want the loadingView background to remain a little transparent, you must set it's backgroundColor as: <code>loadingView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];</code><br>

<code>GVLoadingViewShowAnimationShutter</code><br>
The loadingView will fade in from completely transparent with height 0px and resize it's height until it reaches the height set in the frame.

<code>GVLoadingViewShowAnimationDrop</code><br>
The loadingView will fade in from completely transparent and above the set vertical origin. It will slide down until it reaches the vertical origin set in the frame and will bounce twice.

<code>GVLoadingViewShowAnimationNone</code><br>
The loadingView will show up in the view with no animation

<pre>- (void) dismissWithAnimation:(GVLoadingViewDismissAnimation)animation;</pre>
This method will remove the loadingView from the view performing the chosen animation. The available animations for dismissing the <code>loadingView</code> are:

<code>GVLoadingViewDismissAnimationDisappear</code><br>
The loadingView will slide to the bottom of the view until it's completely out of the view's frame, then it will be removed from the view.

<code>GVLoadingViewDismissAnimationFade</code>
The loadingView will fade out to completely transparent, then it will be removed from the view.

<code>GVLoadingViewDismissAnimationShutter</code>
The loadingView will reduce it's height until 0px while fading out to completely transparent and then it will be removed from the view.

<code>GVLoadingViewDismissAnimationNone</code>
The loadingView will be removed immediately from the view, with no animaitons.

<pre>- (void) enterReloadModeWithMessage:(NSString *) reloadMessage;</pre>
When this method is called, the <code>UIActivityIndicatorView</code> will stop animating and disappear. In it's place will appear some reload image set by the property <code>reloadImage</code>. The whole area of the view will be clickable. When loadingView is clicked, it will call the method set by the property <code>reloadMethod</code>. The string passed as argument will replace the current message in the loadingView. For example:

<code>[loadingView enterReloadMethodWithMessage:@"Load failed. Tap to reload."];</code>

<pre>- (void) exitReloadModeWithMessage:(NSString *) reloadMessage;</pre>
When this method is called, the <code>reloadImage</code> will disappear and in it's place the <code>UIActivityIndicatorView</code> will reappear, animating. The string passed as argument will replace the current message in the loadingView. For example:

<code>[loadingView exitReloadMethodWithMessage:@"Reloading..."];</code>