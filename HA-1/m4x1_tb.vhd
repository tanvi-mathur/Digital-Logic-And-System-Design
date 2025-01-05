----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/06/2024 03:12:13 PM
-- Design Name: 
-- Module Name: m4x1 - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity m4x1_tb is

end m4x1_tb;

architecture tb of m4x1_tb is
component m4x1
Port(i0, i1, i2, i3, s0, s1: in std_logic;
p: out std_logic);
end component;
signal i0, i1, i2, i3, s0, s1, p: std_logic;
begin
UUT : m4x1 port map (i0=>i0, i1=>i1, i2=>i2, i3=>i3, s0=>s0, s1=>s1, p=>p);

i0 <= '0', '1' after 20 ns, '0' after 40 ns, '1' after 60 ns;
i1 <= '0', '1' after 20 ns, '0' after 50 ns, '1' after 60 ns;
i2 <= '0', '1' after 20 ns, '0' after 60 ns, '1' after 70 ns;
i3 <= '0', '1' after 20 ns, '0' after 70 ns, '1' after 80 ns;
s0 <= '0', '1' after 40 ns, '0' after 60 ns, '1' after 80 ns;
s1 <= '0', '1' after 60 ns, '0' after 80 ns, '1' after 100 ns;
end tb;