library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity galois is
    Port(i: in std_logic_vector(31 downto 0);
    val: in std_logic_vector(31 downto 0);
    o: out std_logic_vector(7 downto 0));
end galois;

architecture Behavioral of galois is
signal bin: std_logic_vector(7 downto 0);
signal bin0: std_logic_vector(7 downto 0);
signal bin1: std_logic_vector(7 downto 0);
signal bin2: std_logic_vector(7 downto 0);
signal bin3: std_logic_vector(7 downto 0);
signal i0: std_logic_vector(7 downto 0);
signal i1: std_logic_vector(7 downto 0);
signal i2: std_logic_vector(7 downto 0);
signal i3: std_logic_vector(7 downto 0);
signal s0: std_logic_vector(7 downto 0);
signal s1: std_logic_vector(7 downto 0);
signal s2: std_logic_vector(7 downto 0);
signal s3: std_logic_vector(7 downto 0);
signal poly: std_logic_vector(8 downto 0);
begin
    poly<="100011011";

    i0<=val(31 downto 24);
    i1<=val(23 downto 16);
    i2<=val(15 downto 8);
    i3<=val(7 downto 0);
    s0<=i(31 downto 24);
    s1<=i(23 downto 16);
    s2<=i(15 downto 8);
    s3<=i(7 downto 0);


    process(s0, i0, bin0)
    variable b0: std_logic_vector(15 downto 0);
    variable s_0: std_logic_vector(15 downto 0);
    variable s_1: std_logic_vector(15 downto 0);
    variable s_2: std_logic_vector(15 downto 0);
    variable s_3: std_logic_vector(15 downto 0);
    begin
    s_0:="00000000"&s0;
    s_1:="0000000"&s0&"0";
    s_2:="000000"&s0&"00";
    s_3:="00000"&s0&"000";


    if i0=x"0e" then

        b0:=s_1 xor s_2 xor s_3;

    elsif i0=x"0b" then
      b0:=s_1 xor s_0 xor s_3;

    elsif i0=x"0d" then
        b0:=s_2 xor s_0 xor s_3;


    elsif i0=x"09" then
        b0:=s_0 xor s_3;
    
    end if;
    for i in 15 downto 8 loop
            if b0(i)='1' then
                b0(i downto i-8):=b0(i downto i-8) xor poly;
            end if;
            end loop;
        bin0<=b0(7 downto 0);

    end process;
    process(s1, i1, bin1)
    variable b1: std_logic_vector(15 downto 0);
    variable s1_0: std_logic_vector(15 downto 0);
    variable s1_1: std_logic_vector(15 downto 0);
    variable s1_2: std_logic_vector(15 downto 0);
    variable s1_3: std_logic_vector(15 downto 0);
    begin
    s1_0:="00000000"&s1;
    s1_1:="0000000"&s1&"0";
    s1_2:="000000"&s1&"00";
    s1_3:="00000"&s1&"000";

    if i1=x"0e" then
        b1:=s1_1 xor s1_2 xor s1_3;

    elsif i1=x"0b" then
        b1:=s1_1 xor s1_0 xor s1_3;


    elsif i1=x"0d" then
        b1:=s1_2 xor s1_0 xor s1_3;


    elsif i1=x"09" then
        b1:=s1_0 xor s1_3;
    
    end if;
    
    for i in 15 downto 8 loop
            if b1(i)='1' then
                b1(i downto i-8):=b1(i downto i-8) xor poly;
            end if;
            end loop;
        bin1<=b1(7 downto 0);
    end process;
    process(s2, i2, bin2)
    variable b2: std_logic_vector(15 downto 0);
    variable s2_0: std_logic_vector(15 downto 0);
    variable s2_1: std_logic_vector(15 downto 0);
    variable s2_2: std_logic_vector(15 downto 0);
    variable s2_3: std_logic_vector(15 downto 0);
    begin
    s2_0:="00000000"&s2;
    s2_1:="0000000"&s2&"0";
    s2_2:="000000"&s2&"00";
    s2_3:="00000"&s2&"000";
    if i2=x"0e" then
        b2:=s2_1 xor s2_2 xor s2_3;

    elsif i2=x"0b" then
        b2:=s2_1 xor s2_0 xor s2_3;


    elsif i2=x"0d" then
        b2:=s2_2 xor s2_0 xor s2_3;


    elsif i2=x"09" then
        b2:=s2_0 xor s2_3;
    
    end if;
    for i in 15 downto 8 loop
            if b2(i)='1' then
                b2(i downto i-8):=b2(i downto i-8) xor poly;
            end if;
            end loop;
        bin2<=b2(7 downto 0);
    end process;
    process(s3, i3, bin3)
        variable b3: std_logic_vector(15 downto 0);
        variable s3_0: std_logic_vector(15 downto 0);
        variable s3_1: std_logic_vector(15 downto 0);
        variable s3_2: std_logic_vector(15 downto 0);
        variable s3_3: std_logic_vector(15 downto 0);
        begin
        s3_0:="00000000"&s3;
        s3_1:="0000000"&s3&"0";
        s3_2:="000000"&s3&"00";
        s3_3:="00000"&s3&"000";

    if i3=x"0e" then
        b3:=s3_1 xor s3_2 xor s3_3;


    elsif i3=x"0b" then
        b3:=s3_1 xor s3_0 xor s3_3;


    elsif i3=x"0d" then
        b3:=s3_2 xor s3_0 xor s3_3;


    elsif i3=x"09" then
        b3:=s3_0 xor s3_3;


    end if;
    for i in 15 downto 8 loop
            if b3(i)='1' then
                b3(i downto i-8):=b3(i downto i-8) xor poly;
            end if;
            end loop;
    bin3<=b3(7 downto 0);
    end process;

    bin<=bin0 xor bin1 xor bin2 xor bin3;
    o<=bin;
