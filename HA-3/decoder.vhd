library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decoder is
Port(
asc: in string(1 to 1);

a, b, c, d, e, f, g: out std_logic);

end decoder;

architecture Behavioral of decoder is
signal bin: std_logic_vector(3 downto 0);
begin

process(asc)
begin
    if asc(1)='0' then
        a<='1';
        b<='1';
        c<='1';
        d<='1';
        e<='1';
        f<='1';
        g<='0';
    elsif asc(1)='1' then
        a<='0';
        b<='1';
        c<='1';
        d<='0';
        e<='0';
        f<='0';        
        g<='0';
    elsif asc(1)='2' then
        a<='1';
        b<='1';
        c<='0';
        d<='1';
        e<='1';
        f<='0';      
        g<='1';
    elsif asc(1)='3' then
        a<='1';
        b<='1';
        c<='1';
        d<='1';
        e<='0';
        f<='0';        
        g<='1';
    elsif asc(1)='4' then
        a<='0';
        b<='1';
        c<='1';
        d<='0';
        e<='0';
        f<='1';
        g<='1';
    elsif asc(1)='5' then
        a<='1';
        b<='0';
        c<='1';
        d<='1';
        e<='0';
        f<='1';
        g<='1';
    elsif asc(1)='6' then
        a<='1';
        b<='0';
        c<='1';
        d<='1';
        e<='1';
        f<='1';
        g<='1';
    elsif asc(1)='7' then
        a<='1';
        b<='1';
        c<='1';
        d<='0';
        e<='0';
        f<='0';
        g<='0';
    elsif asc(1)='8' then
        a<='1';
        b<='1';
        c<='1';
        d<='1';
        e<='1';
        f<='1';
        g<='1';
    elsif asc(1)='9' then
        a<='1';
        b<='1';
        c<='1';
        d<='1';
        e<='0';
        f<='1';
        g<='1';
    elsif asc(1)='A' then
        a<='1';
        b<='1';
        c<='1';
        d<='0'; 
        e<='1';
        f<='1';
        g<='1';
                
    elsif asc(1)='B' then
        a<='0';
        b<='0';
        c<='1';
        d<='1';
        e<='1';
        f<='1';
        g<='1';
    elsif asc(1)='C' then
        a<='1';
        b<='0';
        c<='0';
        d<='1';
        e<='1';
        f<='1';
        g<='0';
    elsif asc(1)='D' then
        
        a<='0';
        b<='1';
        c<='1';
        d<='1';
        e<='1';
        f<='0';
        g<='1';
    elsif asc(1)='E' then
        a<='1';
        b<='0';
        c<='0';
        d<='1';
        e<='1';
        f<='1';
        g<='1';
        
    elsif asc(1)='F' then
        a<='1'; 
        b<='0';
        c<='0';
        d<='0';
        e<='1';
        f<='1';
        g<='1';
    elsif asc(1)=' ' then
        a<='0'; 
        b<='0';
        c<='0';
        d<='0';
        e<='0';
        f<='0';
        g<='0';
    else
        a<='0';
        b<='0';
        c<='0';
        d<='0';
        e<='0';
        f<='0';
        g<='1';
    end if;
    end process;
--a<=not(((not b0) and (not b3) and (not b2)) or ((not b3) and b2 and b0) or (b1 and b2) or ((not b0) and b3) or (b3 and (not b2) and (not b1)) or (b1 and (not b3)));
--b<=not(((not b3) and (not b2)) or ((not b3) and (not b1) and (not b0)) or ((not b1) and b0 and b3) or (b1 and b0 and (not b3)) or (b3 and (not b2) and (not b1)) or (b3 and (not b2) and (not b0)));
--c<=not(((not b3) and (not b1)) or ((not b3) and b2) or (b3 and (not b2)) or ((not b3) and b0) or ((not b1) and b0));
--d<=not((b3 and (not b1)) or (b0 and (not b1) and b2) or ((not b2) and b3 and b0) or ((not b3) and (not b2) and (not b0)) or (b1 and (not b0) and b2) or (b1 and (not b2) and (not b3)));
--e<=not((not b3 and not b2 and not b0) or (b3 and b2) or (b3 and not b0) or (b1 and b3) or (b1 and not b0));
--f<=not((b2 and not b0) or (not b1 and not b0) or (not b3 and b2 and not b1) or (b3 and not b2) or (b3 and b1));
--g<=not((not b3 and b2 and not b1) or (not b3 and not b2 and b1) or (b3 and b0) or (b3 and not b2) or (b1 and not b0));


end Behavioral;