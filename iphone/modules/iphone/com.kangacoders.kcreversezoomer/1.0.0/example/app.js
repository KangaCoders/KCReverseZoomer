var win = Ti.UI.createWindow({
	backgroundColor:'white'
});

var scrollview = Ti.UI.createScrollView({
	maxZoomScale: 10,
  zoomScale: 1,
  minZoomScale: 0.25
});

var subview = Ti.UI.createView();

subview.add(Ti.UI.createView({
	width: 50,
	height: 50,
	left: 20,
	top: 50,
	backgroundColor: "red"
}));

subview.add(Ti.UI.createView({
	width: 30,
	height: 30,
	left: 100,
	top: 100,
	backgroundColor: "blue"
}));

scrollview.add(subview);

win.add(scrollview);

win.open();

var kcreversezoomer = require('com.kangacoders.kcreversezoomer');
kcreversezoomer.bind_views({
	scroll_view: scrollview,
	zoomable_views: scrollview.getChildren()
});


