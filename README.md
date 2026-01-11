# UART-Loopback-Communication-on-FPGA

📌 Project Overview

This project implements a UART-based serial communication system on FPGA using Verilog HDL.
It consists of independently designed UART Transmitter and UART Receiver modules, integrated in a top-level module to form a loopback configuration for complete functional verification.

The design allows transmitted serial data to be internally routed back to the receiver, enabling testing without external UART devices.

⚙️ Features

✅ Custom UART Transmitter module

✅ Custom UART Receiver module

✅ Internal TX–RX loopback connection

✅ Switch-based parallel data input

✅ LED-based received data display

✅ Status indication for TX and RX completion

✅ Reset and send control using push buttons

🧠 Working Principle

An 8-bit data value is selected using onboard switches.

Pressing the Send button initiates UART transmission.

The UART Transmitter converts parallel data into serial format.

The serial output (TX) is internally connected to the receiver input (RX).

The UART Receiver reconstructs the serial data back to parallel form.

The received data is displayed on green LEDs.

Red LEDs indicate successful transmission and reception.

🧩 Module Description
1️⃣ Top-Level Module

DE2_UART_Loopback
Integrates the transmitter and receiver modules and manages user inputs and outputs.

2️⃣ UART Transmitter Module

UART_trans

Accepts 8-bit parallel data

Serializes data according to UART protocol

Generates TX output and transmission completion flag

3️⃣ UART Receiver Module

UART_rec

Receives serial data stream

Deserializes data into 8-bit parallel format

Generates reception completion flag

🔌 Internal Loopback Configuration

The transmitter output is directly connected to the receiver input:

wire w_tx_rx_connect;


This enables complete UART functionality testing without external hardware.

🧪 Testing & Verification

Implemented and tested on Altera DE2 FPGA board

Verified correct data transmission for multiple input values

Confirmed TX and RX completion using LED indicators

🛠️ Tools & Technologies

Verilog HDL

Quartus II

ModelSim

Altera DE2 FPGA Board

📂 File Structure
├── DE2_UART_Loopback.v   // Top module
├── UART_trans.v         // UART Transmitter
├── UART_rec.v           // UART Receiver
├── README.md

🚀 Applications

UART protocol learning

FPGA-based serial communication testing

RTL design and verification practice

Embedded system interfacing

🎥 Demo Video

A short demonstration video showing UART transmission, internal TX–RX loopback operation, switch-based data input, and LED-based reception/status indication is available here: 

✍️ Author

Manthan Sabalpara
Electronics & Communication Engineering
FPGA | Verilog | Digital Design

📜 License

This project is open-source and intended for educational use.
