# Wavedrom

```wavedrom
{


signal: [
  {name: "clk",        wave: "p................." },
  {name: "i_frame",    wave: "0.1......|..0....." },
  {name: "i_data",     wave: "x.3333x...........", data: ["A0", "A1", "A2", "A3"] },
  {name: "o_dst_addr", wave: "x.....3...........", data: ["DST_ADDR"]},
  {},
  {name: "o_req",      wave: "0.....10.........."},
  {name: "i_gnt",      wave: "0.....1.....0....."},
  {name: "i_valid",    wave: "0.....1.....0....."},
  {name: "i_data",     wave: "x.....444|44x.....", data: ["D0", "D1", "...", "D6", "D7"] },
  {},
  {name: "o_req",      wave: "0.....1...0......."},
  {name: "i_gnt",      wave: "0........1.....0.."},
  {name: "i_valid",    wave: "0........1.....0.."},
  {name: "i_data",     wave: "x........444|44x..", data: ["D0", "D1", "...", "D6", "D7"] },
],

head: {
  text: "router_iport.sv",
}





}
```