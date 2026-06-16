library IEEE;
use IEEE.std_logic_1164;

entity sevenSegment is
    port(
        A, B, C, D : in bit;
        seg : out bit_vector(6 downto 0)
    );
end sevenSegment;

architecture manner of sevenSegment is
begin

    seg <=  "1111110" when (A&B&C&D)="0000" else
            "0110000" when (A&B&C&D)="0001" else
            "1101101" when (A&B&C&D)="0010" else
            "1111001" when (A&B&C&D)="0011" else
            "0110011" when (A&B&C&D)="0100" else
            "1011011" when (A&B&C&D)="0101" else
            "1011111" when (A&B&C&D)="0110" else
            "1110000" when (A&B&C&D)="0111" else
            "1111111" when (A&B&C&D)="1000" else
            "1111011" when (A&B&C&D)="1001" else
            "0000000";
end manner;