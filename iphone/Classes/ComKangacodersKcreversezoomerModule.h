/**
 * KCReverseZoomer
 *
 * Created by KangaCoders Ltd.
 * Copyright (c) 2016 KangaCoders Ltd.. All rights reserved.
 */

#import "TiModule.h"
#import "TiUIScrollViewProxy.h"
#import "TiUIScrollView.h"
#import "TiUIViewProxy.h"
#import "TiUIView.h"

@interface ComKangacodersKcreversezoomerModule : TiModule <UIScrollViewDelegate>
{
    NSMutableArray* zoomable_views;
    TiViewProxy* controlling_scroll;
}

@end
