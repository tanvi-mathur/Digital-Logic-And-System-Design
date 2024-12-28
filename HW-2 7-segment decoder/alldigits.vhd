


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity Timing_block is
Port (clk:in std_logic;
s0, s1, s2, s3: in STD_LOGIC_vector (3 downto 0);
-- Signal for the mux
an: out STD_LOGIC_vector (4 downto 1);
a_1: out STD_LOGIC;
b_1: out STD_LOGIC;
c_1: out STD_LOGIC;
d_1: out STD_LOGIC;
e_1: out STD_LOGIC;
f_1: out STD_LOGIC;
g_1: out STD_LOGIC
);
end Timing_block;
architecture Behavioral of Timing_block is
component decoder
Port(b0, b1, b2, b3: in std_logic;

a, b, c, d, e, f, g: out std_logic);
end component;
constant N : integer := 1000;-- <need to select correct value>
signal counter: integer := 0;
signal cycle: integer := 0;


signal s: std_logic_vector (3 downto 0);
signal mux_selectb: std_logic_vector (1 downto 0);
begin
--Process 1 for dividing the clock from 100 Mhz to 1Khz - 60hz

process(clk)
begin
if rising_edge(clk) then
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
      an<="0111";
      s<=s0;
   elsif mux_selectb<="01" then
      an<="1011";
      s<=s1;

   elsif mux_selectb<="10" then
      an<="1101";
      s<=s2;

   else
      an<="1110";
      s<=s3;
   end if;

end process;
--Process 2 for mux select signal

decode: decoder port map(b0=>s(0), b1=>s(1), b2=>s(2), b3=>s(3),
 a=>a_1, b=>b_1, c=>c_1, d=>d_1, e=>e_1, f=>f_1, g=>g_1);
end Behavioral;