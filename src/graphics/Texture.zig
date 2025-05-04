const Allocator = @import("std").mem.Allocator;
const gl = @import("zgl");
const img = @import("zigimg");

const Self = @This();

texture: gl.Texture,

pub fn init(image: img.Image) Self {
    const texture = gl.genTexture();

    texture.bind(.@"2d");
    // This should not be that costly even if not necessary as it's called
    // once per texture creation, but might be good to look into it.
    defer gl.bindTexture(.invalid, .@"2d");

    texture.parameter(.wrap_s, .repeat);
    texture.parameter(.wrap_t, .repeat);
    texture.parameter(.mag_filter, .nearest);
    texture.parameter(.min_filter, .linear);

    gl.textureImage2D(.@"2d", 0, .rgba, image.width, image.height, .rgba, .unsigned_byte, image.pixels.asBytes().ptr);
    texture.generateMipmap();

    return Self{
        .texture = texture,
    };
}

pub fn initFromPath(path: []const u8, allocator: Allocator) !Self {
    var image = try img.Image.fromFilePath(allocator, path);
    defer image.deinit();

    return init(image);
}

pub fn initFromMemory(buffer: []const u8, allocator: Allocator) !Self {
    var image = try img.Image.fromMemory(allocator, buffer);
    defer image.deinit();

    return init(image);
}

pub fn bind(self: Self) void {
    // We only support one texture, so no need to actived the texture!
    // gl.activeTexture(.texture_0);
    self.texture.bind(.@"2d");
}

pub fn unbind(_: Self) void {
    // Is it necessary to unbind the texture if another one will be binded?
    // Maybe instead of unbind function, the engine should just call
    // gl.bindTexture(.invalid, .@"2d");
    gl.bindTexture(.invalid, .@"2d");
}

pub fn deinit(self: Self) void {
    self.texture.delete();
}
