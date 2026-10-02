-- ============================================================================
-- tb_sevenSegment.vhd — self-checking testbench
--
-- Drives all 16 BCD input combinations into the decoder and compares the
-- segment output against the expected patterns (0-9 correct, 10-15 blank).
-- Prints "ALL TESTS PASSED" on success; any mismatch is reported as an
-- assertion failure.
--
-- Run with ModelSim / QuestaSim:
--   vcom sevenSegment.vhd tb_sevenSegment.vhd
--   vsim tb_sevenSegment -c -do "run -all; quit"
--
-- Or with GHDL:
--   ghdl -a sevenSegment.vhd tb_sevenSegment.vhd
--   ghdl -e tb_sevenSegment
--   ghdl -r tb_sevenSegment
-- ============================================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_sevenSegment is
end entity tb_sevenSegment;

architecture sim of tb_sevenSegment is

    -- BCD stimulus, mapped to the DUT's individual port signals
    signal bcd : std_logic_vector(3 downto 0) := "0000";

    -- segment output under test
    signal seg : std_logic_vector(6 downto 0);

    -- expected patterns indexed by the BCD value (0..15)
    type pattern_array_t is array (0 to 15) of std_logic_vector(6 downto 0);
    constant expected : pattern_array_t := (
        "1111110",   -- 0 : a b c d e f
        "0110000",   -- 1 : b c
        "1101101",   -- 2 : a b d e g
        "1111001",   -- 3 : a b c d g
        "0110011",   -- 4 : b c f g
        "1011011",   -- 5 : a c d f g
        "1011111",   -- 6 : a c d e f g
        "1110000",   -- 7 : a b c
        "1111111",   -- 8 : all on
        "1111011",   -- 9 : a b c d f g
        others => "0000000"   -- 10..15 : blank (invalid BCD)
    );

    -- convert a std_logic_vector to a readable string (MSB first)
    function to_str(v : std_logic_vector) return string is
        variable s : string(1 to v'length);
        variable j : positive := 1;
    begin
        for i in v'range loop
            case v(i) is
                when '1'    => s(j) := '1';
                when '0'    => s(j) := '0';
                when others => s(j) := 'X';
            end case;
            j := j + 1;
        end loop;
        return s;
    end function;

begin

    -- DUT: connect the packed stimulus vector to the single-bit ports
    dut : entity work.sevenSegment
        port map (
            A   => bcd(3),
            B   => bcd(2),
            C   => bcd(1),
            D   => bcd(0),
            seg => seg
        );

    stimulus : process
        variable errors : natural := 0;
    begin
        for i in 0 to 15 loop
            -- drive the BCD value
            bcd <= std_logic_vector(to_unsigned(i, 4));
            wait for 10 ns;

            -- compare against the expected pattern
            if seg /= expected(i) then
                errors := errors + 1;
                report "FAIL: BCD=" & integer'image(i)
                    & " expected seg=" & to_str(expected(i))
                    & " got seg=" & to_str(seg)
                    severity error;
            end if;
        end loop;

        if errors = 0 then
            report "ALL TESTS PASSED (16/16)" severity note;
        else
            report "TESTS FAILED: " & integer'image(errors) & " error(s)"
                severity failure;
        end if;

        wait;
    end process stimulus;

end architecture sim;
