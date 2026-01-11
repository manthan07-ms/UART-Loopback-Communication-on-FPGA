module DE2_UART_Loopback (
    input        CLOCK_50,    // PIN_N2
    input  [1:0] KEY,         // KEY[0]=Reset, KEY[1]=Send
    input  [7:0] SW,          // Switches = Data to Send
    output [7:0] LEDG,        // Green LEDs = Data Received
    output [1:0] LEDR         // Red LEDs = Status
);

    // 1. Internal Wires (The "Virtual Cables")
    wire w_tx_rx_connect; // The wire connecting TX output to RX input
    wire w_tx_done;
    wire w_rx_done;
    
    // Invert Keys for Active Low Logic
    wire w_rst_active;
    wire w_send_active;
    
    assign w_rst_active  = KEY[0]; // Connect to rst
    assign w_send_active = KEY[1]; // Connect to tx_start

    // 2. Instantiate Transmitter
    UART_trans Transmitter (
        .clk      (CLOCK_50),
        .rst      (w_rst_active),
        .tx_start (w_send_active),
        .data_in  (SW[7:0]),       
        .tx       (w_tx_rx_connect), // Output -> Virtual Wire
        .done     (w_tx_done)
    );

    // 3. Instantiate Receiver
    UART_rec Receiver (
        .clk      (CLOCK_50),
        .rst      (w_rst_active),
        .rx       (w_tx_rx_connect), // Virtual Wire -> Input
        .data_out (LEDG[7:0]),       
        .done     (w_rx_done)
    );

    // 4. Status LEDs
    assign LEDR[0] = w_tx_done;      // Light up when TX finishes
    assign LEDR[1] = w_rx_done;      // Light up when RX finishes

endmodule