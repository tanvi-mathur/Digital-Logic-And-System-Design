library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL; 
-- for sample.coe
entity bram is
    Port ( clk      : in  std_logic;
           rst      : in  std_logic;
           en     : in  std_logic;  -- enable signal that basically enables memory for read/write
           we       : in  std_logic_vector(0 downto 0);   
           addr     : in  std_logic_vector(3 downto 0); -- Address for accessing BRAM
           din      : in  std_logic_vector(7 downto 0); -- Data to write into BRAM
           dout     : out std_logic_vector(7 downto 0)  -- Data read from BRAM
           
         );
end bram;
architecture Behavioral of bram is
    --signal rst      : std_logic;
     
    component blk_mem_gen_0
        Port (
            clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) 
        );
        end component;
    begin
    bram_inst : blk_mem_gen_0
        port map (
            clka  => clk,               
            ena   => en,
            wea=>we,             
            addra => addr, 
            dina=>din,                    
            douta => dout               
        );
end Behavioral;