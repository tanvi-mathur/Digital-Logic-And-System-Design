library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alldigits_tb is

end alldigits_tb;

architecture tb of alldigits_tb is

component Timing_block
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
end component;
signal clk: std_logic:='0';
signal s0, s1, s2, s3: std_logic_vector (3 downto 0);
signal an: std_logic_vector (4 downto 1);
signal a_1, b_1, c_1, d_1, e_1, f_1, g_1: std_logic;
begin
UUT: Timing_block port map(clk=>clk, s0=>s0, s1=>s1, s2=>s2, s3=>s3, an=>an, a_1=>a_1, b_1=>b_1, c_1=>c_1, d_1=>d_1, e_1=>e_1, f_1=>f_1, g_1=>g_1);
clk<=not clk after 100 ns;
s0<="1110", "0001" after 2 ms, "0011" after 6 ms, "0101" after 9 ms;
s1<="0001", "0010" after 5 ms, "0011" after 8 ms, "0100" after 15 ms;
s2<="0100", "0001" after 10 ms, "0001" after 20 ms, "0111" after 30 ms;
s3<="1001", "0110" after 5 ms, "0100" after 15 ms, "0001" after 50 ms;

end tb;
