/**
 * KCReverseZoomer
 *
 * Created by KangaCoders Ltd.
 * Copyright (c) 2016 KangaCoders Ltd.. All rights reserved.
 */

#import "ComKangacodersKcreversezoomerModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation ComKangacodersKcreversezoomerModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"15728109-3aff-4b64-a48f-b16cbd853462";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"com.kangacoders.kcreversezoomer";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];

	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably

	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

-(void)unbind_views
{
    if (controlling_scroll) {
        [controlling_scroll forgetSelf];
        RELEASE_TO_NIL(controlling_scroll);
    }
    RELEASE_TO_NIL(zoomable_views);
}

-(UIView*)to_view:(id)view
{
    UIView* View = nil;
    if ([view respondsToSelector:@selector(view)]) {
        View = [view view];
    }
    return View;
}

-(UIScrollView*)to_scroll_view:(id)view
{
    UIScrollView* scrollView = nil;
    if ([view respondsToSelector:@selector(scrollView)]) {
        scrollView = [view scrollView];
    }
    return scrollView;
}


#pragma Public APIs

-(void)bind_zoomers:(id)args
{
    ENSURE_UI_THREAD_1_ARG(args);
    ENSURE_SINGLE_ARG_OR_NIL(args, NSDictionary);
    
    NSArray *_zoomable_views = [args valueForKey:(@"zoomable_views")];
    TiViewProxy *_controlling_scroll = [args valueForKey:(@"scroll_view")];
    
    ENSURE_ARRAY(_zoomable_views);
    
    [self unbind_views];
    zoomable_views = [[NSMutableArray alloc] initWithCapacity:[_zoomable_views count]];
    
    for (TiViewProxy* proxy in _zoomable_views) {
        [zoomable_views addObject:proxy];
    }
    
    [_controlling_scroll rememberSelf];
    id view = _controlling_scroll.view;
    UIScrollView* scroll = [self to_scroll_view:view];
    scroll.delegate = self;
    controlling_scroll = _controlling_scroll;
    
    NSLog(@"[INFO] %@ binded",self);
}

#pragma UIScrollView Delegate

- (void)scrollViewDidZoom:(UIScrollView *)scroll_view
{
    
    float _zoomscale = scroll_view.zoomScale;
    float _new_scale = 1 / _zoomscale;
//    NSLog(@"[INFO] %@ loaded",self);
    for(TiViewProxy* proxy in zoomable_views){
//        NSLog(@"Zoomable View");
        UIView* v = proxy.view;
        v.transform = CGAffineTransformScale(CGAffineTransformIdentity, _new_scale, _new_scale);
    }
    NSDictionary *event = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:_zoomscale],@"zoom_scale",nil];
    [self fireEvent:@"scrolling" withObject:event];
//    NSLog([[NSNumber numberWithFloat:_zoomscale] stringValue]);
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return scrollView.subviews[0];
}

//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    NSLog(@"Did end decelerating");
//}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    //    NSLog(@"Did scroll");
//}
//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView
//                 willDecelerate:(BOOL)decelerate{
//    NSLog(@"Did end dragging");
//}
//-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
//    NSLog(@"Did begin decelerating");
//}
//-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    NSLog(@"Did begin dragging");
//}

@end
