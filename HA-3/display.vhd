----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/25/2024 09:14:57 PM
-- Design Name: 
-- Module Name: display - Behavioral
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

entity display is

Port (clka:in std_logic;
main: in string(1 to 16);

-- Signal for the mux
an_m: out STD_LOGIC_vector (4 downto 1);
a_m: out STD_LOGIC;
b_m: out STD_LOGIC;
c_m: out STD_LOGIC;
d_m: out STD_LOGIC;
e_m: out STD_LOGIC;
f_m: out STD_LOGIC;
g_m: out STD_LOGIC);
end display;

architecture Behavioral of display is
component four_digits
Port(clk:in std_logic;
s: in string(1 to 4);
-- Signal for the mux
an: out STD_LOGIC_vector (4 downto 1);
a_1: out STD_LOGIC;
b_1: out STD_LOGIC;
c_1: out STD_LOGIC;
d_1: out STD_LOGIC;
e_1: out STD_LOGIC;
f_1: out STD_LOGIC;
g_1: out STD_LOGIC);
end component;


constant N : integer := 10000000;-- <need to select correct value>
signal counter: integer := 0;
signal cycle: integer := 0;

signal str: string(1 to 4);
signal mux_selectb: std_logic_vector (1 downto 0);

begin

process(clka)
begin
if rising_edge(clka) then
   if counter<4*N then
      counter<=counter+1;
   else
      counter<=0;
      cycle<=cycle+1;
   end if;

end if;
end process;
process(counter)
begin
    if counter <=N then
      mux_selectb<="00";

   elsif (counter <=2*N) and counter >N then
      mux_selectb<="01";


   elsif (counter <=3*N) and counter >2*N then
      mux_selectb<="10";


   else
      mux_selectb<="11";

   end if;

end process;

process(mux_selectb)
begin
   if mux_selectb<="00" then
      
      str<=main(1 to 4);
   elsif mux_selectb<="01" then
      
      str<=main(5 to 8);

   elsif mux_selectb<="10" then
      
      str<=main(9 to 12);

   else
      
      str<=main(13 to 16);
   end if;
end process;

DUT2: four_digits port map(clk=>clka, s=>str, an=>an_m, a_1=>a_m, b_1=>b_m, c_1=>c_m, d_1=>d_m, e_1=>e_m, f_1=>f_m, g_1=>g_m);
end Behavioral;
