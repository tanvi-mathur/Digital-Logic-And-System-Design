----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/06/2024 02:57:21 PM
-- Design Name: 
-- Module Name: m2x1_tb - Behavioral
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
entity m2x1_tb is

end m2x1_tb;

architecture tb of m2x1_tb is
component mux
Port(d1,d2,s: in std_logic;
w: out std_logic);
end component;
signal d1,d2,s,w: std_logic;
begin
UUT : mux port map (d1=>d1, d2=>d2, s=>s, w=>w);

d1 <= '0', '1' after 20 ns, '0' after 40 ns, '1' after 60 ns;
d2 <= '0', '1' after 30 ns, '0' after 50 ns, '1' after 70 ns;

s <= '0', '1' after 30 ns, '0' after 40 ns, '1' after 60 ns;
end tb;