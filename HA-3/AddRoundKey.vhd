----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/15/2024 02:10:15 PM
-- Design Name: 
-- Module Name: AddRoundKey - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity AddRoundKey is
port(c: in std_logic_vector(127 downto 0):=x"544936656873424B3141796573317479";
round_key: in std_logic_vector(127 downto 0);
o: out std_logic_vector(127 downto 0));
end AddRoundKey;

architecture Behavioral of AddRoundKey is

signal bin_o: std_logic_vector(127 downto 0);
begin
--process(c, bin_c)
--begin
--for i in 0 to 31 loop
--    if c(i+1)='0' then
--        bin_c((127-4*i) downto (124-4*i))<="0000";
--    elsif c(i+1)='1' then
--        bin_c((127-4*i) downto (124-4*i))<="0001";
--    elsif c(i+1)='2' then
--        bin_c((127-4*i) downto (124-4*i))<="0010";
--    elsif c(i+1)='3' then
--        bin_c((127-4*i) downto (124-4*i))<="0011";
--    elsif c(i+1)='4' then
--        bin_c((127-4*i) downto (124-4*i))<="0100";
--    elsif c(i+1)='5' then
--        bin_c((127-4*i) downto (124-4*i))<="0101";
--    elsif c(i+1)='6' then
--        bin_c((127-4*i) downto (124-4*i))<="0110";
--    elsif c(i+1)='7' then
--        bin_c((127-4*i) downto (124-4*i))<="0111";
--    elsif c(i+1)='8' then
--        bin_c((127-4*i) downto (124-4*i))<="1000";
--    elsif c(i+1)='9' then
--        bin_c((127-4*i) downto (124-4*i))<="1001";
--    elsif c(i+1)='A' then
--        bin_c((127-4*i) downto (124-4*i))<="1010";
--    elsif c(i+1)='B' then
--        bin_c((127-4*i) downto (124-4*i))<="1011";
--    elsif c(i+1)='C' then
--        bin_c((127-4*i) downto (124-4*i))<="1100";
--    elsif c(i+1)='D' then
--        bin_c((127-4*i) downto (124-4*i))<="1101";
--    elsif c(i+1)='E' then
--        bin_c((127-4*i) downto (124-4*i))<="1110";
--    elsif c(i+1)='F' then
--        bin_c((127-4*i) downto (124-4*i))<="1111";
--    end if;
--    end loop;
--end process;  
process(bin_o, round_key, c)
begin
    bin_o<=c xor round_key;
end process; 
o<=bin_o;
--process(bin_o)
--begin
--for i in 0 to 31 loop
--    if bin_o((127-4*i) downto (124-4*i)) = "0000" then
--        o(1+i) <= '0';
--    elsif bin_o((127-4*i) downto (124-4*i)) = "0001" then
--        o(1+i) <= '1';
--    elsif bin_o((127-4*i) downto (124-4*i)) = "0010" then
--        o(1+i) <= '2';
--    elsif bin_o((127-4*i) downto (124-4*i))= "0011" then
--        o(1+i) <= '3';
--    elsif bin_o((127-4*i) downto (124-4*i)) = "0100" then
--        o(1+i) <= '4';
--    elsif bin_o((127-4*i) downto (124-4*i)) = "0101" then
--        o(1+i) <= '5';
--    elsif bin_o((127-4*i) downto (124-4*i)) = "0110" then
--        o(1+i) <= '6';
--    elsif bin_o((127-4*i) downto (124-4*i))= "0111" then
--        o(1+i) <= '7';
--    elsif bin_o((127-4*i) downto (124-4*i)) = "1000" then
--        o(1+i) <= '8';
--    elsif bin_o((127-4*i) downto (124-4*i)) = "1001" then
--        o(1+i) <= '9';
--    elsif bin_o((127-4*i) downto (124-4*i))= "1010" then
--        o(1+i) <= 'A';
--    elsif bin_o((127-4*i) downto (124-4*i)) = "1011" then
--        o(1+i) <= 'B';
--    elsif bin_o((127-4*i) downto (124-4*i)) = "1100" then
--        o(1+i) <= 'C';
--    elsif bin_o((127-4*i) downto (124-4*i)) = "1101" then
--        o(1+i) <= 'D';
--    elsif bin_o((127-4*i) downto (124-4*i)) = "1110" then
--        o(1+i) <= 'E';
--    elsif bin_o((127-4*i) downto (124-4*i)) = "1111" then
--        o(1+i) <= 'F';
--    end if;
--    end loop;
--end process; 

end Behavioral;