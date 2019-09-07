// -----------------------------
// File Name: mux4.v
// Creator  : lisy
// Function : 4 to 1 mux
// Update   :
// Copyright: lisy
// -----------------------------

module mux4(
    input wire c, d, e, f,
    input wire [1:0] select,
    output reg mux_out
);

    always @(c, d, e, f, select) begin
        case (select)
            2'b00:   mux_out = c;
            2'b01:   mux_out = d;
            2'b11:   mux_out = e;
            default: mux_out = f;   // Coding style: "case" must have "default"
        endcase
    end

endmodule // mux4
