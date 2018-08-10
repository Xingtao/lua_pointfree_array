# lua_pointfree_array
A collection of functional style functions operate on table array

## Usage
####
```
local pfa = require "pointfree_array"
local arr = pfa.Pointfree({1, 2, 3, 4, 5, 6, 7, 8})
local square_odd_num = arr:filter(function(n) return n % 2 == 1 end):map(function(n) return n*n end)
```
This will output: {1, 9, 25, 49}

####
Also, it is fine to be used standalone, as normal operation function.
For instance, append suffix to a string array.

```
local string_array = {"hello", "world"}
pfa.map(function(s) s .. " i am the suffix" end, string_array) 
```


## Note
After operate on a normal array, it would apend a meta table to the array, you could remove it by *un_pointfree*,
namely
```
pfa.map(function(s) s .. " i am the suffix" end, string_array):un_pointfree
```
