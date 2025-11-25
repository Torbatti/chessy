// /*
//  * Copyright (c) 2025 Arya Bakhtiari
//  * All rights reserved.
//  *
//  * Redistribution and use in source and binary forms, with or without
//  * modification, are permitted provided that the following conditions
//  * are met:
//  * 1. Redistributions of source code must retain the above copyright
//  *    notice, this list of conditions and the following disclaimer.
//  * 2. Redistributions in binary form must reproduce the above copyright
//  *    notice, this list of conditions and the following disclaimer in the
//  *    documentation and/or other materials provided with the distribution.
//  * 3. Neither the name of the University nor the names of its contributors
//  *    may be used to endorse or promote products derived from this software
//  *    without specific prior written permission.
//  *
//  * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
//  * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//  * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//  * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
//  * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
//  * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
//  * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
//  * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
//  * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
//  * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
//  * SUCH DAMAGE.
// */

//! By convention, root.zig is the root source file when making a library.
const std = @import("std");

pub const ChessGame = struct {
    moves: *[1024]u16,
    board: ChessBoard,
};

pub const BoardOptions = struct {};
// TODO: make this a type
// TODO: make a board without move checks
// TODO: find the best way to calculate if king is attacked or not
// -  save-cache it for use for next move maybe
pub const ChessBoard = struct {

    // 1111 1111
    // 1111 1111
    // ---- ----
    // 01234567
    // 89abcdef

    // moves: [1024]u16,
    // board: [32]Piece,

    // NOTE(AABIB): 0->0 A->0
    // row: abcdefgh
    // column: 12345678
    pawn_bits: u64 = 0x00_FF_00_00_00_00_FF_00,
    rook_bits: u64 = 0x81_00_00_00_00_00_00_81,
    horse_bits: u64 = 0x42_00_00_00_00_00_00_42,
    elephant_bits: u64 = 0x24_00_00_00_00_00_00_24,
    queen_bits: u64 = 0x10_00_00_00_00_00_00_10,
    king_bits: u64 = 0x01_00_00_00_00_00_00_01,

    // NOTE(AABIB): use xor for toggling bits
    white_bits: u64 = 0xFF_FF_00_00_00_00_00_00,
    black_bits: u64 = 0x00_00_00_00_00_00_FF_FF,

    //
    // NOTE(AABIB):
    //  1) why did i even put these here? alive/dead pieces and their type
    //  2) 16 first bits are normal pieces - 16 latter pieces are for promoted pawns
    //      4 piece kind = 2 bits
    //
    live_white_bits: u32 = 0x00_00_00_00,
    live_black_bits: u32 = 0x00_00_00_00,
    dead_white_bits: u32 = 0x00_00_00_00,
    dead_black_bits: u32 = 0x00_00_00_00,

    //
    // NOTE(AABIB):
    // max number of pieces attacking a single square is 15
    // 1 king - 2 soldier - 1 bishop - 8 knights - 2 rooks - 1 queen
    //
    white_capture_squares: [64]u4 = undefined,
    black_capture_squares: [64]u4 = undefined,

    fn start_state() !void {
        //
    }

    fn move() !u8 {
        // const piece_color = try get_piece_color(); // white/black as value - voide as error
        // const piece_side_color = try check_piece_side_same_color(); // TOOD: better naming
        //
        // const piece_kind =  try get_piece_kind(); // kind as value - unkind as error
        // const legal_move_kind_check = try check_kind_legal_move(); // TODO: better naming
        // const legal_move_king_check = try check_king_legal_move(); // legal move is not legal - its a pinned piece
        //
    }
};
