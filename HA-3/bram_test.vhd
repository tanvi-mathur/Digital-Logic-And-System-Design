library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL; 
-- for sample.coe
entity bram_test is
    port ( clk      : in  std_logic;
           
           en     : in  std_logic;  -- enable signal that basically enables memory for read/write
           
           addr     : in  std_logic_vector(3 downto 0); -- Address for accessing BRAM
           
           dout     : out std_logic_vector(7 downto 0)  -- Data read from BRAM
           
         );
end bram_test;
architecture Behavioral of bram_test is
    --signal rst      : std_logic;
     
    component blk_mem_gen_1
        port (
            clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    
    addra : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) 
        );
        end component;
    begin
    bram_inst : blk_mem_gen_1
        port map (
            clka  => clk,               
            ena   => en,
             
            addra => addr, 
                              
            douta => dout               
        );
end Behavioral;