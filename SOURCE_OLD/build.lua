#!/usr/bin/env lua

--------------
-- Settings --
--------------

-- Set this to true to use a better compression algorithm for the DAC driver.
-- Having this set to false will use an inferior compression algorithm that
-- results in an accurate ROM being produced.
local improved_dac_driver_compression = false

---------------------
-- End of settings --
---------------------

local common = require "build_tools.lua.common"

-- Assemble the ROM.
local compression = improved_dac_driver_compression and "kosinski-optimised" or "kosinski"
local message, abort = common.build_rom("sonic", "s1unlimitedbuilt", "", "-p=FF -z=0," .. compression .. ",Size_of_DAC_driver_guess,after", false, "https://github.com/sonicretro/s1disasm")

if message then
    exit_code = false
end

if abort then
    os.exit(exit_code, true)
end

local compression = improved_dac_driver_compression and "kosinski-optimised" or "kosinski"
-- Buld DEBUG ROM
message, abort = common.build_rom("sonic", "s1unlimitedbuilt.debug", "-D __DEBUG__ -OLIST sonic.debug.lst", "-p=FF -z=0," .. compression .. ",Size_of_DAC_driver_guess,after", false, "https://github.com/sonicretro/s1disasm")

if message then
    exit_code = false
end

if abort then
    os.exit(exit_code, true)
end

-- Append symbol table to the ROM.
local extra_tools = common.find_tools("debug symbol generator", "https://github.com/vladikcomper/md-modules", "https://github.com/sonicretro/s1disasm", "convsym")
if not extra_tools then
    os.exit(false)
end
os.execute(extra_tools.convsym .. " sonic.debug.lst s1unlimitedbuilt.debug.bin -input as_lst -range 0 FFFFFF -exclude -filter \"z[A-Z].+\" -a")

-- Correct the ROM's header with a proper checksum and end-of-ROM value.
common.fix_header("s1unlimitedbuilt.bin")
common.fix_header("s1unlimitedbuilt.debug.bin")

os.exit(exit_code, false)
