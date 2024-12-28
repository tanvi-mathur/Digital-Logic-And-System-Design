library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decrypt_FSM is
port(
clk : in STD_LOGIC;

an: out std_logic_vector(3 downto 0);
a: out STD_LOGIC;
b: out STD_LOGIC;
c: out STD_LOGIC;
d: out STD_LOGIC;
e: out STD_LOGIC;
f: out STD_LOGIC;
g: out STD_LOGIC
);

end decrypt_FSM;

architecture Behavioral of decrypt_FSM is
component bram

        port (clk : in STD_LOGIC;
en : in STD_LOGIC;
addr : IN STD_LOGIC_VECTOR(7 DOWNTO 0);

dout: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)

        );
        end component;
component bram_test

        port (clk : in STD_LOGIC;
en : in STD_LOGIC;

addr : IN STD_LOGIC_VECTOR(3 DOWNTO 0);

dout: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)

        );

        end component;
        
--component bram_sbox

--        port (clk : in STD_LOGIC;
--en : in STD_LOGIC;
--addr : IN STD_LOGIC_VECTOR(7 DOWNTO 0);

--dout: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)

--        );

--        end component;

component display
port(clka:in std_logic;
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
end component;

component hex_to_ascii
port (c: in std_logic_vector(127 downto 0);
ascii: out string(1 to 16));
end component;

signal reg_key: std_logic_vector(1279 downto 0):=(others=>'0');
signal i: std_logic_vector(127 downto 0):=(others=>'0');
signal en      : std_logic:='1';  -- enable signal that basically enables memory for read/write

    signal we:STD_LOGIC_VECTOR(0 DOWNTO 0):="0";
    
    signal addr     :   std_logic_vector(7 downto 0) := (others => '0');
     alias unresolved_unsigned is IEEE.numeric_std.unsigned;
type ram_type is array (0 to 159) of std_logic_vector(7 downto 0);
signal o1: string(1 to 16);
    signal ram : ram_type;
    signal data : std_logic_vector(7 downto 0) := (others => '0');

    signal addr1     :   std_logic_vector(3 downto 0) := (others => '0');
type ram_type1 is array (0 to 15) of std_logic_vector(7 downto 0);
--signal reset : STD_LOGIC;
--signal cntrl : STD_LOGIC;
    signal ram1 : ram_type1;
    

    signal data1 : std_logic_vector(7 downto 0) := (others => '0');
signal inv_sbox: std_logic_vector(2047 downto 0) := x"52096ad53036a538bf40a39e81f3d7fb7ce339829b2fff87348e4344c4dee9cb547b9432a6c2233dee4c950b42fac34e082ea16628d924b2765ba2496d8bd12572f8f66486689816d4a45ccc5d65b6926c704850fdedb9da5e154657a78d9d8490d8ab008cbcd30af7e45805b8b34506d02c1e8fca3f0f02c1afbd0301138a6b3a9111414f67dcea97f2cfcef0b4e67396ac7422e7ad3585e2f937e81c75df6e47f11a711d29c5896fb7620eaa18be1bfc563e4bc6d279209adbc0fe78cd5af41fdda8338807c731b11210592780ec5f60517fa919b54a0d2de57a9f93c99cef60a03b4dae2af5b0c8ebbb3c83539961172b047eba77d626e169146355210c7d";
type ram_type2 is array (0 to 255) of std_logic_vector(7 downto 0);
    signal ram2 : ram_type2;
    
    signal addr2 : std_logic_vector(7 downto 0) := (others => '0');  
    signal data2 : std_logic_vector(7 downto 0) := (others => '0');

--signal curr:std_logic_vector(127 downto 0);
--signal next_step:std_logic_vector(127 downto 0);
type matrix is array (1 to 8) of std_logic_vector(639 downto 0);
signal r_main: matrix;

signal count: integer :=1;
signal count2: integer :=0;
signal count1: integer:=0;
signal cnt1: integer:=0;
signal cnt2: integer:=0;
signal cnt3: integer:=0;
signal M : STD_LOGIC :='1';
signal Done : STD_LOGIC:='1';
signal DoneM : STD_LOGIC:='1';
signal DoneS : STD_LOGIC:='1';
signal DoneSh : STD_LOGIC:='1';
signal DoneR : STD_LOGIC:='1';
signal s: std_logic_vector(127 downto 0);
--signal curr : std_logic_vector(127 downto 0);
  -- signal next_step : std_logic_vector(127 downto 0);
function addRoundKey(c: std_logic_vector(127 downto 0); round_key: std_logic_vector(127 downto 0)) return std_logic_vector is
variable result : std_logic_vector(127 downto 0);
begin
    result:=c xor round_key;
    return result;
end function;

function galois_func(i: std_logic_vector(31 downto 0); val: std_logic_vector(31 downto 0)) return std_logic_vector is
    variable bin: std_logic_vector(7 downto 0);
    variable bin0, bin1, bin2, bin3: std_logic_vector(7 downto 0);
    variable i0, i1, i2, i3: std_logic_vector(7 downto 0);
    variable s0, s1, s2, s3: std_logic_vector(7 downto 0);
    variable poly: std_logic_vector(8 downto 0) := "100011011";
    variable b0: std_logic_vector(15 downto 0);
    variable s_0, s_1, s_2, s_3: std_logic_vector(15 downto 0);
    variable b1: std_logic_vector(15 downto 0);
    variable s1_0, s1_1, s1_2, s1_3: std_logic_vector(15 downto 0);
    variable b2: std_logic_vector(15 downto 0);
    variable s2_0, s2_1, s2_2, s2_3: std_logic_vector(15 downto 0);
    variable b3: std_logic_vector(15 downto 0);
    variable s3_0, s3_1, s3_2, s3_3: std_logic_vector(15 downto 0);
begin
    i0 := val(31 downto 24);
    i1 := val(23 downto 16);
    i2 := val(15 downto 8);
    i3 := val(7 downto 0);
    s0 := i(31 downto 24);
    s1 := i(23 downto 16);
    s2 := i(15 downto 8);
    s3 := i(7 downto 0);

    s_0 := "00000000" & s0;
    s_1 := "0000000" & s0 & "0";
    s_2 := "000000" & s0 & "00";
    s_3 := "00000" & s0 & "000";

    if i0 = x"0e" then
        b0 := s_1 xor s_2 xor s_3;
    elsif i0 = x"0b" then
        b0 := s_1 xor s_0 xor s_3;
    elsif i0 = x"0d" then
        b0 := s_2 xor s_0 xor s_3;
    elsif i0 = x"09" then
        b0 := s_0 xor s_3;
    end if;

    for i in 15 downto 8 loop
        if b0(i) = '1' then
            b0(i downto i-8) := b0(i downto i-8) xor poly;
        end if;
    end loop;

    bin0 := b0(7 downto 0);


    s1_0 := "00000000" & s1;
    s1_1 := "0000000" & s1 & "0";
    s1_2 := "000000" & s1 & "00";
    s1_3 := "00000" & s1 & "000";

    if i1 = x"0e" then
        b1 := s1_1 xor s1_2 xor s1_3;
    elsif i1 = x"0b" then
        b1 := s1_1 xor s1_0 xor s1_3;
    elsif i1 = x"0d" then
        b1 := s1_2 xor s1_0 xor s1_3;
    elsif i1 = x"09" then
        b1 := s1_0 xor s1_3;
    end if;

    for i in 15 downto 8 loop
        if b1(i) = '1' then
            b1(i downto i-8) := b1(i downto i-8) xor poly;
        end if;
    end loop;

    bin1 := b1(7 downto 0);


    s2_0 := "00000000" & s2;
    s2_1 := "0000000" & s2 & "0";
    s2_2 := "000000" & s2 & "00";
    s2_3 := "00000" & s2 & "000";

    if i2 = x"0e" then
        b2 := s2_1 xor s2_2 xor s2_3;
    elsif i2 = x"0b" then
        b2 := s2_1 xor s2_0 xor s2_3;
    elsif i2 = x"0d" then
        b2 := s2_2 xor s2_0 xor s2_3;
    elsif i2 = x"09" then
        b2 := s2_0 xor s2_3;
    end if;

    for i in 15 downto 8 loop
        if b2(i) = '1' then
            b2(i downto i-8) := b2(i downto i-8) xor poly;
        end if;
    end loop;

    bin2 := b2(7 downto 0);

    s3_0 := "00000000" & s3;
    s3_1 := "0000000" & s3 & "0";
    s3_2 := "000000" & s3 & "00";
    s3_3 := "00000" & s3 & "000";

    if i3 = x"0e" then
        b3 := s3_1 xor s3_2 xor s3_3;
    elsif i3 = x"0b" then
        b3 := s3_1 xor s3_0 xor s3_3;
    elsif i3 = x"0d" then
        b3 := s3_2 xor s3_0 xor s3_3;
    elsif i3 = x"09" then
        b3 := s3_0 xor s3_3;
    end if;

    for i in 15 downto 8 loop
        if b3(i) = '1' then
            b3(i downto i-8) := b3(i downto i-8) xor poly;
        end if;
    end loop;

    bin3 := b3(7 downto 0);

    bin := bin0 xor bin1 xor bin2 xor bin3;
    return bin;
end function;

function InvMixColumns(
    c: std_logic_vector(127 downto 0)
) return std_logic_vector is

    variable c0, c1, c2, c3: std_logic_vector(31 downto 0);
    variable s0, s1, s2, s3: std_logic_vector(31 downto 0);
    variable r0, r1, r2, r3: std_logic_vector(31 downto 0);
begin

    c0 := c(127 downto 120) & c(95 downto 88) & c(63 downto 56) & c(31 downto 24);
    c1 := c(119 downto 112) & c(87 downto 80) & c(55 downto 48) & c(23 downto 16);
    c2 := c(111 downto 104) & c(79 downto 72) & c(47 downto 40) & c(15 downto 8);
    c3 := c(103 downto 96) & c(71 downto 64) & c(39 downto 32) & c(7 downto 0);
    s0 := x"0E0B0D09";
    s1 := x"090E0B0D";
    s2 := x"0D090E0B";
    s3 := x"0B0D090E";

    r0(31 downto 24) := galois_func(c0, s0);
    r0(23 downto 16) := galois_func(c1, s0);
    r0(15 downto 8) := galois_func(c2, s0);
    r0(7 downto 0) := galois_func(c3, s0);

    r1(31 downto 24) := galois_func(c0, s1);
    r1(23 downto 16) := galois_func(c1, s1);
    r1(15 downto 8) := galois_func(c2, s1);
    r1(7 downto 0) := galois_func(c3, s1);

    r2(31 downto 24) := galois_func(c0, s2);
    r2(23 downto 16) := galois_func(c1, s2);
    r2(15 downto 8) := galois_func(c2, s2);
    r2(7 downto 0) := galois_func(c3, s2);

    r3(31 downto 24) := galois_func(c0, s3);
    r3(23 downto 16) := galois_func(c1, s3);
    r3(15 downto 8) := galois_func(c2, s3);
    r3(7 downto 0) := galois_func(c3, s3);

    return r0 & r1 & r2 & r3;
end function;

function InvSubBytes(
    inv_sbox : std_logic_vector(2047 downto 0);
    r        : std_logic_vector(127 downto 0)    -- Input vector
) return std_logic_vector is

    variable output : std_logic_vector(127 downto 0);
    
    variable row : integer;
    variable col : integer;
begin

    for i in 0 to 15 loop

        row := to_integer(unsigned(r(8*i+7 downto 8*i+4)));
        col := to_integer(unsigned(r(8*i+3 downto 8*i)));

        output(8*i+7 downto 8*i) := inv_sbox(2047-(128*(row)+8*(col)) downto 2040-(128*(row)+8*(col)));
        
    end loop;

    return output;
end function;

function invShiftRows(r : std_logic_vector(127 downto 0)) return std_logic_vector is

    variable r0, r1, r2, r3 : std_logic_vector(31 downto 0);
    variable o0, o1, o2, o3 : std_logic_vector(31 downto 0);

    variable result : std_logic_vector(127 downto 0);
begin

    r3 := r(31 downto 0);
    r2 := r(63 downto 32);
    r1 := r(95 downto 64);
    r0 := r(127 downto 96);

    o0 := r0;
    o1 := r1(7 downto 0) & r1(31 downto 8);
    o2 := r2(15 downto 0) & r2(31 downto 16);
    o3 := r3(23 downto 0) & r3(31 downto 24);

    result := o0 & o1 & o2 & o3;

    return result;
end function;

signal reg: std_logic_vector(1279 downto 0);

type state_type is (ROUNDKEY, INVSHIFT, INVSUBBYTES, INVMIX);
    signal cur_state : state_type := ROUNDKEY;
    signal next_state : state_type := ROUNDKEY;

begin
        inst : bram

        port map (
            clk  => clk,
            en   => en,
           
            addr => addr,
            
            dout => data

        );
        inst1 : bram_test

        port map (
            clk  => clk,
            en   => en,
  
            addr => addr1,
            dout => data1

        );
--        inst2 : bram_sbox

--        port map (
--            clk  => clk,
--            en   => en,
            
--            addr => addr2,
           
--            dout => data2

--        );

    process

    begin
        for i in 0 to 159 loop

            wait for 1000 ns;
            addr <= std_logic_vector(to_unsigned(i, 8));
            end loop;
        wait;
    end process;
    process (clk, addr,we,en)

    begin
            if rising_edge(clk) then

            if en='1' and we="0" then
                ram(to_integer(unresolved_unsigned(addr)))<=data;
                count2<=count2+1;
             end if;

        end if;
    end process;
process(ram)

    begin
      for i in 159 downto 0 loop

            reg_key(8*i+7 downto 8*i)<=ram(159-i);
            

        end loop;

    end process;
    
process

    begin
        for j in 0 to 15 loop
            wait for 1000 ns;
            addr1 <= std_logic_vector(to_unsigned(j, 4));
            end loop;
        wait;
    end process;
    process (clk, addr1,we,en)

    begin
            if rising_edge(clk) then

            if en='1' and we="0" then
                ram1(to_integer(unresolved_unsigned(addr1)))<=data1;
                count1<=count1+1;
             end if;

        end if;
    end process;
process(ram1)

    begin
      for j in 15 downto 0 loop

            i(8*j+7 downto 8*j)<=ram1(15-j);

        end loop;

    end process;

process
    begin
        
        for i in 0 to 255 loop
            wait for 1000 ns;
            addr2 <= std_logic_vector(to_unsigned(i, 8));
            
        end loop;
        wait;
    end process;
--    process (clk, addr2)
--    begin
--        for i in 0 to 255 loop
          
--            if rising_edge(clk) then
--                ram2(to_integer(unresolved_unsigned(addr2)))<=data2;
               
--            end if;
            
--        end loop;
--    end process;
    
--    process(ram2)
--    begin
--        for i in 0 to 255 loop
--            inv_sbox(8*i+7 downto 8*i)<=ram2(i);
--        end loop;
        
--    end process;
process (clk, Done, next_state, count2)
begin
if count2>16000 then
    if (clk'EVENT AND clk = '1') and Done='1' then
        cur_state <= next_state;
    end if;
    end if;
end process;


process (clk, cur_state, next_state)
    
    variable round_key : std_logic_vector(127 downto 0);
    variable cnt_r: integer:=0;
    variable cnt_s: integer:=0;
    variable cnt_sh: integer:=0;
    variable cnt_m: integer:=0;
    
    
begin
    
    if count2>16000 then
    
    
    --reg(1407 downto 1280) <= i;
     
     if rising_edge(clk) then
       reg(1279 downto 1152)<=InvSubBytes(inv_sbox, invShiftRows(addRoundKey(i, reg_key(127 downto 0))));
        if count < 9 then
            r_main(count)(639 downto 512)<=reg(1279-128*(count-1) downto 1152-128*(count-1));
            case cur_state is
                when ROUNDKEY =>
                    next_state <= INVMIX;
                    round_key := reg_key(127+(count*128) downto (count*128));
                    r_main(count)(511 downto 384)<=addRoundKey(r_main(count)(639 downto 512), reg_key(127+(count*128) downto (count*128)));
                    --reg(1279-128*(count) downto 1152-128*(count)) <= addRoundKey(reg(1279-128*(count-1) downto 1152-128*(count-1)), reg_key(127+(count*128) downto (count*128)));
                    
                    cnt_r:=cnt_r+1;
                    
                    if cnt_r>127 then
                    DoneR <= '1';
                    Done <= '1';
                    M <= '1';
                    --curr<=next_step;
                    
                    cnt_r:=0;
                    else
                    DoneR <= '0';
                    Done <= '0';
                    end if;
        
                when INVMIX =>
                    next_state <= INVSHIFT;
                    r_main(count)(383 downto 256)<= InvMixColumns(r_main(count)(511 downto 384));
                    
                    cnt_m:=cnt_m+1;
                    
                    if cnt_m>127 then
                    DoneM <= '1';
                    Done <= '1';
                    M <= '1';
                    --curr <= next_step;
                    
                    cnt_m:=0;
                    else 
                    DoneM <= '0';
                    Done <= '0';
                    end if;
                when INVSHIFT =>
                    next_state <= INVSUBBYTES;
                    --reg(1279-128*(count) downto 1152-128*(count)) <= invShiftRows(reg(1279-128*(count) downto 1152-128*(count)));
                    r_main(count)(255 downto 128)<=invShiftRows(r_main(count)(383 downto 256));
                    
                    cnt_sh:=cnt_sh+1;
                    
                    if cnt_sh>127 then
                    DoneSh <= '1';
                    Done <= '1';
                    M <= '1';
                    
                    
                    cnt_sh:=0;
                    else
                    DoneSh <= '0';
                    Done <= '0';
                    end if;
                    

                when INVSUBBYTES =>
                    next_state <= ROUNDKEY;
                    --reg(1279-128*(count) downto 1152-128*(count)) <= InvSubBytes(inv_sbox, reg(1279-128*(count) downto 1152-128*(count)));
                    r_main(count)(127 downto 0)<=InvSubBytes(inv_sbox, r_main(count)(255 downto 128));
                    reg(1279-128*(count) downto 1152-128*(count)) <=r_main(count)(127 downto 0);
                    cnt_s:=cnt_s+1;
                    
                    if cnt_s>127 then
                    DoneS <= '1';
                    Done <= '1';
                    M <= '0';
                    --curr <= next_step;
                    count <= count + 1;
                    cnt_s:=0;
                    else
                    DoneS <= '0';
                    Done <= '0';
                    end if;
                    
            end case;
            
        elsif count = 9 then  
            if cur_state= ROUNDKEY then
                    round_key := reg_key(1279 downto 1152);
                    
                    reg(127 downto 0) <= addRoundKey(reg(255 downto 128), reg_key(1279 downto 1152));
                    
                    DoneR <= '1';
                    Done<='1';
                    M <= '0';
            
            end if;
        
        end if;
    end if;
    end if;
    
    
    
    
end process;

s<=reg(127 downto 0);

DUT1: hex_to_ascii port map(c=> s, ascii=>o1);
DUT: display port map(clka=>clk, main=>o1, an_m=>an, a_m=>a, b_m=>b, c_m=>c, d_m=>d, e_m=>e, f_m=>f, g_m=>g);
end Behavioral;


