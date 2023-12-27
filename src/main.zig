const std = @import("std");

const ArrayList = std.ArrayList;

// unification

// evaluator
const Evaluator = struct {
    const Self = @This();
    fn apply(self: *Self, rule: Rule, kb: ArrayList(Atom)) {

    }

    fn evaluate(self: *Self, kb: ArrayList(Atom), rules: ArrayList(Rules)) {

    }

    fn query(self: *Self, kb: ArrayList(Atom), q: Atom, rules: ArrayList(Rules)) {
        // reduce kb
        // q.unifyWith()
    }
}

const Variable = struct {
    const Self = @This();
    name: []const []const u8,

    pub fn init(name: []const []const u8) Self {
        return .{
            .name = name,
        };
    }

    pub fn apply(self: Self, env: std.StringHashMap(Term)) ?Term {
        return try env.get(self.name) orelse self;
    }
};

const Symbol = struct {
    const Self = @This();
    name: []const []const u8,

    pub fn init(_name: []const []const u8) Self {
        return .{
            .name = _name,
        };
    }

    pub fn apply(env: std.StringHashMap(Term)) ?Term {
        _ = env;
        return Self;
    }
};

const TermType = enum {
    variable,
    symbol,
};

const Term = union(TermType) {
    variable: Variable,
    symbol: Symbol,
};

const Atom = struct {
    name: []const []const u8,
    terms: ArrayList(Term),
};

pub fn main() !void {
    // Prints to stderr (it's a shortcut based on `std.io.getStdErr()`)
    std.debug.print("All your {s} are belong to us.\n", .{"codebase"});

    // stdout is for the actual output of your application, for example if you
    // are implementing gzip, then only the compressed bytes should be sent to
    // stdout, not any debugging messages.
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    try stdout.print("Run `zig build test` to run the tests.\n", .{});

    try bw.flush(); // don't forget to flush!
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
