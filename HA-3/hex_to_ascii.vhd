----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/24/2024 11:41:44 PM
-- Design Name: 
-- Module Name: hex_to_ascii - Behavioral
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

entity hex_to_ascii is
port (c: in std_logic_vector(127 downto 0);
ascii: out string(1 to 16));
end hex_to_ascii;

architecture Behavioral of hex_to_ascii is
signal o: string(1 to 16);
signal temp: std_logic_vector(31 downto 0);
begin
process(c) 
variable bin: std_logic_vector(7 downto 0);
begin
    for i in 15 downto 0 loop
        bin:=c(127-8*i downto 120-8*i);
        if bin(7 downto 4)=x"3" then
            if bin(3 downto 0) = "0000" then
                o(i+1) <= '0';
            elsif bin(3 downto 0) = "0001" then
                o(i+1) <= '1';
            elsif bin(3 downto 0) = "0010" then
                o(i+1) <= '2';
            elsif bin(3 downto 0) = "0011" then
                o(i+1) <= '3';
            elsif bin(3 downto 0) = "0100" then
                o(i+1) <= '4';
            elsif bin(3 downto 0) = "0101" then
                o(i+1) <= '5';
                
            elsif bin(3 downto 0) = "0110" then
                o(i+1) <= '6';
            
            elsif bin(3 downto 0) = "0111" then
                o(i+1) <= '7';
                
            elsif bin(3 downto 0) = "1000" then
                o(i+1) <= '8';
               
            elsif bin(3 downto 0) = "1001" then
                o(i+1) <= '9';
                
            end if;
       elsif bin(7 downto 4)=x"4" or bin(7 downto 4) = x"6" then
            if bin(3 downto 0) = x"1" then
                o(i+1) <= 'A';
                
            elsif bin(3 downto 0) = x"2" then
                o(i+1) <= 'B';
                
            elsif bin(3 downto 0) = x"3" then
                o(i+1) <= 'C';
                
            elsif bin(3 downto 0) = x"4" then
                o(i+1) <= 'D';
               
            elsif bin(3 downto 0) = x"5" then
                o(i+1) <= 'E';
                
            elsif bin(3 downto 0) = x"6" then
                o(i+1) <= 'F';
                
            end if; 
       elsif bin=x"20" then
            o(i+1)<=' ' ; 
       else
            o(i+1)<='-'; 
       end if;
    end loop;
end process;
ascii<=o;
end Behavioral;
