library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL; 
-- for sample.coe
entity bram_tb is
    Port ( 
           inv: out std_logic_vector(127 downto 0);
           shift: out std_logic_vector(127 downto 0)
           
         );
end bram_tb;

architecture tb of bram_tb is
    signal rst      : std_logic;
    signal clk     : std_logic := '0';
     signal write_index : integer range 0 to 15 := 0;  -- Counter for write operations
    signal processing_done : std_logic := '0';        -- Flag for process completion
    signal en      : std_logic:='1';  -- enable signal that basically enables memory for read/write
    signal we:STD_LOGIC_VECTOR(0 DOWNTO 0):="0";
    
    signal din: STD_LOGIC_VECTOR(7 DOWNTO 0);
    signal dinr: STD_LOGIC_VECTOR(7 DOWNTO 0);
    signal addr     :   std_logic_vector(3 downto 0) := (others => '0'); 
    signal waddr     :   std_logic_vector(3 downto 0) := (others => '0'); 
    
    signal w:integer:=0;
    signal raddr     :   std_logic_vector(3 downto 0) := (others => '0'); 
    signal inv_mix:  std_logic_vector(127 downto 0);
    signal shift_rows: std_logic_vector(127 downto 0);
    component bram
        Port ( clk      : in  std_logic;
               rst      : in  std_logic;
               en      : in  std_logic;
               we       : in  std_logic_vector(0 downto 0);
               addr     : in  std_logic_vector(3 downto 0);
               din      : in  std_logic_vector(7 downto 0);
               dout     : out std_logic_vector(7 downto 0)
             );
    end component;
    component InvMixColumns
        Port(c: in std_logic_vector(127 downto 0); --columns;
        r: out std_logic_vector(127 downto 0));
        end component;
    component InvShiftRows
    Port(r: in std_logic_vector(127 downto 0); --rows;
    o: out std_logic_vector(127 downto 0));
    end component;
    type ram_type is array (0 to 15) of std_logic_vector(7 downto 0);
    signal ram : ram_type;
    signal ram_vector: std_logic_vector(127 downto 0);
        -- Memory initialization; the .coe file will replace this during synthesis
    --signal rdaddress : std_logic_vector(3 downto 0) := (others => '0');  
    signal data : std_logic_vector(7 downto 0) := (others => '0');
    signal new_data : std_logic_vector(7 downto 0) := (others => '0');
    signal dout: STD_LOGIC_VECTOR(7 DOWNTO 0);
    alias unresolved_unsigned is IEEE.numeric_std.unsigned; 
    signal ram_new : ram_type;
    signal ram_new_vector: std_logic_vector(127 downto 0);
    begin
    
    -- Output data based on the 1D address
    
    bram_inst : bram
        port map (
            clk  => clk, 
            rst=>rst,      
            en   => en,
            we=>we,             
            addr => addr, 
            din=>din,                    
            dout => data               
        );
    
    clk_process : process
    begin
        clk <= not clk after 100 ns; -- Clock with 200 ns period (5 MHz)
        wait for 100 ns;
    end process;
    process 
    begin
        --if we="0" and en='1' then
        
        for i in 0 to 15 loop
            wait for 1000 ns;
            addr <= std_logic_vector(to_unsigned(i, 4));
            
            end loop;
        
        
        --end if;
        
        wait;
        --en<='0';
    end process;
   
    process (clk, addr,we,en)
    begin
      
            if rising_edge(clk) then
            if en='1' and we="0" then
          
                ram(to_integer(unresolved_unsigned(addr)))<=data;
           
                
            end if;
        end if;   
        
        --en<='0';
                        
    end process;
  
    
    process(ram)
    begin
    
        for i in 15 downto 0 loop
            ram_vector(8*i+7 downto 8*i)<=ram(15-i);
        end loop;
    
    end process;
DUT1: InvMixColumns port map(c=>ram_vector, r=> inv_mix);
DUT2: InvShiftRows port map(r=>ram_vector, o=>shift_rows);
inv<=inv_mix;   
shift<=shift_rows;

-- Process to trigger the write operation after inv_mix data is ready
bram_instw : bram
        port map (
            clk  => clk, 
            rst=>rst,      
            en   => '1',
            we=>"1",             
            addr => waddr, 
            din=>din,                    
            dout => dout               
        );
    
process
begin
    wait on inv_mix;
    wait for 15000 ns;  
    for i in 0 to 15 loop
            wait for 1000 ns;
            waddr <= std_logic_vector(to_unsigned(i, 4));
            
        end loop;  
        
     wait; 
 end process;

process(clk, waddr, inv_mix)
begin
    
    if rising_edge(clk) then
    
       din <= inv_mix(127 - (8 * to_integer(unresolved_unsigned(waddr))) downto 120 - (8 * to_integer(unresolved_unsigned(waddr))));
       
    end if;
    
    
end process;
process(clk, inv_mix, dout, din, waddr)
begin
   if rising_edge(clk) then
   ram_new(to_integer(unresolved_unsigned(waddr)))<=dout;
   end if;
end process;

process(ram_new)

    begin
        for i in 15 downto 0 loop
            ram_new_vector(8*i+7 downto 8*i)<=ram_new(15-i);
        end loop;
    
        
    end process;
end tb;      