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

entity m4x1 is
Port(i0, i1, i2, i3, s0, s1: in std_logic;
p: out std_logic);
end m4x1;

architecture Behavioral of m4x1 is
component mux
Port (d1, d2, s : in STD_LOGIC;
w : out STD_LOGIC);
end component;
signal x, y: std_logic;
begin
DUT1: mux port map(d1=>i0, d2=>i1, s=>s0, w=>x);
DUT2: mux port map(d1=>i2, d2=>i3, s=>s0, w=>y);
DUT3: mux port map(d1=>x, d2=>y, s=>s1, w=>p);


end Behavioral;