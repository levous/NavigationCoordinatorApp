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
    
    //[self updateLayoutWithOrientation:TTInterfaceOrientation()];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidUnload {
    [super viewDidUnload];
    
    TT_RELEASE_SAFELY(_dividerView);
}







@end