--    process(bin)
--    begin
--    if bin(7 downto 4) = "0000" then
--        o(1) <= '0';
--    elsif bin(7 downto 4) = "0001" then
--        o(1) <= '1';
--    elsif bin(7 downto 4) = "0010" then
--        o(1) <= '2';
--    elsif bin(7 downto 4) = "0011" then
--        o(1) <= '3';
--    elsif bin(7 downto 4) = "0100" then
--        o(1) <= '4';
--    elsif bin(7 downto 4) = "0101" then
--        o(1) <= '5';
--    elsif bin(7 downto 4) = "0110" then
--        o(1) <= '6';
--    elsif bin(7 downto 4) = "0111" then
--        o(1) <= '7';
--    elsif bin(7 downto 4) = "1000" then
--        o(1) <= '8';
--    elsif bin(7 downto 4) = "1001" then
--        o(1) <= '9';
--    elsif bin(7 downto 4) = "1010" then
--        o(1) <= 'A';
--    elsif bin(7 downto 4) = "1011" then
--        o(1) <= 'B';
--    elsif bin(7 downto 4) = "1100" then
--        o(1) <= 'C';
--    elsif bin(7 downto 4) = "1101" then
--        o(1) <= 'D';
--    elsif bin(7 downto 4) = "1110" then
--        o(1) <= 'E';
--    elsif bin(7 downto 4) = "1111" then
--        o(1) <= 'F';
--    end if;

--    if bin(3 downto 0) = "0000" then
--        o(2) <= '0';
--    elsif bin(3 downto 0) = "0001" then
--        o(2) <= '1';
--    elsif bin(3 downto 0) = "0010" then
--        o(2) <= '2';
--    elsif bin(3 downto 0) = "0011" then
--        o(2) <= '3';
--    elsif bin(3 downto 0) = "0100" then
--        o(2) <= '4';
--    elsif bin(3 downto 0) = "0101" then
--        o(2) <= '5';
--    elsif bin(3 downto 0) = "0110" then
--        o(2) <= '6';
--    elsif bin(3 downto 0) = "0111" then
--        o(2) <= '7';
--    elsif bin(3 downto 0) = "1000" then
--        o(2) <= '8';
--    elsif bin(3 downto 0) = "1001" then
--        o(2) <= '9';
--    elsif bin(3 downto 0) = "1010" then
--        o(2) <= 'A';
--    elsif bin(3 downto 0) = "1011" then
--        o(2) <= 'B';
--    elsif bin(3 downto 0) = "1100" then
--        o(2) <= 'C';
--    elsif bin(3 downto 0) = "1101" then
--        o(2) <= 'D';
--    elsif bin(3 downto 0) = "1110" then
--        o(2) <= 'E';
--    elsif bin(3 downto 0) = "1111" then
--        o(2) <= 'F';


--    end if;
--    end process;

end Behavioral;