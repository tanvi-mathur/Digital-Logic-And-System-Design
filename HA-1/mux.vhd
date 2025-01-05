library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux is
Port (d1, d2, s : in STD_LOGIC;
w : out STD_LOGIC);

end mux;


architecture Behavioral of mux is
component AND_gate
Port ( a : in STD_LOGIC;
b : in STD_LOGIC;
c : out STD_LOGIC);
end component;

component OR_gate
Port ( a : in STD_LOGIC;
b : in STD_LOGIC;
c : out STD_LOGIC);
end component;


component NOT_gate
Port ( a : in STD_LOGIC;
c : out STD_LOGIC);
end component;


signal x, y, z : std_logic;
begin
DUT1 : AND_gate port map (a=>d2, b=>s, c=>x);
DUT2 : NOT_gate port map(a=>s, c=>z);
DUT3 : AND_gate port map(a=>d1, b=>z, c=>y);
DUT4: OR_gate port map(a=>x, b=>y, c=>w);

end Behavioral;