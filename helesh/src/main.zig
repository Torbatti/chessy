const std = @import("std");
const helesh = @import("helesh");

const xlib = @cImport({
    @cInclude("X11/Xlib.h");
    @cInclude("X11/Xutil.h");
});

//
//const ogl = @cImport({
//    @cInclude("GL/gl.h");
//    @cInclude("GL/glx.h");
//});

pub fn main() !void {
    // Prints to stderr, ignoring potential errors.
    std.debug.print("All your {s} are belong to us.\n", .{"codebase"});
    try helesh.bufferedPrint();

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

test "simple test" {
    const gpa = std.testing.allocator;
    var list: std.ArrayList(i32) = .empty;
    defer list.deinit(gpa); // Try commenting this out and see if zig detects the memory leak!
    try list.append(gpa, 42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}

test "fuzz example" {
    const Context = struct {
        fn testOne(context: @This(), input: []const u8) anyerror!void {
            _ = context;
            // Try passing `--fuzz` to `zig build test` and see if it manages to fail this test case!
            try std.testing.expect(!std.mem.eql(u8, "canyoufindme", input));
        }
    };
    try std.testing.fuzz(Context{}, Context.testOne, .{});
}
