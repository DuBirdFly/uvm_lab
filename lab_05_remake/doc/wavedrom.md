# WaveDrom

```wavedrom {align="center"}
{


signal: [
  {name: "clk",        wave: "p................." },
  {name: "i_frame",    wave: "0.1....|..0......." },
  {name: "i_data",     wave: "x.33444|44........", data: ["A0", "A1", "D0", "D1", "...", "D6", "D7"] },
  {name: "o_dst_addr", wave: "x..33.............", data: ["", "[A1, A0]"]},
  {name: "r_req",      wave: "0...1......0......"},
  {name: "o_req",      wave: "0...1.....0......."},
  {name: "i_gnt",      wave: "0...1.....0......."},
  {name: "nxt_state",  wave: "3.4.6.....3.......", data: ["IDLE", "ADDR", "DATA", "IDLE"]},
  {name: "cur_state",  wave: "3..4.6.....3......", data: ["IDLE", "ADDR", "DATA", "IDLE"]},
  {name: "cnt",        wave: "=..==..|...=......", data: ["0", "1", "2", "0"]},

  {},
  {},
  {name: "clk",        wave: "p................." },
  {name: "i_frame",    wave: "0.1.......|..0...." },
  {name: "i_data",     wave: "x.33...444|44.....", data: ["A0", "A1", "D0", "D1", "...", "D6", "D7"] },
  {name: "o_dst_addr", wave: "x..33.............", data: ["", "[A1, A0]"]},
  {name: "r_req",      wave: "0...1.........0..."},
  {name: "o_req",      wave: "0...1........0...."},
  {name: "i_gnt",      wave: "0......1.....0...."},
  {name: "nxt_state",  wave: "3.4.5..6.....3....", data: ["IDLE", "ADDR", "GRANT", "DATA", "IDLE"]},
  {name: "cur_state",  wave: "3..4.5..6.....3...", data: ["IDLE", "ADDR", "GRANT", "DATA", "IDLE"]},
  {name: "cnt",        wave: "=..==.....|...=...", data: ["0", "1", "2", "0"]},

],

head: {
  text: "router_iport.sv",
}

}
```
