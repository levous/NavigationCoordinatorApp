#import "SplitCatalogController.h"
#import "CatalogController.h"
#import <Three20/Three20+Additions.h>

static const CGFloat kBorderWidth = 1;


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@interface SplitCatalogController()


@end



///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SplitCatalogController


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        
    }
    
    return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)updateLayoutWithOrientation:(UIInterfaceOrientation)interfaceOrientation {
    [super updateLayoutWithOrientation:interfaceOrientation];
    
    _dividerView.height = self.view.height;
    _dividerView.width = kBorderWidth;
    _dividerView.right = self.primaryViewController.view.left + _dividerView.width;
    _dividerView.top = self.primaryViewController.view.top;
    
    [self.view bringSubviewToFront:_dividerView];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIViewController


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)loadView {
    [super loadView];
    
    self.view.autoresizingMask = (UIViewAutoresizingFlexibleWidth
                                  | UIViewAutoresizingFlexibleHeight);
    
    _dividerView = [[UIView alloc] init];
    _dividerView.backgroundColor = [UIColor lightGrayColor];
    
    _dividerView.autoresizingMask = (UIViewAutoresizingFlexibleHeight);
    [self.view addSubview:_dividerView];
    
    [self updateLayoutWithOrientation:TTInterfaceOrientation()];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidUnload {
    [super viewDidUnload];
    
    TT_RELEASE_SAFELY(_dividerView);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTSplitViewController


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)primaryViewDidAppear:(BOOL)animated {
    [super primaryViewDidAppear:animated];
    
    [self.view bringSubviewToFront:_dividerView];
}




@end
