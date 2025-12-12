const std = @import("std");

const xlib = @cImport({
    @cInclude("X11/Xlib.h");
    @cInclude("X11/Xutil.h");
});

const xgl = @cImport({
    @cInclude("GL/gl.h");
    @cInclude("GL/glx.h");
});

pub fn start() !void {
    const window_x: c_int = 0;
    const window_y: c_int = 0;
    const window_width: c_int = 800;
    const window_height: c_int = 600;
    const window_border_width: c_int = 8;
    const window_depth: c_int = xlib.CopyFromParent;
    const window_class: c_int = xlib.CopyFromParent;
    // const window_visual: [*c]xlib.Visual = @ptrFromInt(xlib.CopyFromParent);
    const window_visual: [*c]xlib.Visual = xlib.CopyFromParent; // works the same as above??
    const window_attribute_mask: c_int = xlib.CWBackPixel;
    var window_attributes: xlib.XSetWindowAttributes = .{};
    window_attributes.background_pixel = 0xffafe9af;

    //

    const main_display: ?*xlib.Display = xlib.XOpenDisplay(0);
    if (main_display) |_| {
        // works as intended
    } else {
        @panic("main display shouldnt be null!");
    }

    const root_window: xlib.Window = xlib.XDefaultRootWindow(main_display);

    // const visual:ogl.XVisualInfo = ogl.glXChooseVisual(dpy: ?*struct__XDisplay, screen: c_int, attribList: [*c]c_int)

    //  const main_window: xlib.Window = xlib.XCreateSimpleWindow(
    //      main_display,
    //      root_window,
    //      0,
    //      0,
    //      window_width,
    //      window_height,
    //      0,
    //      0,
    //      0x00aade87,
    //  );
    const main_window: xlib.Window = xlib.XCreateWindow(
        main_display,
        root_window,
        window_x,
        window_y,
        window_width,
        window_height,
        window_border_width,
        window_depth,
        window_class,
        window_visual,
        window_attribute_mask,
        &window_attributes,
    );
    _ = xlib.XMapWindow(main_display, main_window);
    _ = xlib.XFlush(main_display);

    while (true) {
        std.Thread.sleep(1_000_000_000);
    }
}
