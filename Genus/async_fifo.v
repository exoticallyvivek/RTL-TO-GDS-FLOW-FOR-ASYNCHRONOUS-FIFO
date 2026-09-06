`timescale 1ns / 1ps
module async_fifo #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 3
)(
    input  wire                  wclk,
    input  wire                  wrst_n,
    input  wire                  w_en,
    input  wire [DATA_WIDTH-1:0] wdata,

    input  wire                  rclk,
    input  wire                  rrst_n,
    input  wire                  r_en,
    output reg  [DATA_WIDTH-1:0] rdata,

    output reg                   full,
    output reg                   empty
);

    // --------------------------------------------------
    // Memory
    // --------------------------------------------------
    reg [DATA_WIDTH-1:0] mem [0:(1<<ADDR_WIDTH)-1];

    // --------------------------------------------------
    // Binary & Gray pointers
    // --------------------------------------------------
    reg [ADDR_WIDTH:0] wbin, rbin;
    reg [ADDR_WIDTH:0] wgray, rgray;

    // --------------------------------------------------
    // CDC synchronized pointers
    // --------------------------------------------------
    (* ASYNC_REG = "TRUE" *) reg [ADDR_WIDTH:0] wgray_rclk_ff1, wgray_rclk_ff2;
    (* ASYNC_REG = "TRUE" *) reg [ADDR_WIDTH:0] rgray_wclk_ff1, rgray_wclk_ff2;

    wire [ADDR_WIDTH:0] wgray_sync = wgray_rclk_ff2;
    wire [ADDR_WIDTH:0] rgray_sync = rgray_wclk_ff2;

    // --------------------------------------------------
    // Write logic
    // --------------------------------------------------
    wire winc = w_en && !full;
    wire [ADDR_WIDTH:0] wbin_next  = wbin + winc;
    wire [ADDR_WIDTH:0] wgray_next = (wbin_next >> 1) ^ wbin_next;

    wire full_next = (wgray_next == {
                        ~rgray_sync[ADDR_WIDTH:ADDR_WIDTH-1],
                         rgray_sync[ADDR_WIDTH-2:0]
                      });

    always @(posedge wclk or negedge wrst_n) begin
        if (!wrst_n) begin
            wbin  <= 0;
            wgray <= 0;
            full  <= 1'b0;
        end else begin
            wbin  <= wbin_next;
            wgray <= wgray_next;
            full  <= full_next;
            if (winc)
                mem[wbin[ADDR_WIDTH-1:0]] <= wdata;
        end
    end

    // --------------------------------------------------
    // Read logic
    // --------------------------------------------------
    wire rinc = r_en && !empty;
    wire [ADDR_WIDTH:0] rbin_next  = rbin + rinc;
    wire [ADDR_WIDTH:0] rgray_next = (rbin_next >> 1) ^ rbin_next;

    wire empty_next = (rgray_next == wgray_sync);

    always @(posedge rclk or negedge rrst_n) begin
        if (!rrst_n) begin
            rbin  <= 0;
            rgray <= 0;
            empty <= 1'b1;
            rdata <= 0;
        end else begin
            rbin  <= rbin_next;
            rgray <= rgray_next;
            empty <= empty_next;
            if (rinc)
                rdata <= mem[rbin[ADDR_WIDTH-1:0]];
        end
    end

    // --------------------------------------------------
    // Pointer synchronization
    // --------------------------------------------------
    always @(posedge rclk or negedge rrst_n) begin
        if (!rrst_n) begin
            wgray_rclk_ff1 <= 0;
            wgray_rclk_ff2 <= 0;
        end else begin
            wgray_rclk_ff1 <= wgray;
            wgray_rclk_ff2 <= wgray_rclk_ff1;
        end
    end

    always @(posedge wclk or negedge wrst_n) begin
        if (!wrst_n) begin
            rgray_wclk_ff1 <= 0;
            rgray_wclk_ff2 <= 0;
        end else begin
            rgray_wclk_ff1 <= rgray;
            rgray_wclk_ff2 <= rgray_wclk_ff1;
        end
    end

endmodule


