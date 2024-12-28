----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/15/2024 01:54:48 PM
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity invShiftRows is
    Port(r: in std_logic_vector(127 downto 0):=x"63F95B6FA2AA126367636A23D7638282"; --rows;
    o: out std_logic_vector(127 downto 0));
end invShiftRows;

architecture Behavioral of invShiftRows is
signal r0: std_logic_vector(31 downto 0);
signal r1: std_logic_vector(31 downto 0);
signal r2: std_logic_vector(31 downto 0);
signal r3: std_logic_vector(31 downto 0);
signal o0: std_logic_vector(31 downto 0);
signal o1: std_logic_vector(31 downto 0);
signal o2: std_logic_vector(31 downto 0);
signal o3: std_logic_vector(31 downto 0);
begin
    r3<=r(31 downto 0);
    r2<=r(63 downto 32);
    r1<=r(95 downto 64);
    r0<=r(127 downto 96);
    o0<=r0;
    o1<=r1(7 downto 0)&r1(31 downto 8);
    o2<=r2(15 downto 0)&r2(31 downto 16);
    o3<=r3(23 downto 0)&r3(31 downto 24);
    o<=o0&o1&o2&o3;

end Behavioral;