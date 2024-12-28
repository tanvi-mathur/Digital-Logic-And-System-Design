----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/26/2024 08:45:28 PM
-- Design Name: 
-- Module Name: decoder - Behavioral
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
b0, b1, b2, b3: in std_logic;

a, b, c, d, e, f, g: out std_logic);

end decoder;

architecture Behavioral of decoder is
begin

a<=not(((not b0) and (not b3) and (not b2)) or ((not b3) and b2 and b0) or (b1 and b2) or ((not b0) and b3) or (b3 and (not b2) and (not b1)) or (b1 and (not b3)));
b<=not(((not b3) and (not b2)) or ((not b3) and (not b1) and (not b0)) or ((not b1) and b0 and b3) or (b1 and b0 and (not b3)) or (b3 and (not b2) and (not b1)) or (b3 and (not b2) and (not b0)));
c<=not(((not b3) and (not b1)) or ((not b3) and b2) or (b3 and (not b2)) or ((not b3) and b0) or ((not b1) and b0));
d<=not((b3 and (not b1)) or (b0 and (not b1) and b2) or ((not b2) and b3 and b0) or ((not b3) and (not b2) and (not b0)) or (b1 and (not b0) and b2) or (b1 and (not b2) and (not b3)));
e<=not((not b3 and not b2 and not b0) or (b3 and b2) or (b3 and not b0) or (b1 and b3) or (b1 and not b0));
f<=not((b2 and not b0) or (not b1 and not b0) or (not b3 and b2 and not b1) or (b3 and not b2) or (b3 and b1));
g<=not((not b3 and b2 and not b1) or (not b3 and not b2 and b1) or (b3 and b0) or (b3 and not b2) or (b1 and not b0));

end Behavioral;
