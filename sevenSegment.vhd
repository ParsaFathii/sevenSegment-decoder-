-- ============================================================================
-- sevenSegment.vhd
--
-- BCD-to-7-segment decoder (active-high segments, common cathode).
--
-- Inputs : A, B, C, D  -- BCD digit, A = MSB
-- Output : seg(6..0)   -- segment pattern: a b c d e f g
--                          seg(6) = a (top)        seg(3) = d (bottom)
--                          seg(5) = b (top-right)  seg(2) = e (bottom-left)
--                          seg(4) = c (bottom-right) seg(1) = f (top-left)
--                          seg(0) = g (middle)
--
-- Invalid BCD inputs (10..15) blank the display (all segments off),
-- which is safer than displaying garbage symbols.
--
-- Style notes:
--   * std_logic / std_logic_vector (industry standard) instead of bit
--   * "use IEEE.std_logic_1164.all;" -- the .all is required
-- ============================================================================

library IEEE;
use IEEE.std_logic_1164.all;

entity sevenSegment is
    port (
        A, B, C, D : in  std_logic;
        seg        : out std_logic_vector(6 downto 0)
    );
end sevenSegment;

architecture rtl of sevenSegment is
    -- concatenate the inputs into one BCD vector for readability
    signal bcd : std_logic_vector(3 downto 0);
begin

    bcd <= A & B & C & D;

    with bcd select seg <=
        "1111110" when "0000",   -- 0
        "0110000" when "0001",   -- 1
        "1101101" when "0010",   -- 2
        "1111001" when "0011",   -- 3
        "0110011" when "0100",   -- 4
        "1011011" when "0101",   -- 5
        "1011111" when "0110",   -- 6
        "1110000" when "0111",   -- 7
        "1111111" when "1000",   -- 8
        "1111011" when "1001",   -- 9
        "0000000" when others;   -- invalid BCD -> blank

end rtl;
