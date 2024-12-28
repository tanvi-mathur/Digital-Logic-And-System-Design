----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/15/2024 01:54:48 PM
-- Design Name: 
-- Module Name: AddRoundKey - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity InvMixColumns is
    Port(c: in std_logic_vector(127 downto 0); --columns;
    r: out std_logic_vector(127 downto 0));
    
end InvMixColumns;

architecture Behavioral of InvMixColumns is
    component galois
    Port(i: in std_logic_vector(31 downto 0);
    val: in std_logic_vector(31 downto 0);
    o: out std_logic_vector(7 downto 0));
    end component;
    signal c0: std_logic_vector(31 downto 0);
    signal c1: std_logic_vector(31 downto 0);
    signal c2: std_logic_vector(31 downto 0);
    signal c3: std_logic_vector(31 downto 0);
    signal s0: std_logic_vector(31 downto 0);
    signal s1: std_logic_vector(31 downto 0);
    signal s2: std_logic_vector(31 downto 0);
    signal s3: std_logic_vector(31 downto 0);
    signal r0:  std_logic_vector(31 downto 0);
    signal r1:  std_logic_vector(31 downto 0);
    signal r2:  std_logic_vector(31 downto 0);
    signal r3:  std_logic_vector(31 downto 0);
begin
    
    c0<=c(127 downto 120)&c(95 downto 88)&c(63 downto 56)&c(31 downto 24);
    c1<=c(119 downto 112)&c(87 downto 80)&c(55 downto 48)&c(23 downto 16);
    c2<=c(111 downto 104)&c(79 downto 72)&c(47 downto 40)&c(15 downto 8);
    c3<=c(103 downto 96)&c(71 downto 64)&c(39 downto 32)&c(7 downto 0);
    s0<=x"0E0B0D09";
    s1<=x"090E0B0D";
    s2<=x"0D090E0B";
    s3<=x"0B0D090E";
    mix00: galois port map(i=>c0, val=>s0, o=>r0(31 downto 24));
    mix01: galois port map(i=>c1, val=>s0, o=>r0(23 downto 16));
    mix02: galois port map(i=>c2, val=>s0, o=>r0(15 downto 8));
    mix03: galois port map(i=>c3, val=>s0, o=>r0(7 downto 0));
    
    mix10: galois port map(i=>c0, val=>s1, o=>r1(31 downto 24));
    mix11: galois port map(i=>c1, val=>s1, o=>r1(23 downto 16));
    mix12: galois port map(i=>c2, val=>s1, o=>r1(15 downto 8));
    mix13: galois port map(i=>c3, val=>s1, o=>r1(7 downto 0));
    
    mix20: galois port map(i=>c0, val=>s2, o=>r2(31 downto 24));
    mix21: galois port map(i=>c1, val=>s2, o=>r2(23 downto 16));
    mix22: galois port map(i=>c2, val=>s2, o=>r2(15 downto 8));
    mix23: galois port map(i=>c3, val=>s2, o=>r2(7 downto 0));
    
    mix30: galois port map(i=>c0, val=>s3, o=>r3(31 downto 24));
    mix31: galois port map(i=>c1, val=>s3, o=>r3(23 downto 16));
    mix32: galois port map(i=>c2, val=>s3, o=>r3(15 downto 8));
    mix33: galois port map(i=>c3, val=>s3, o=>r3(7 downto 0));
    r<=r0&r1&r2&r3;
end Behavioral;