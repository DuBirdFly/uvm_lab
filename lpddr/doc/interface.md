# interface

```wavedrom {align="center"}
{
    signal: [
        {name: "pclk",     wave: "p......."},
        {name: "paddr",    wave: "=3.|...."},
        {name: "pwdata",   wave: "=4.|...."},
        {name: "pwrite",   wave: "==.|...."},
        {name: "psel",     wave: "01.|..0."},
        {name: "penable",  wave: "0.1|..0."},
        {name: "pready",   wave: "=.0|.1=."},
        {name: "prdata",   wave: "=x.|.5=."},
        {},
        {name: "pclk",     wave: "p........."},
        {name: "paddr",    wave: "=3.3.3.3.="},
        {name: "pwdata",   wave: "=4.4.4.4.="},
        {name: "pwrite",   wave: "==.=.=.=.="},
        {name: "psel",     wave: "01.......0"},
        {name: "penable",  wave: "0.10101010"},
        {name: "pready",   wave: "=1.......="},
        {name: "prdata",   wave: "xx5x5x5x5x"},
    ],

    head: {
    text: "apb interface",
    }
}
```