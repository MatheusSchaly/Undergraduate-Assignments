-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 64-Bit"
-- VERSION "Version 13.0.0 Build 156 04/24/2013 SJ Web Edition"

-- DATE "11/20/2018 11:05:02"

-- 
-- Device: Altera EP2C35F672C6 Package FBGA672
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY CYCLONEII;
LIBRARY IEEE;
USE CYCLONEII.CYCLONEII_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	interface IS
    PORT (
	clock : IN std_logic;
	resetn : IN std_logic;
	readdata : OUT std_logic_vector(7 DOWNTO 0)
	);
END interface;

-- Design Ports Information
-- readdata[0]	=>  Location: PIN_B20,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- readdata[1]	=>  Location: PIN_E20,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- readdata[2]	=>  Location: PIN_C19,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- readdata[3]	=>  Location: PIN_B19,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- readdata[4]	=>  Location: PIN_D19,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- readdata[5]	=>  Location: PIN_K16,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- readdata[6]	=>  Location: PIN_D20,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- readdata[7]	=>  Location: PIN_J16,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- clock	=>  Location: PIN_P2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- resetn	=>  Location: PIN_P1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default


ARCHITECTURE structure OF interface IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clock : std_logic;
SIGNAL ww_resetn : std_logic;
SIGNAL ww_readdata : std_logic_vector(7 DOWNTO 0);
SIGNAL \clock~clkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \resetn~clkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \top|bo_map|Rcktimer|currentState[3]~30_combout\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[5]~34_combout\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[7]~38_combout\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[16]~56_combout\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[18]~60_combout\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[21]~66_combout\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[24]~73\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[25]~74_combout\ : std_logic;
SIGNAL \top|bo_map|Rtime|currentState[2]~9_combout\ : std_logic;
SIGNAL \top|bc_map|Selector0~1_combout\ : std_logic;
SIGNAL \top|bc_map|Selector0~5_combout\ : std_logic;
SIGNAL \clock~combout\ : std_logic;
SIGNAL \clock~clkctrl_outclk\ : std_logic;
SIGNAL \top|bo_map|Rtime|currentState[0]~21_combout\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[1]~26_combout\ : std_logic;
SIGNAL \top|bc_map|currentState.init~feeder_combout\ : std_logic;
SIGNAL \resetn~combout\ : std_logic;
SIGNAL \resetn~clkctrl_outclk\ : std_logic;
SIGNAL \top|bc_map|currentState.init~regout\ : std_logic;
SIGNAL \top|bc_map|rstcktimer~combout\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[1]~27\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[2]~29\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[3]~31\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[4]~32_combout\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[4]~33\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[5]~35\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[6]~36_combout\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[6]~37\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[7]~39\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[8]~40_combout\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[8]~41\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[9]~43\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[10]~44_combout\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[10]~45\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[11]~46_combout\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[11]~47\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[12]~48_combout\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[12]~49\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[13]~50_combout\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[13]~51\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[14]~52_combout\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[14]~53\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[15]~54_combout\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[15]~55\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[16]~57\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[17]~58_combout\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[17]~59\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[18]~61\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[19]~63\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[20]~64_combout\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[20]~65\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[21]~67\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[22]~68_combout\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[22]~69\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[23]~70_combout\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[23]~71\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[24]~72_combout\ : std_logic;
SIGNAL \top|bc_map|Selector0~7_combout\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[9]~42_combout\ : std_logic;
SIGNAL \top|bc_map|Selector0~2_combout\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[0]~25_combout\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[2]~28_combout\ : std_logic;
SIGNAL \top|bc_map|Selector0~0_combout\ : std_logic;
SIGNAL \top|bc_map|Selector0~3_combout\ : std_logic;
SIGNAL \top|bc_map|Selector0~4_combout\ : std_logic;
SIGNAL \top|bo_map|Rcktimer|currentState[19]~62_combout\ : std_logic;
SIGNAL \top|bc_map|Selector0~6_combout\ : std_logic;
SIGNAL \top|bc_map|Selector0~8_combout\ : std_logic;
SIGNAL \top|bc_map|currentState.S2~regout\ : std_logic;
SIGNAL \top|bo_map|Rtime|currentState[4]~13_combout\ : std_logic;
SIGNAL \top|bo_map|Cs140|Equal0~0_combout\ : std_logic;
SIGNAL \top|bc_map|nextState.S8~0_combout\ : std_logic;
SIGNAL \top|bc_map|currentState.S8~regout\ : std_logic;
SIGNAL \top|bc_map|rstcktimer~0_combout\ : std_logic;
SIGNAL \top|bo_map|Rtime|currentState[1]~8\ : std_logic;
SIGNAL \top|bo_map|Rtime|currentState[2]~10\ : std_logic;
SIGNAL \top|bo_map|Rtime|currentState[3]~11_combout\ : std_logic;
SIGNAL \top|bo_map|Rtime|currentState[3]~12\ : std_logic;
SIGNAL \top|bo_map|Rtime|currentState[4]~14\ : std_logic;
SIGNAL \top|bo_map|Rtime|currentState[5]~15_combout\ : std_logic;
SIGNAL \top|bo_map|Rtime|currentState[5]~16\ : std_logic;
SIGNAL \top|bo_map|Rtime|currentState[6]~17_combout\ : std_logic;
SIGNAL \top|bo_map|Rtime|currentState[6]~18\ : std_logic;
SIGNAL \top|bo_map|Rtime|currentState[7]~19_combout\ : std_logic;
SIGNAL \top|bo_map|Cs140|Equal0~1_combout\ : std_logic;
SIGNAL \top|bo_map|Cs55|Equal0~0_combout\ : std_logic;
SIGNAL \top|bo_map|Cs100|Equal0~0_combout\ : std_logic;
SIGNAL \top|bo_map|Cs55|Equal0~1_combout\ : std_logic;
SIGNAL \top|bo_map|Rtime|currentState[1]~7_combout\ : std_logic;
SIGNAL \top|bo_map|Cs110|Equal0~0_combout\ : std_logic;
SIGNAL \top|bc_map|Selector0~10_combout\ : std_logic;
SIGNAL \top|bo_map|Cs45|Equal0~1_combout\ : std_logic;
SIGNAL \top|bo_map|Cs45|Equal0~0_combout\ : std_logic;
SIGNAL \top|bc_map|NSL~1_combout\ : std_logic;
SIGNAL \top|bc_map|NSL~0_combout\ : std_logic;
SIGNAL \top|bc_map|NSL~2_combout\ : std_logic;
SIGNAL \top|bc_map|NSL~3_combout\ : std_logic;
SIGNAL \top|bc_map|Selector0~9_combout\ : std_logic;
SIGNAL \top|bc_map|Selector0~11_combout\ : std_logic;
SIGNAL \top|bc_map|currentState.S0~regout\ : std_logic;
SIGNAL \top|bc_map|cMuxP~0_combout\ : std_logic;
SIGNAL \top|bo_map|RP|currentState[0]~0_combout\ : std_logic;
SIGNAL \top|bc_map|nextState.S4~0_combout\ : std_logic;
SIGNAL \top|bc_map|currentState.S4~regout\ : std_logic;
SIGNAL \top|bc_map|nextState.S7~0_combout\ : std_logic;
SIGNAL \top|bc_map|currentState.S7~regout\ : std_logic;
SIGNAL \top|bc_map|eP~0_combout\ : std_logic;
SIGNAL \top|bo_map|Cs100|Equal0~1_combout\ : std_logic;
SIGNAL \top|bo_map|Cs100|Equal0~2_combout\ : std_logic;
SIGNAL \top|bc_map|nextState.S6~0_combout\ : std_logic;
SIGNAL \top|bc_map|currentState.S6~regout\ : std_logic;
SIGNAL \top|bc_map|nextState.S3~0_combout\ : std_logic;
SIGNAL \top|bc_map|currentState.S3~regout\ : std_logic;
SIGNAL \top|bc_map|eNS~0_combout\ : std_logic;
SIGNAL \top|bo_map|MEW|Equal2~0_combout\ : std_logic;
SIGNAL \top|bc_map|nextState.S5~0_combout\ : std_logic;
SIGNAL \top|bc_map|currentState.S5~regout\ : std_logic;
SIGNAL \top|bc_map|eEW~combout\ : std_logic;
SIGNAL \top|bo_map|REW|currentState[1]~feeder_combout\ : std_logic;
SIGNAL \top|bo_map|MEW|Equal2~1_combout\ : std_logic;
SIGNAL \top|bo_map|MNS|Equal2~0_combout\ : std_logic;
SIGNAL \top|bo_map|MNS|Equal2~1_combout\ : std_logic;
SIGNAL \top|bo_map|MNS|Equal2~2_combout\ : std_logic;
SIGNAL \top|bo_map|RNS|currentState\ : std_logic_vector(2 DOWNTO 0);
SIGNAL \top|bo_map|RP|currentState\ : std_logic_vector(1 DOWNTO 0);
SIGNAL \top|bo_map|Rcktimer|currentState\ : std_logic_vector(25 DOWNTO 0);
SIGNAL \top|bo_map|REW|currentState\ : std_logic_vector(2 DOWNTO 0);
SIGNAL \top|bo_map|Rtime|currentState\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \ALT_INV_resetn~clkctrl_outclk\ : std_logic;

BEGIN

ww_clock <= clock;
ww_resetn <= resetn;
readdata <= ww_readdata;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\clock~clkctrl_INCLK_bus\ <= (gnd & gnd & gnd & \clock~combout\);

\resetn~clkctrl_INCLK_bus\ <= (gnd & gnd & gnd & \resetn~combout\);
\ALT_INV_resetn~clkctrl_outclk\ <= NOT \resetn~clkctrl_outclk\;

-- Location: LCFF_X55_Y35_N13
\top|bo_map|Rcktimer|currentState[3]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bo_map|Rcktimer|currentState[3]~30_combout\,
	aclr => \top|bc_map|rstcktimer~combout\,
	ena => \top|bc_map|currentState.S0~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bo_map|Rcktimer|currentState\(3));

-- Location: LCFF_X55_Y35_N17
\top|bo_map|Rcktimer|currentState[5]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bo_map|Rcktimer|currentState[5]~34_combout\,
	aclr => \top|bc_map|rstcktimer~combout\,
	ena => \top|bc_map|currentState.S0~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bo_map|Rcktimer|currentState\(5));

-- Location: LCFF_X55_Y35_N21
\top|bo_map|Rcktimer|currentState[7]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bo_map|Rcktimer|currentState[7]~38_combout\,
	aclr => \top|bc_map|rstcktimer~combout\,
	ena => \top|bc_map|currentState.S0~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bo_map|Rcktimer|currentState\(7));

-- Location: LCFF_X55_Y34_N7
\top|bo_map|Rcktimer|currentState[16]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bo_map|Rcktimer|currentState[16]~56_combout\,
	aclr => \top|bc_map|rstcktimer~combout\,
	ena => \top|bc_map|currentState.S0~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bo_map|Rcktimer|currentState\(16));

-- Location: LCFF_X55_Y34_N11
\top|bo_map|Rcktimer|currentState[18]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bo_map|Rcktimer|currentState[18]~60_combout\,
	aclr => \top|bc_map|rstcktimer~combout\,
	ena => \top|bc_map|currentState.S0~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bo_map|Rcktimer|currentState\(18));

-- Location: LCFF_X55_Y34_N17
\top|bo_map|Rcktimer|currentState[21]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bo_map|Rcktimer|currentState[21]~66_combout\,
	aclr => \top|bc_map|rstcktimer~combout\,
	ena => \top|bc_map|currentState.S0~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bo_map|Rcktimer|currentState\(21));

-- Location: LCFF_X55_Y34_N25
\top|bo_map|Rcktimer|currentState[25]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bo_map|Rcktimer|currentState[25]~74_combout\,
	aclr => \top|bc_map|rstcktimer~combout\,
	ena => \top|bc_map|currentState.S0~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bo_map|Rcktimer|currentState\(25));

-- Location: LCFF_X58_Y34_N17
\top|bo_map|Rtime|currentState[2]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bo_map|Rtime|currentState[2]~9_combout\,
	aclr => \top|bc_map|rstcktimer~0_combout\,
	ena => \top|bc_map|currentState.S2~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bo_map|Rtime|currentState\(2));

-- Location: LCCOMB_X55_Y35_N12
\top|bo_map|Rcktimer|currentState[3]~30\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Rcktimer|currentState[3]~30_combout\ = (\top|bo_map|Rcktimer|currentState\(3) & (\top|bo_map|Rcktimer|currentState[2]~29\ $ (GND))) # (!\top|bo_map|Rcktimer|currentState\(3) & (!\top|bo_map|Rcktimer|currentState[2]~29\ & VCC))
-- \top|bo_map|Rcktimer|currentState[3]~31\ = CARRY((\top|bo_map|Rcktimer|currentState\(3) & !\top|bo_map|Rcktimer|currentState[2]~29\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \top|bo_map|Rcktimer|currentState\(3),
	datad => VCC,
	cin => \top|bo_map|Rcktimer|currentState[2]~29\,
	combout => \top|bo_map|Rcktimer|currentState[3]~30_combout\,
	cout => \top|bo_map|Rcktimer|currentState[3]~31\);

-- Location: LCCOMB_X55_Y35_N16
\top|bo_map|Rcktimer|currentState[5]~34\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Rcktimer|currentState[5]~34_combout\ = (\top|bo_map|Rcktimer|currentState\(5) & (\top|bo_map|Rcktimer|currentState[4]~33\ $ (GND))) # (!\top|bo_map|Rcktimer|currentState\(5) & (!\top|bo_map|Rcktimer|currentState[4]~33\ & VCC))
-- \top|bo_map|Rcktimer|currentState[5]~35\ = CARRY((\top|bo_map|Rcktimer|currentState\(5) & !\top|bo_map|Rcktimer|currentState[4]~33\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \top|bo_map|Rcktimer|currentState\(5),
	datad => VCC,
	cin => \top|bo_map|Rcktimer|currentState[4]~33\,
	combout => \top|bo_map|Rcktimer|currentState[5]~34_combout\,
	cout => \top|bo_map|Rcktimer|currentState[5]~35\);

-- Location: LCCOMB_X55_Y35_N20
\top|bo_map|Rcktimer|currentState[7]~38\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Rcktimer|currentState[7]~38_combout\ = (\top|bo_map|Rcktimer|currentState\(7) & (\top|bo_map|Rcktimer|currentState[6]~37\ $ (GND))) # (!\top|bo_map|Rcktimer|currentState\(7) & (!\top|bo_map|Rcktimer|currentState[6]~37\ & VCC))
-- \top|bo_map|Rcktimer|currentState[7]~39\ = CARRY((\top|bo_map|Rcktimer|currentState\(7) & !\top|bo_map|Rcktimer|currentState[6]~37\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \top|bo_map|Rcktimer|currentState\(7),
	datad => VCC,
	cin => \top|bo_map|Rcktimer|currentState[6]~37\,
	combout => \top|bo_map|Rcktimer|currentState[7]~38_combout\,
	cout => \top|bo_map|Rcktimer|currentState[7]~39\);

-- Location: LCCOMB_X55_Y34_N6
\top|bo_map|Rcktimer|currentState[16]~56\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Rcktimer|currentState[16]~56_combout\ = (\top|bo_map|Rcktimer|currentState\(16) & (!\top|bo_map|Rcktimer|currentState[15]~55\)) # (!\top|bo_map|Rcktimer|currentState\(16) & ((\top|bo_map|Rcktimer|currentState[15]~55\) # (GND)))
-- \top|bo_map|Rcktimer|currentState[16]~57\ = CARRY((!\top|bo_map|Rcktimer|currentState[15]~55\) # (!\top|bo_map|Rcktimer|currentState\(16)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \top|bo_map|Rcktimer|currentState\(16),
	datad => VCC,
	cin => \top|bo_map|Rcktimer|currentState[15]~55\,
	combout => \top|bo_map|Rcktimer|currentState[16]~56_combout\,
	cout => \top|bo_map|Rcktimer|currentState[16]~57\);

-- Location: LCCOMB_X55_Y34_N10
\top|bo_map|Rcktimer|currentState[18]~60\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Rcktimer|currentState[18]~60_combout\ = (\top|bo_map|Rcktimer|currentState\(18) & (!\top|bo_map|Rcktimer|currentState[17]~59\)) # (!\top|bo_map|Rcktimer|currentState\(18) & ((\top|bo_map|Rcktimer|currentState[17]~59\) # (GND)))
-- \top|bo_map|Rcktimer|currentState[18]~61\ = CARRY((!\top|bo_map|Rcktimer|currentState[17]~59\) # (!\top|bo_map|Rcktimer|currentState\(18)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \top|bo_map|Rcktimer|currentState\(18),
	datad => VCC,
	cin => \top|bo_map|Rcktimer|currentState[17]~59\,
	combout => \top|bo_map|Rcktimer|currentState[18]~60_combout\,
	cout => \top|bo_map|Rcktimer|currentState[18]~61\);

-- Location: LCCOMB_X55_Y34_N16
\top|bo_map|Rcktimer|currentState[21]~66\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Rcktimer|currentState[21]~66_combout\ = (\top|bo_map|Rcktimer|currentState\(21) & (\top|bo_map|Rcktimer|currentState[20]~65\ $ (GND))) # (!\top|bo_map|Rcktimer|currentState\(21) & (!\top|bo_map|Rcktimer|currentState[20]~65\ & VCC))
-- \top|bo_map|Rcktimer|currentState[21]~67\ = CARRY((\top|bo_map|Rcktimer|currentState\(21) & !\top|bo_map|Rcktimer|currentState[20]~65\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \top|bo_map|Rcktimer|currentState\(21),
	datad => VCC,
	cin => \top|bo_map|Rcktimer|currentState[20]~65\,
	combout => \top|bo_map|Rcktimer|currentState[21]~66_combout\,
	cout => \top|bo_map|Rcktimer|currentState[21]~67\);

-- Location: LCCOMB_X55_Y34_N22
\top|bo_map|Rcktimer|currentState[24]~72\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Rcktimer|currentState[24]~72_combout\ = (\top|bo_map|Rcktimer|currentState\(24) & (!\top|bo_map|Rcktimer|currentState[23]~71\)) # (!\top|bo_map|Rcktimer|currentState\(24) & ((\top|bo_map|Rcktimer|currentState[23]~71\) # (GND)))
-- \top|bo_map|Rcktimer|currentState[24]~73\ = CARRY((!\top|bo_map|Rcktimer|currentState[23]~71\) # (!\top|bo_map|Rcktimer|currentState\(24)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \top|bo_map|Rcktimer|currentState\(24),
	datad => VCC,
	cin => \top|bo_map|Rcktimer|currentState[23]~71\,
	combout => \top|bo_map|Rcktimer|currentState[24]~72_combout\,
	cout => \top|bo_map|Rcktimer|currentState[24]~73\);

-- Location: LCCOMB_X55_Y34_N24
\top|bo_map|Rcktimer|currentState[25]~74\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Rcktimer|currentState[25]~74_combout\ = \top|bo_map|Rcktimer|currentState\(25) $ (!\top|bo_map|Rcktimer|currentState[24]~73\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010110100101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \top|bo_map|Rcktimer|currentState\(25),
	cin => \top|bo_map|Rcktimer|currentState[24]~73\,
	combout => \top|bo_map|Rcktimer|currentState[25]~74_combout\);

-- Location: LCCOMB_X58_Y34_N16
\top|bo_map|Rtime|currentState[2]~9\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Rtime|currentState[2]~9_combout\ = (\top|bo_map|Rtime|currentState\(2) & (!\top|bo_map|Rtime|currentState[1]~8\)) # (!\top|bo_map|Rtime|currentState\(2) & ((\top|bo_map|Rtime|currentState[1]~8\) # (GND)))
-- \top|bo_map|Rtime|currentState[2]~10\ = CARRY((!\top|bo_map|Rtime|currentState[1]~8\) # (!\top|bo_map|Rtime|currentState\(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \top|bo_map|Rtime|currentState\(2),
	datad => VCC,
	cin => \top|bo_map|Rtime|currentState[1]~8\,
	combout => \top|bo_map|Rtime|currentState[2]~9_combout\,
	cout => \top|bo_map|Rtime|currentState[2]~10\);

-- Location: LCCOMB_X55_Y35_N6
\top|bc_map|Selector0~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bc_map|Selector0~1_combout\ = (\top|bo_map|Rcktimer|currentState\(5)) # (((\top|bo_map|Rcktimer|currentState\(4)) # (\top|bo_map|Rcktimer|currentState\(3))) # (!\top|bo_map|Rcktimer|currentState\(6)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \top|bo_map|Rcktimer|currentState\(5),
	datab => \top|bo_map|Rcktimer|currentState\(6),
	datac => \top|bo_map|Rcktimer|currentState\(4),
	datad => \top|bo_map|Rcktimer|currentState\(3),
	combout => \top|bc_map|Selector0~1_combout\);

-- Location: LCCOMB_X55_Y34_N30
\top|bc_map|Selector0~5\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bc_map|Selector0~5_combout\ = ((\top|bo_map|Rcktimer|currentState\(15)) # ((\top|bo_map|Rcktimer|currentState\(17)) # (\top|bo_map|Rcktimer|currentState\(16)))) # (!\top|bo_map|Rcktimer|currentState\(18))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \top|bo_map|Rcktimer|currentState\(18),
	datab => \top|bo_map|Rcktimer|currentState\(15),
	datac => \top|bo_map|Rcktimer|currentState\(17),
	datad => \top|bo_map|Rcktimer|currentState\(16),
	combout => \top|bc_map|Selector0~5_combout\);

-- Location: PIN_P2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\clock~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_clock,
	combout => \clock~combout\);

-- Location: CLKCTRL_G3
\clock~clkctrl\ : cycloneii_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \clock~clkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \clock~clkctrl_outclk\);

-- Location: LCCOMB_X58_Y34_N8
\top|bo_map|Rtime|currentState[0]~21\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Rtime|currentState[0]~21_combout\ = \top|bc_map|currentState.S2~regout\ $ (\top|bo_map|Rtime|currentState\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \top|bc_map|currentState.S2~regout\,
	datac => \top|bo_map|Rtime|currentState\(0),
	combout => \top|bo_map|Rtime|currentState[0]~21_combout\);

-- Location: LCCOMB_X55_Y35_N8
\top|bo_map|Rcktimer|currentState[1]~26\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Rcktimer|currentState[1]~26_combout\ = (\top|bo_map|Rcktimer|currentState\(0) & (\top|bo_map|Rcktimer|currentState\(1) $ (VCC))) # (!\top|bo_map|Rcktimer|currentState\(0) & (\top|bo_map|Rcktimer|currentState\(1) & VCC))
-- \top|bo_map|Rcktimer|currentState[1]~27\ = CARRY((\top|bo_map|Rcktimer|currentState\(0) & \top|bo_map|Rcktimer|currentState\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110011010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \top|bo_map|Rcktimer|currentState\(0),
	datab => \top|bo_map|Rcktimer|currentState\(1),
	datad => VCC,
	combout => \top|bo_map|Rcktimer|currentState[1]~26_combout\,
	cout => \top|bo_map|Rcktimer|currentState[1]~27\);

-- Location: LCCOMB_X56_Y34_N12
\top|bc_map|currentState.init~feeder\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bc_map|currentState.init~feeder_combout\ = VCC

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	combout => \top|bc_map|currentState.init~feeder_combout\);

-- Location: PIN_P1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\resetn~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_resetn,
	combout => \resetn~combout\);

-- Location: CLKCTRL_G1
\resetn~clkctrl\ : cycloneii_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \resetn~clkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \resetn~clkctrl_outclk\);

-- Location: LCFF_X56_Y34_N13
\top|bc_map|currentState.init\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bc_map|currentState.init~feeder_combout\,
	aclr => \ALT_INV_resetn~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bc_map|currentState.init~regout\);

-- Location: LCCOMB_X56_Y34_N28
\top|bc_map|rstcktimer\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bc_map|rstcktimer~combout\ = (\top|bc_map|currentState.S2~regout\) # ((\top|bc_map|currentState.S8~regout\) # (!\top|bc_map|currentState.init~regout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \top|bc_map|currentState.S2~regout\,
	datac => \top|bc_map|currentState.S8~regout\,
	datad => \top|bc_map|currentState.init~regout\,
	combout => \top|bc_map|rstcktimer~combout\);

-- Location: LCFF_X55_Y35_N9
\top|bo_map|Rcktimer|currentState[1]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bo_map|Rcktimer|currentState[1]~26_combout\,
	aclr => \top|bc_map|rstcktimer~combout\,
	ena => \top|bc_map|currentState.S0~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bo_map|Rcktimer|currentState\(1));

-- Location: LCCOMB_X55_Y35_N10
\top|bo_map|Rcktimer|currentState[2]~28\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Rcktimer|currentState[2]~28_combout\ = (\top|bo_map|Rcktimer|currentState\(2) & (!\top|bo_map|Rcktimer|currentState[1]~27\)) # (!\top|bo_map|Rcktimer|currentState\(2) & ((\top|bo_map|Rcktimer|currentState[1]~27\) # (GND)))
-- \top|bo_map|Rcktimer|currentState[2]~29\ = CARRY((!\top|bo_map|Rcktimer|currentState[1]~27\) # (!\top|bo_map|Rcktimer|currentState\(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \top|bo_map|Rcktimer|currentState\(2),
	datad => VCC,
	cin => \top|bo_map|Rcktimer|currentState[1]~27\,
	combout => \top|bo_map|Rcktimer|currentState[2]~28_combout\,
	cout => \top|bo_map|Rcktimer|currentState[2]~29\);

-- Location: LCCOMB_X55_Y35_N14
\top|bo_map|Rcktimer|currentState[4]~32\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Rcktimer|currentState[4]~32_combout\ = (\top|bo_map|Rcktimer|currentState\(4) & (!\top|bo_map|Rcktimer|currentState[3]~31\)) # (!\top|bo_map|Rcktimer|currentState\(4) & ((\top|bo_map|Rcktimer|currentState[3]~31\) # (GND)))
-- \top|bo_map|Rcktimer|currentState[4]~33\ = CARRY((!\top|bo_map|Rcktimer|currentState[3]~31\) # (!\top|bo_map|Rcktimer|currentState\(4)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \top|bo_map|Rcktimer|currentState\(4),
	datad => VCC,
	cin => \top|bo_map|Rcktimer|currentState[3]~31\,
	combout => \top|bo_map|Rcktimer|currentState[4]~32_combout\,
	cout => \top|bo_map|Rcktimer|currentState[4]~33\);

-- Location: LCFF_X55_Y35_N15
\top|bo_map|Rcktimer|currentState[4]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bo_map|Rcktimer|currentState[4]~32_combout\,
	aclr => \top|bc_map|rstcktimer~combout\,
	ena => \top|bc_map|currentState.S0~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bo_map|Rcktimer|currentState\(4));

-- Location: LCCOMB_X55_Y35_N18
\top|bo_map|Rcktimer|currentState[6]~36\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Rcktimer|currentState[6]~36_combout\ = (\top|bo_map|Rcktimer|currentState\(6) & (!\top|bo_map|Rcktimer|currentState[5]~35\)) # (!\top|bo_map|Rcktimer|currentState\(6) & ((\top|bo_map|Rcktimer|currentState[5]~35\) # (GND)))
-- \top|bo_map|Rcktimer|currentState[6]~37\ = CARRY((!\top|bo_map|Rcktimer|currentState[5]~35\) # (!\top|bo_map|Rcktimer|currentState\(6)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \top|bo_map|Rcktimer|currentState\(6),
	datad => VCC,
	cin => \top|bo_map|Rcktimer|currentState[5]~35\,
	combout => \top|bo_map|Rcktimer|currentState[6]~36_combout\,
	cout => \top|bo_map|Rcktimer|currentState[6]~37\);

-- Location: LCFF_X55_Y35_N19
\top|bo_map|Rcktimer|currentState[6]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bo_map|Rcktimer|currentState[6]~36_combout\,
	aclr => \top|bc_map|rstcktimer~combout\,
	ena => \top|bc_map|currentState.S0~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bo_map|Rcktimer|currentState\(6));

-- Location: LCCOMB_X55_Y35_N22
\top|bo_map|Rcktimer|currentState[8]~40\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Rcktimer|currentState[8]~40_combout\ = (\top|bo_map|Rcktimer|currentState\(8) & (!\top|bo_map|Rcktimer|currentState[7]~39\)) # (!\top|bo_map|Rcktimer|currentState\(8) & ((\top|bo_map|Rcktimer|currentState[7]~39\) # (GND)))
-- \top|bo_map|Rcktimer|currentState[8]~41\ = CARRY((!\top|bo_map|Rcktimer|currentState[7]~39\) # (!\top|bo_map|Rcktimer|currentState\(8)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \top|bo_map|Rcktimer|currentState\(8),
	datad => VCC,
	cin => \top|bo_map|Rcktimer|currentState[7]~39\,
	combout => \top|bo_map|Rcktimer|currentState[8]~40_combout\,
	cout => \top|bo_map|Rcktimer|currentState[8]~41\);

-- Location: LCFF_X55_Y35_N23
\top|bo_map|Rcktimer|currentState[8]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bo_map|Rcktimer|currentState[8]~40_combout\,
	aclr => \top|bc_map|rstcktimer~combout\,
	ena => \top|bc_map|currentState.S0~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bo_map|Rcktimer|currentState\(8));

-- Location: LCCOMB_X55_Y35_N24
\top|bo_map|Rcktimer|currentState[9]~42\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Rcktimer|currentState[9]~42_combout\ = (\top|bo_map|Rcktimer|currentState\(9) & (\top|bo_map|Rcktimer|currentState[8]~41\ $ (GND))) # (!\top|bo_map|Rcktimer|currentState\(9) & (!\top|bo_map|Rcktimer|currentState[8]~41\ & VCC))
-- \top|bo_map|Rcktimer|currentState[9]~43\ = CARRY((\top|bo_map|Rcktimer|currentState\(9) & !\top|bo_map|Rcktimer|currentState[8]~41\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \top|bo_map|Rcktimer|currentState\(9),
	datad => VCC,
	cin => \top|bo_map|Rcktimer|currentState[8]~41\,
	combout => \top|bo_map|Rcktimer|currentState[9]~42_combout\,
	cout => \top|bo_map|Rcktimer|currentState[9]~43\);

-- Location: LCCOMB_X55_Y35_N26
\top|bo_map|Rcktimer|currentState[10]~44\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Rcktimer|currentState[10]~44_combout\ = (\top|bo_map|Rcktimer|currentState\(10) & (!\top|bo_map|Rcktimer|currentState[9]~43\)) # (!\top|bo_map|Rcktimer|currentState\(10) & ((\top|bo_map|Rcktimer|currentState[9]~43\) # (GND)))
-- \top|bo_map|Rcktimer|currentState[10]~45\ = CARRY((!\top|bo_map|Rcktimer|currentState[9]~43\) # (!\top|bo_map|Rcktimer|currentState\(10)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \top|bo_map|Rcktimer|currentState\(10),
	datad => VCC,
	cin => \top|bo_map|Rcktimer|currentState[9]~43\,
	combout => \top|bo_map|Rcktimer|currentState[10]~44_combout\,
	cout => \top|bo_map|Rcktimer|currentState[10]~45\);

-- Location: LCFF_X55_Y35_N27
\top|bo_map|Rcktimer|currentState[10]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bo_map|Rcktimer|currentState[10]~44_combout\,
	aclr => \top|bc_map|rstcktimer~combout\,
	ena => \top|bc_map|currentState.S0~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bo_map|Rcktimer|currentState\(10));

-- Location: LCCOMB_X55_Y35_N28
\top|bo_map|Rcktimer|currentState[11]~46\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Rcktimer|currentState[11]~46_combout\ = (\top|bo_map|Rcktimer|currentState\(11) & (\top|bo_map|Rcktimer|currentState[10]~45\ $ (GND))) # (!\top|bo_map|Rcktimer|currentState\(11) & (!\top|bo_map|Rcktimer|currentState[10]~45\ & VCC))
-- \top|bo_map|Rcktimer|currentState[11]~47\ = CARRY((\top|bo_map|Rcktimer|currentState\(11) & !\top|bo_map|Rcktimer|currentState[10]~45\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \top|bo_map|Rcktimer|currentState\(11),
	datad => VCC,
	cin => \top|bo_map|Rcktimer|currentState[10]~45\,
	combout => \top|bo_map|Rcktimer|currentState[11]~46_combout\,
	cout => \top|bo_map|Rcktimer|currentState[11]~47\);

-- Location: LCFF_X55_Y35_N29
\top|bo_map|Rcktimer|currentState[11]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bo_map|Rcktimer|currentState[11]~46_combout\,
	aclr => \top|bc_map|rstcktimer~combout\,
	ena => \top|bc_map|currentState.S0~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bo_map|Rcktimer|currentState\(11));

-- Location: LCCOMB_X55_Y35_N30
\top|bo_map|Rcktimer|currentState[12]~48\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Rcktimer|currentState[12]~48_combout\ = (\top|bo_map|Rcktimer|currentState\(12) & (!\top|bo_map|Rcktimer|currentState[11]~47\)) # (!\top|bo_map|Rcktimer|currentState\(12) & ((\top|bo_map|Rcktimer|currentState[11]~47\) # (GND)))
-- \top|bo_map|Rcktimer|currentState[12]~49\ = CARRY((!\top|bo_map|Rcktimer|currentState[11]~47\) # (!\top|bo_map|Rcktimer|currentState\(12)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \top|bo_map|Rcktimer|currentState\(12),
	datad => VCC,
	cin => \top|bo_map|Rcktimer|currentState[11]~47\,
	combout => \top|bo_map|Rcktimer|currentState[12]~48_combout\,
	cout => \top|bo_map|Rcktimer|currentState[12]~49\);

-- Location: LCFF_X55_Y35_N31
\top|bo_map|Rcktimer|currentState[12]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bo_map|Rcktimer|currentState[12]~48_combout\,
	aclr => \top|bc_map|rstcktimer~combout\,
	ena => \top|bc_map|currentState.S0~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bo_map|Rcktimer|currentState\(12));

-- Location: LCCOMB_X55_Y34_N0
\top|bo_map|Rcktimer|currentState[13]~50\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Rcktimer|currentState[13]~50_combout\ = (\top|bo_map|Rcktimer|currentState\(13) & (\top|bo_map|Rcktimer|currentState[12]~49\ $ (GND))) # (!\top|bo_map|Rcktimer|currentState\(13) & (!\top|bo_map|Rcktimer|currentState[12]~49\ & VCC))
-- \top|bo_map|Rcktimer|currentState[13]~51\ = CARRY((\top|bo_map|Rcktimer|currentState\(13) & !\top|bo_map|Rcktimer|currentState[12]~49\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \top|bo_map|Rcktimer|currentState\(13),
	datad => VCC,
	cin => \top|bo_map|Rcktimer|currentState[12]~49\,
	combout => \top|bo_map|Rcktimer|currentState[13]~50_combout\,
	cout => \top|bo_map|Rcktimer|currentState[13]~51\);

-- Location: LCFF_X55_Y34_N1
\top|bo_map|Rcktimer|currentState[13]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bo_map|Rcktimer|currentState[13]~50_combout\,
	aclr => \top|bc_map|rstcktimer~combout\,
	ena => \top|bc_map|currentState.S0~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bo_map|Rcktimer|currentState\(13));

-- Location: LCCOMB_X55_Y34_N2
\top|bo_map|Rcktimer|currentState[14]~52\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Rcktimer|currentState[14]~52_combout\ = (\top|bo_map|Rcktimer|currentState\(14) & (!\top|bo_map|Rcktimer|currentState[13]~51\)) # (!\top|bo_map|Rcktimer|currentState\(14) & ((\top|bo_map|Rcktimer|currentState[13]~51\) # (GND)))
-- \top|bo_map|Rcktimer|currentState[14]~53\ = CARRY((!\top|bo_map|Rcktimer|currentState[13]~51\) # (!\top|bo_map|Rcktimer|currentState\(14)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \top|bo_map|Rcktimer|currentState\(14),
	datad => VCC,
	cin => \top|bo_map|Rcktimer|currentState[13]~51\,
	combout => \top|bo_map|Rcktimer|currentState[14]~52_combout\,
	cout => \top|bo_map|Rcktimer|currentState[14]~53\);

-- Location: LCFF_X55_Y34_N3
\top|bo_map|Rcktimer|currentState[14]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bo_map|Rcktimer|currentState[14]~52_combout\,
	aclr => \top|bc_map|rstcktimer~combout\,
	ena => \top|bc_map|currentState.S0~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bo_map|Rcktimer|currentState\(14));

-- Location: LCCOMB_X55_Y34_N4
\top|bo_map|Rcktimer|currentState[15]~54\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Rcktimer|currentState[15]~54_combout\ = (\top|bo_map|Rcktimer|currentState\(15) & (\top|bo_map|Rcktimer|currentState[14]~53\ $ (GND))) # (!\top|bo_map|Rcktimer|currentState\(15) & (!\top|bo_map|Rcktimer|currentState[14]~53\ & VCC))
-- \top|bo_map|Rcktimer|currentState[15]~55\ = CARRY((\top|bo_map|Rcktimer|currentState\(15) & !\top|bo_map|Rcktimer|currentState[14]~53\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \top|bo_map|Rcktimer|currentState\(15),
	datad => VCC,
	cin => \top|bo_map|Rcktimer|currentState[14]~53\,
	combout => \top|bo_map|Rcktimer|currentState[15]~54_combout\,
	cout => \top|bo_map|Rcktimer|currentState[15]~55\);

-- Location: LCFF_X55_Y34_N5
\top|bo_map|Rcktimer|currentState[15]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bo_map|Rcktimer|currentState[15]~54_combout\,
	aclr => \top|bc_map|rstcktimer~combout\,
	ena => \top|bc_map|currentState.S0~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bo_map|Rcktimer|currentState\(15));

-- Location: LCCOMB_X55_Y34_N8
\top|bo_map|Rcktimer|currentState[17]~58\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Rcktimer|currentState[17]~58_combout\ = (\top|bo_map|Rcktimer|currentState\(17) & (\top|bo_map|Rcktimer|currentState[16]~57\ $ (GND))) # (!\top|bo_map|Rcktimer|currentState\(17) & (!\top|bo_map|Rcktimer|currentState[16]~57\ & VCC))
-- \top|bo_map|Rcktimer|currentState[17]~59\ = CARRY((\top|bo_map|Rcktimer|currentState\(17) & !\top|bo_map|Rcktimer|currentState[16]~57\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \top|bo_map|Rcktimer|currentState\(17),
	datad => VCC,
	cin => \top|bo_map|Rcktimer|currentState[16]~57\,
	combout => \top|bo_map|Rcktimer|currentState[17]~58_combout\,
	cout => \top|bo_map|Rcktimer|currentState[17]~59\);

-- Location: LCFF_X55_Y34_N9
\top|bo_map|Rcktimer|currentState[17]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bo_map|Rcktimer|currentState[17]~58_combout\,
	aclr => \top|bc_map|rstcktimer~combout\,
	ena => \top|bc_map|currentState.S0~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bo_map|Rcktimer|currentState\(17));

-- Location: LCCOMB_X55_Y34_N12
\top|bo_map|Rcktimer|currentState[19]~62\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Rcktimer|currentState[19]~62_combout\ = (\top|bo_map|Rcktimer|currentState\(19) & (\top|bo_map|Rcktimer|currentState[18]~61\ $ (GND))) # (!\top|bo_map|Rcktimer|currentState\(19) & (!\top|bo_map|Rcktimer|currentState[18]~61\ & VCC))
-- \top|bo_map|Rcktimer|currentState[19]~63\ = CARRY((\top|bo_map|Rcktimer|currentState\(19) & !\top|bo_map|Rcktimer|currentState[18]~61\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \top|bo_map|Rcktimer|currentState\(19),
	datad => VCC,
	cin => \top|bo_map|Rcktimer|currentState[18]~61\,
	combout => \top|bo_map|Rcktimer|currentState[19]~62_combout\,
	cout => \top|bo_map|Rcktimer|currentState[19]~63\);

-- Location: LCCOMB_X55_Y34_N14
\top|bo_map|Rcktimer|currentState[20]~64\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Rcktimer|currentState[20]~64_combout\ = (\top|bo_map|Rcktimer|currentState\(20) & (!\top|bo_map|Rcktimer|currentState[19]~63\)) # (!\top|bo_map|Rcktimer|currentState\(20) & ((\top|bo_map|Rcktimer|currentState[19]~63\) # (GND)))
-- \top|bo_map|Rcktimer|currentState[20]~65\ = CARRY((!\top|bo_map|Rcktimer|currentState[19]~63\) # (!\top|bo_map|Rcktimer|currentState\(20)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \top|bo_map|Rcktimer|currentState\(20),
	datad => VCC,
	cin => \top|bo_map|Rcktimer|currentState[19]~63\,
	combout => \top|bo_map|Rcktimer|currentState[20]~64_combout\,
	cout => \top|bo_map|Rcktimer|currentState[20]~65\);

-- Location: LCFF_X55_Y34_N15
\top|bo_map|Rcktimer|currentState[20]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bo_map|Rcktimer|currentState[20]~64_combout\,
	aclr => \top|bc_map|rstcktimer~combout\,
	ena => \top|bc_map|currentState.S0~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bo_map|Rcktimer|currentState\(20));

-- Location: LCCOMB_X55_Y34_N18
\top|bo_map|Rcktimer|currentState[22]~68\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Rcktimer|currentState[22]~68_combout\ = (\top|bo_map|Rcktimer|currentState\(22) & (!\top|bo_map|Rcktimer|currentState[21]~67\)) # (!\top|bo_map|Rcktimer|currentState\(22) & ((\top|bo_map|Rcktimer|currentState[21]~67\) # (GND)))
-- \top|bo_map|Rcktimer|currentState[22]~69\ = CARRY((!\top|bo_map|Rcktimer|currentState[21]~67\) # (!\top|bo_map|Rcktimer|currentState\(22)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \top|bo_map|Rcktimer|currentState\(22),
	datad => VCC,
	cin => \top|bo_map|Rcktimer|currentState[21]~67\,
	combout => \top|bo_map|Rcktimer|currentState[22]~68_combout\,
	cout => \top|bo_map|Rcktimer|currentState[22]~69\);

-- Location: LCFF_X55_Y34_N19
\top|bo_map|Rcktimer|currentState[22]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bo_map|Rcktimer|currentState[22]~68_combout\,
	aclr => \top|bc_map|rstcktimer~combout\,
	ena => \top|bc_map|currentState.S0~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bo_map|Rcktimer|currentState\(22));

-- Location: LCCOMB_X55_Y34_N20
\top|bo_map|Rcktimer|currentState[23]~70\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Rcktimer|currentState[23]~70_combout\ = (\top|bo_map|Rcktimer|currentState\(23) & (\top|bo_map|Rcktimer|currentState[22]~69\ $ (GND))) # (!\top|bo_map|Rcktimer|currentState\(23) & (!\top|bo_map|Rcktimer|currentState[22]~69\ & VCC))
-- \top|bo_map|Rcktimer|currentState[23]~71\ = CARRY((\top|bo_map|Rcktimer|currentState\(23) & !\top|bo_map|Rcktimer|currentState[22]~69\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \top|bo_map|Rcktimer|currentState\(23),
	datad => VCC,
	cin => \top|bo_map|Rcktimer|currentState[22]~69\,
	combout => \top|bo_map|Rcktimer|currentState[23]~70_combout\,
	cout => \top|bo_map|Rcktimer|currentState[23]~71\);

-- Location: LCFF_X55_Y34_N21
\top|bo_map|Rcktimer|currentState[23]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bo_map|Rcktimer|currentState[23]~70_combout\,
	aclr => \top|bc_map|rstcktimer~combout\,
	ena => \top|bc_map|currentState.S0~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bo_map|Rcktimer|currentState\(23));

-- Location: LCFF_X55_Y34_N23
\top|bo_map|Rcktimer|currentState[24]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bo_map|Rcktimer|currentState[24]~72_combout\,
	aclr => \top|bc_map|rstcktimer~combout\,
	ena => \top|bc_map|currentState.S0~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bo_map|Rcktimer|currentState\(24));

-- Location: LCCOMB_X55_Y34_N26
\top|bc_map|Selector0~7\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bc_map|Selector0~7_combout\ = (\top|bo_map|Rcktimer|currentState\(25)) # ((\top|bo_map|Rcktimer|currentState\(23)) # (\top|bo_map|Rcktimer|currentState\(24)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \top|bo_map|Rcktimer|currentState\(25),
	datac => \top|bo_map|Rcktimer|currentState\(23),
	datad => \top|bo_map|Rcktimer|currentState\(24),
	combout => \top|bc_map|Selector0~7_combout\);

-- Location: LCFF_X55_Y35_N25
\top|bo_map|Rcktimer|currentState[9]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bo_map|Rcktimer|currentState[9]~42_combout\,
	aclr => \top|bc_map|rstcktimer~combout\,
	ena => \top|bc_map|currentState.S0~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bo_map|Rcktimer|currentState\(9));

-- Location: LCCOMB_X55_Y35_N0
\top|bc_map|Selector0~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bc_map|Selector0~2_combout\ = (\top|bo_map|Rcktimer|currentState\(7)) # (((\top|bo_map|Rcktimer|currentState\(10)) # (!\top|bo_map|Rcktimer|currentState\(9))) # (!\top|bo_map|Rcktimer|currentState\(8)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \top|bo_map|Rcktimer|currentState\(7),
	datab => \top|bo_map|Rcktimer|currentState\(8),
	datac => \top|bo_map|Rcktimer|currentState\(9),
	datad => \top|bo_map|Rcktimer|currentState\(10),
	combout => \top|bc_map|Selector0~2_combout\);

-- Location: LCCOMB_X55_Y35_N4
\top|bo_map|Rcktimer|currentState[0]~25\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Rcktimer|currentState[0]~25_combout\ = \top|bo_map|Rcktimer|currentState\(0) $ (\top|bc_map|currentState.S0~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \top|bo_map|Rcktimer|currentState\(0),
	datad => \top|bc_map|currentState.S0~regout\,
	combout => \top|bo_map|Rcktimer|currentState[0]~25_combout\);

-- Location: LCFF_X55_Y35_N5
\top|bo_map|Rcktimer|currentState[0]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bo_map|Rcktimer|currentState[0]~25_combout\,
	aclr => \top|bc_map|rstcktimer~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bo_map|Rcktimer|currentState\(0));

-- Location: LCFF_X55_Y35_N11
\top|bo_map|Rcktimer|currentState[2]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bo_map|Rcktimer|currentState[2]~28_combout\,
	aclr => \top|bc_map|rstcktimer~combout\,
	ena => \top|bc_map|currentState.S0~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bo_map|Rcktimer|currentState\(2));

-- Location: LCCOMB_X56_Y34_N20
\top|bc_map|Selector0~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bc_map|Selector0~0_combout\ = ((\top|bo_map|Rcktimer|currentState\(0)) # ((\top|bo_map|Rcktimer|currentState\(2)) # (\top|bo_map|Rcktimer|currentState\(1)))) # (!\top|bc_map|currentState.S0~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \top|bc_map|currentState.S0~regout\,
	datab => \top|bo_map|Rcktimer|currentState\(0),
	datac => \top|bo_map|Rcktimer|currentState\(2),
	datad => \top|bo_map|Rcktimer|currentState\(1),
	combout => \top|bc_map|Selector0~0_combout\);

-- Location: LCCOMB_X56_Y34_N18
\top|bc_map|Selector0~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bc_map|Selector0~3_combout\ = (\top|bo_map|Rcktimer|currentState\(12)) # (((\top|bo_map|Rcktimer|currentState\(13)) # (!\top|bo_map|Rcktimer|currentState\(11))) # (!\top|bo_map|Rcktimer|currentState\(14)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \top|bo_map|Rcktimer|currentState\(12),
	datab => \top|bo_map|Rcktimer|currentState\(14),
	datac => \top|bo_map|Rcktimer|currentState\(13),
	datad => \top|bo_map|Rcktimer|currentState\(11),
	combout => \top|bc_map|Selector0~3_combout\);

-- Location: LCCOMB_X56_Y34_N8
\top|bc_map|Selector0~4\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bc_map|Selector0~4_combout\ = (\top|bc_map|Selector0~1_combout\) # ((\top|bc_map|Selector0~2_combout\) # ((\top|bc_map|Selector0~0_combout\) # (\top|bc_map|Selector0~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \top|bc_map|Selector0~1_combout\,
	datab => \top|bc_map|Selector0~2_combout\,
	datac => \top|bc_map|Selector0~0_combout\,
	datad => \top|bc_map|Selector0~3_combout\,
	combout => \top|bc_map|Selector0~4_combout\);

-- Location: LCFF_X55_Y34_N13
\top|bo_map|Rcktimer|currentState[19]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bo_map|Rcktimer|currentState[19]~62_combout\,
	aclr => \top|bc_map|rstcktimer~combout\,
	ena => \top|bc_map|currentState.S0~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bo_map|Rcktimer|currentState\(19));

-- Location: LCCOMB_X55_Y34_N28
\top|bc_map|Selector0~6\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bc_map|Selector0~6_combout\ = (\top|bo_map|Rcktimer|currentState\(21)) # (((\top|bo_map|Rcktimer|currentState\(20)) # (!\top|bo_map|Rcktimer|currentState\(19))) # (!\top|bo_map|Rcktimer|currentState\(22)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \top|bo_map|Rcktimer|currentState\(21),
	datab => \top|bo_map|Rcktimer|currentState\(22),
	datac => \top|bo_map|Rcktimer|currentState\(20),
	datad => \top|bo_map|Rcktimer|currentState\(19),
	combout => \top|bc_map|Selector0~6_combout\);

-- Location: LCCOMB_X56_Y34_N30
\top|bc_map|Selector0~8\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bc_map|Selector0~8_combout\ = (!\top|bc_map|Selector0~5_combout\ & (!\top|bc_map|Selector0~7_combout\ & (!\top|bc_map|Selector0~4_combout\ & !\top|bc_map|Selector0~6_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \top|bc_map|Selector0~5_combout\,
	datab => \top|bc_map|Selector0~7_combout\,
	datac => \top|bc_map|Selector0~4_combout\,
	datad => \top|bc_map|Selector0~6_combout\,
	combout => \top|bc_map|Selector0~8_combout\);

-- Location: LCFF_X56_Y34_N17
\top|bc_map|currentState.S2\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	sdata => \top|bc_map|Selector0~8_combout\,
	aclr => \ALT_INV_resetn~clkctrl_outclk\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bc_map|currentState.S2~regout\);

-- Location: LCCOMB_X58_Y34_N20
\top|bo_map|Rtime|currentState[4]~13\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Rtime|currentState[4]~13_combout\ = (\top|bo_map|Rtime|currentState\(4) & (!\top|bo_map|Rtime|currentState[3]~12\)) # (!\top|bo_map|Rtime|currentState\(4) & ((\top|bo_map|Rtime|currentState[3]~12\) # (GND)))
-- \top|bo_map|Rtime|currentState[4]~14\ = CARRY((!\top|bo_map|Rtime|currentState[3]~12\) # (!\top|bo_map|Rtime|currentState\(4)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \top|bo_map|Rtime|currentState\(4),
	datad => VCC,
	cin => \top|bo_map|Rtime|currentState[3]~12\,
	combout => \top|bo_map|Rtime|currentState[4]~13_combout\,
	cout => \top|bo_map|Rtime|currentState[4]~14\);

-- Location: LCFF_X58_Y34_N21
\top|bo_map|Rtime|currentState[4]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bo_map|Rtime|currentState[4]~13_combout\,
	aclr => \top|bc_map|rstcktimer~0_combout\,
	ena => \top|bc_map|currentState.S2~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bo_map|Rtime|currentState\(4));

-- Location: LCCOMB_X58_Y34_N2
\top|bo_map|Cs140|Equal0~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Cs140|Equal0~0_combout\ = (\top|bo_map|Rtime|currentState\(2) & (!\top|bo_map|Rtime|currentState\(0) & (!\top|bo_map|Rtime|currentState\(4) & \top|bo_map|Rtime|currentState\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \top|bo_map|Rtime|currentState\(2),
	datab => \top|bo_map|Rtime|currentState\(0),
	datac => \top|bo_map|Rtime|currentState\(4),
	datad => \top|bo_map|Rtime|currentState\(3),
	combout => \top|bo_map|Cs140|Equal0~0_combout\);

-- Location: LCCOMB_X56_Y34_N14
\top|bc_map|nextState.S8~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bc_map|nextState.S8~0_combout\ = (\top|bo_map|Cs140|Equal0~1_combout\ & (\top|bc_map|currentState.S2~regout\ & \top|bo_map|Cs140|Equal0~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \top|bo_map|Cs140|Equal0~1_combout\,
	datac => \top|bc_map|currentState.S2~regout\,
	datad => \top|bo_map|Cs140|Equal0~0_combout\,
	combout => \top|bc_map|nextState.S8~0_combout\);

-- Location: LCFF_X56_Y34_N15
\top|bc_map|currentState.S8\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bc_map|nextState.S8~0_combout\,
	aclr => \ALT_INV_resetn~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bc_map|currentState.S8~regout\);

-- Location: LCCOMB_X57_Y34_N18
\top|bc_map|rstcktimer~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bc_map|rstcktimer~0_combout\ = (\top|bc_map|currentState.S8~regout\) # (!\top|bc_map|currentState.init~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111101010101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \top|bc_map|currentState.init~regout\,
	datad => \top|bc_map|currentState.S8~regout\,
	combout => \top|bc_map|rstcktimer~0_combout\);

-- Location: LCFF_X58_Y34_N9
\top|bo_map|Rtime|currentState[0]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bo_map|Rtime|currentState[0]~21_combout\,
	aclr => \top|bc_map|rstcktimer~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bo_map|Rtime|currentState\(0));

-- Location: LCCOMB_X58_Y34_N14
\top|bo_map|Rtime|currentState[1]~7\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Rtime|currentState[1]~7_combout\ = (\top|bo_map|Rtime|currentState\(1) & (\top|bo_map|Rtime|currentState\(0) $ (VCC))) # (!\top|bo_map|Rtime|currentState\(1) & (\top|bo_map|Rtime|currentState\(0) & VCC))
-- \top|bo_map|Rtime|currentState[1]~8\ = CARRY((\top|bo_map|Rtime|currentState\(1) & \top|bo_map|Rtime|currentState\(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110011010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \top|bo_map|Rtime|currentState\(1),
	datab => \top|bo_map|Rtime|currentState\(0),
	datad => VCC,
	combout => \top|bo_map|Rtime|currentState[1]~7_combout\,
	cout => \top|bo_map|Rtime|currentState[1]~8\);

-- Location: LCCOMB_X58_Y34_N18
\top|bo_map|Rtime|currentState[3]~11\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Rtime|currentState[3]~11_combout\ = (\top|bo_map|Rtime|currentState\(3) & (\top|bo_map|Rtime|currentState[2]~10\ $ (GND))) # (!\top|bo_map|Rtime|currentState\(3) & (!\top|bo_map|Rtime|currentState[2]~10\ & VCC))
-- \top|bo_map|Rtime|currentState[3]~12\ = CARRY((\top|bo_map|Rtime|currentState\(3) & !\top|bo_map|Rtime|currentState[2]~10\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \top|bo_map|Rtime|currentState\(3),
	datad => VCC,
	cin => \top|bo_map|Rtime|currentState[2]~10\,
	combout => \top|bo_map|Rtime|currentState[3]~11_combout\,
	cout => \top|bo_map|Rtime|currentState[3]~12\);

-- Location: LCFF_X58_Y34_N19
\top|bo_map|Rtime|currentState[3]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bo_map|Rtime|currentState[3]~11_combout\,
	aclr => \top|bc_map|rstcktimer~0_combout\,
	ena => \top|bc_map|currentState.S2~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bo_map|Rtime|currentState\(3));

-- Location: LCCOMB_X58_Y34_N22
\top|bo_map|Rtime|currentState[5]~15\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Rtime|currentState[5]~15_combout\ = (\top|bo_map|Rtime|currentState\(5) & (\top|bo_map|Rtime|currentState[4]~14\ $ (GND))) # (!\top|bo_map|Rtime|currentState\(5) & (!\top|bo_map|Rtime|currentState[4]~14\ & VCC))
-- \top|bo_map|Rtime|currentState[5]~16\ = CARRY((\top|bo_map|Rtime|currentState\(5) & !\top|bo_map|Rtime|currentState[4]~14\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \top|bo_map|Rtime|currentState\(5),
	datad => VCC,
	cin => \top|bo_map|Rtime|currentState[4]~14\,
	combout => \top|bo_map|Rtime|currentState[5]~15_combout\,
	cout => \top|bo_map|Rtime|currentState[5]~16\);

-- Location: LCFF_X58_Y34_N23
\top|bo_map|Rtime|currentState[5]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bo_map|Rtime|currentState[5]~15_combout\,
	aclr => \top|bc_map|rstcktimer~0_combout\,
	ena => \top|bc_map|currentState.S2~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bo_map|Rtime|currentState\(5));

-- Location: LCCOMB_X58_Y34_N24
\top|bo_map|Rtime|currentState[6]~17\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Rtime|currentState[6]~17_combout\ = (\top|bo_map|Rtime|currentState\(6) & (!\top|bo_map|Rtime|currentState[5]~16\)) # (!\top|bo_map|Rtime|currentState\(6) & ((\top|bo_map|Rtime|currentState[5]~16\) # (GND)))
-- \top|bo_map|Rtime|currentState[6]~18\ = CARRY((!\top|bo_map|Rtime|currentState[5]~16\) # (!\top|bo_map|Rtime|currentState\(6)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \top|bo_map|Rtime|currentState\(6),
	datad => VCC,
	cin => \top|bo_map|Rtime|currentState[5]~16\,
	combout => \top|bo_map|Rtime|currentState[6]~17_combout\,
	cout => \top|bo_map|Rtime|currentState[6]~18\);

-- Location: LCFF_X58_Y34_N25
\top|bo_map|Rtime|currentState[6]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bo_map|Rtime|currentState[6]~17_combout\,
	aclr => \top|bc_map|rstcktimer~0_combout\,
	ena => \top|bc_map|currentState.S2~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bo_map|Rtime|currentState\(6));

-- Location: LCCOMB_X58_Y34_N26
\top|bo_map|Rtime|currentState[7]~19\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Rtime|currentState[7]~19_combout\ = \top|bo_map|Rtime|currentState[6]~18\ $ (!\top|bo_map|Rtime|currentState\(7))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000001111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datad => \top|bo_map|Rtime|currentState\(7),
	cin => \top|bo_map|Rtime|currentState[6]~18\,
	combout => \top|bo_map|Rtime|currentState[7]~19_combout\);

-- Location: LCFF_X58_Y34_N27
\top|bo_map|Rtime|currentState[7]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bo_map|Rtime|currentState[7]~19_combout\,
	aclr => \top|bc_map|rstcktimer~0_combout\,
	ena => \top|bc_map|currentState.S2~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bo_map|Rtime|currentState\(7));

-- Location: LCCOMB_X58_Y34_N28
\top|bo_map|Cs140|Equal0~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Cs140|Equal0~1_combout\ = (!\top|bo_map|Rtime|currentState\(1) & (!\top|bo_map|Rtime|currentState\(5) & (!\top|bo_map|Rtime|currentState\(6) & \top|bo_map|Rtime|currentState\(7))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \top|bo_map|Rtime|currentState\(1),
	datab => \top|bo_map|Rtime|currentState\(5),
	datac => \top|bo_map|Rtime|currentState\(6),
	datad => \top|bo_map|Rtime|currentState\(7),
	combout => \top|bo_map|Cs140|Equal0~1_combout\);

-- Location: LCCOMB_X58_Y34_N12
\top|bo_map|Cs55|Equal0~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Cs55|Equal0~0_combout\ = (\top|bo_map|Rtime|currentState\(2) & (\top|bo_map|Rtime|currentState\(0) & (!\top|bo_map|Rtime|currentState\(6) & !\top|bo_map|Rtime|currentState\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \top|bo_map|Rtime|currentState\(2),
	datab => \top|bo_map|Rtime|currentState\(0),
	datac => \top|bo_map|Rtime|currentState\(6),
	datad => \top|bo_map|Rtime|currentState\(3),
	combout => \top|bo_map|Cs55|Equal0~0_combout\);

-- Location: LCCOMB_X57_Y34_N28
\top|bo_map|Cs100|Equal0~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Cs100|Equal0~0_combout\ = (!\top|bo_map|Rtime|currentState\(7) & \top|bo_map|Rtime|currentState\(5))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \top|bo_map|Rtime|currentState\(7),
	datad => \top|bo_map|Rtime|currentState\(5),
	combout => \top|bo_map|Cs100|Equal0~0_combout\);

-- Location: LCCOMB_X57_Y34_N4
\top|bo_map|Cs55|Equal0~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Cs55|Equal0~1_combout\ = (\top|bo_map|Rtime|currentState\(1) & (\top|bo_map|Rtime|currentState\(4) & (\top|bo_map|Cs55|Equal0~0_combout\ & \top|bo_map|Cs100|Equal0~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \top|bo_map|Rtime|currentState\(1),
	datab => \top|bo_map|Rtime|currentState\(4),
	datac => \top|bo_map|Cs55|Equal0~0_combout\,
	datad => \top|bo_map|Cs100|Equal0~0_combout\,
	combout => \top|bo_map|Cs55|Equal0~1_combout\);

-- Location: LCFF_X58_Y34_N15
\top|bo_map|Rtime|currentState[1]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bo_map|Rtime|currentState[1]~7_combout\,
	aclr => \top|bc_map|rstcktimer~0_combout\,
	ena => \top|bc_map|currentState.S2~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bo_map|Rtime|currentState\(1));

-- Location: LCCOMB_X57_Y34_N30
\top|bo_map|Cs110|Equal0~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Cs110|Equal0~0_combout\ = (\top|bo_map|Cs140|Equal0~0_combout\ & (\top|bo_map|Rtime|currentState\(6) & (\top|bo_map|Rtime|currentState\(1) & \top|bo_map|Cs100|Equal0~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \top|bo_map|Cs140|Equal0~0_combout\,
	datab => \top|bo_map|Rtime|currentState\(6),
	datac => \top|bo_map|Rtime|currentState\(1),
	datad => \top|bo_map|Cs100|Equal0~0_combout\,
	combout => \top|bo_map|Cs110|Equal0~0_combout\);

-- Location: LCCOMB_X57_Y34_N0
\top|bc_map|Selector0~10\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bc_map|Selector0~10_combout\ = (!\top|bo_map|Cs55|Equal0~1_combout\ & (!\top|bo_map|Cs110|Equal0~0_combout\ & ((!\top|bo_map|Cs140|Equal0~1_combout\) # (!\top|bo_map|Cs140|Equal0~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \top|bo_map|Cs140|Equal0~0_combout\,
	datab => \top|bo_map|Cs140|Equal0~1_combout\,
	datac => \top|bo_map|Cs55|Equal0~1_combout\,
	datad => \top|bo_map|Cs110|Equal0~0_combout\,
	combout => \top|bc_map|Selector0~10_combout\);

-- Location: LCCOMB_X58_Y34_N30
\top|bo_map|Cs45|Equal0~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Cs45|Equal0~1_combout\ = (\top|bo_map|Rtime|currentState\(2) & (\top|bo_map|Rtime|currentState\(0) & !\top|bo_map|Rtime|currentState\(6)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100000001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \top|bo_map|Rtime|currentState\(2),
	datab => \top|bo_map|Rtime|currentState\(0),
	datac => \top|bo_map|Rtime|currentState\(6),
	combout => \top|bo_map|Cs45|Equal0~1_combout\);

-- Location: LCCOMB_X57_Y34_N20
\top|bo_map|Cs45|Equal0~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Cs45|Equal0~0_combout\ = (\top|bo_map|Rtime|currentState\(3) & (!\top|bo_map|Rtime|currentState\(4) & (!\top|bo_map|Rtime|currentState\(1) & \top|bo_map|Cs100|Equal0~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \top|bo_map|Rtime|currentState\(3),
	datab => \top|bo_map|Rtime|currentState\(4),
	datac => \top|bo_map|Rtime|currentState\(1),
	datad => \top|bo_map|Cs100|Equal0~0_combout\,
	combout => \top|bo_map|Cs45|Equal0~0_combout\);

-- Location: LCCOMB_X58_Y34_N10
\top|bc_map|NSL~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bc_map|NSL~1_combout\ = (\top|bo_map|Rtime|currentState\(6) & (!\top|bo_map|Rtime|currentState\(2) & (\top|bo_map|Rtime|currentState\(0) & !\top|bo_map|Rtime|currentState\(4)))) # (!\top|bo_map|Rtime|currentState\(6) & 
-- (\top|bo_map|Rtime|currentState\(2) $ (((\top|bo_map|Rtime|currentState\(4))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010001011010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \top|bo_map|Rtime|currentState\(2),
	datab => \top|bo_map|Rtime|currentState\(0),
	datac => \top|bo_map|Rtime|currentState\(4),
	datad => \top|bo_map|Rtime|currentState\(6),
	combout => \top|bc_map|NSL~1_combout\);

-- Location: LCCOMB_X58_Y34_N4
\top|bc_map|NSL~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bc_map|NSL~0_combout\ = (\top|bo_map|Rtime|currentState\(2) & (!\top|bo_map|Rtime|currentState\(5) & (\top|bo_map|Rtime|currentState\(0) & \top|bo_map|Rtime|currentState\(7)))) # (!\top|bo_map|Rtime|currentState\(2) & 
-- (\top|bo_map|Rtime|currentState\(5) & (!\top|bo_map|Rtime|currentState\(0) & !\top|bo_map|Rtime|currentState\(7))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \top|bo_map|Rtime|currentState\(2),
	datab => \top|bo_map|Rtime|currentState\(5),
	datac => \top|bo_map|Rtime|currentState\(0),
	datad => \top|bo_map|Rtime|currentState\(7),
	combout => \top|bc_map|NSL~0_combout\);

-- Location: LCCOMB_X57_Y34_N26
\top|bc_map|NSL~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bc_map|NSL~2_combout\ = (\top|bo_map|Rtime|currentState\(3) & (\top|bo_map|Rtime|currentState\(6) & (!\top|bo_map|Rtime|currentState\(1)))) # (!\top|bo_map|Rtime|currentState\(3) & (((\top|bo_map|Rtime|currentState\(1) & 
-- \top|bc_map|NSL~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101100000001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \top|bo_map|Rtime|currentState\(3),
	datab => \top|bo_map|Rtime|currentState\(6),
	datac => \top|bo_map|Rtime|currentState\(1),
	datad => \top|bc_map|NSL~0_combout\,
	combout => \top|bc_map|NSL~2_combout\);

-- Location: LCCOMB_X57_Y34_N22
\top|bc_map|NSL~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bc_map|NSL~3_combout\ = (\top|bc_map|NSL~1_combout\ & (\top|bc_map|NSL~2_combout\ & ((\top|bc_map|NSL~0_combout\) # (\top|bo_map|Cs100|Equal0~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \top|bc_map|NSL~0_combout\,
	datab => \top|bo_map|Cs100|Equal0~0_combout\,
	datac => \top|bc_map|NSL~1_combout\,
	datad => \top|bc_map|NSL~2_combout\,
	combout => \top|bc_map|NSL~3_combout\);

-- Location: LCCOMB_X57_Y34_N24
\top|bc_map|Selector0~9\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bc_map|Selector0~9_combout\ = (!\top|bo_map|Cs100|Equal0~2_combout\ & (!\top|bc_map|NSL~3_combout\ & ((!\top|bo_map|Cs45|Equal0~0_combout\) # (!\top|bo_map|Cs45|Equal0~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000010101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \top|bo_map|Cs100|Equal0~2_combout\,
	datab => \top|bo_map|Cs45|Equal0~1_combout\,
	datac => \top|bo_map|Cs45|Equal0~0_combout\,
	datad => \top|bc_map|NSL~3_combout\,
	combout => \top|bc_map|Selector0~9_combout\);

-- Location: LCCOMB_X57_Y34_N14
\top|bc_map|Selector0~11\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bc_map|Selector0~11_combout\ = (!\top|bc_map|Selector0~8_combout\ & (((\top|bc_map|Selector0~10_combout\ & \top|bc_map|Selector0~9_combout\)) # (!\top|bc_map|currentState.S2~regout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110100000101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \top|bc_map|currentState.S2~regout\,
	datab => \top|bc_map|Selector0~10_combout\,
	datac => \top|bc_map|Selector0~8_combout\,
	datad => \top|bc_map|Selector0~9_combout\,
	combout => \top|bc_map|Selector0~11_combout\);

-- Location: LCFF_X57_Y34_N15
\top|bc_map|currentState.S0\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bc_map|Selector0~11_combout\,
	aclr => \ALT_INV_resetn~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bc_map|currentState.S0~regout\);

-- Location: LCCOMB_X56_Y34_N16
\top|bc_map|cMuxP~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bc_map|cMuxP~0_combout\ = (\top|bc_map|currentState.S7~regout\) # ((\top|bc_map|currentState.S0~regout\) # (\top|bc_map|currentState.S2~regout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111011111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \top|bc_map|currentState.S7~regout\,
	datab => \top|bc_map|currentState.S0~regout\,
	datac => \top|bc_map|currentState.S2~regout\,
	combout => \top|bc_map|cMuxP~0_combout\);

-- Location: LCCOMB_X56_Y34_N4
\top|bo_map|RP|currentState[0]~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|RP|currentState[0]~0_combout\ = !\top|bc_map|cMuxP~0_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \top|bc_map|cMuxP~0_combout\,
	combout => \top|bo_map|RP|currentState[0]~0_combout\);

-- Location: LCCOMB_X57_Y34_N10
\top|bc_map|nextState.S4~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bc_map|nextState.S4~0_combout\ = (\top|bc_map|currentState.S2~regout\ & \top|bc_map|NSL~3_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \top|bc_map|currentState.S2~regout\,
	datad => \top|bc_map|NSL~3_combout\,
	combout => \top|bc_map|nextState.S4~0_combout\);

-- Location: LCFF_X57_Y34_N11
\top|bc_map|currentState.S4\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bc_map|nextState.S4~0_combout\,
	aclr => \ALT_INV_resetn~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bc_map|currentState.S4~regout\);

-- Location: LCCOMB_X56_Y34_N6
\top|bc_map|nextState.S7~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bc_map|nextState.S7~0_combout\ = (\top|bo_map|Cs110|Equal0~0_combout\ & \top|bc_map|currentState.S2~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \top|bo_map|Cs110|Equal0~0_combout\,
	datad => \top|bc_map|currentState.S2~regout\,
	combout => \top|bc_map|nextState.S7~0_combout\);

-- Location: LCFF_X56_Y34_N7
\top|bc_map|currentState.S7\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bc_map|nextState.S7~0_combout\,
	aclr => \ALT_INV_resetn~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bc_map|currentState.S7~regout\);

-- Location: LCCOMB_X56_Y34_N10
\top|bc_map|eP~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bc_map|eP~0_combout\ = ((\top|bc_map|currentState.S4~regout\) # (\top|bc_map|currentState.S7~regout\)) # (!\top|bc_map|currentState.init~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111011101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \top|bc_map|currentState.init~regout\,
	datab => \top|bc_map|currentState.S4~regout\,
	datad => \top|bc_map|currentState.S7~regout\,
	combout => \top|bc_map|eP~0_combout\);

-- Location: LCFF_X56_Y34_N5
\top|bo_map|RP|currentState[0]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bo_map|RP|currentState[0]~0_combout\,
	aclr => \ALT_INV_resetn~clkctrl_outclk\,
	ena => \top|bc_map|eP~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bo_map|RP|currentState\(0));

-- Location: LCFF_X56_Y34_N11
\top|bo_map|RP|currentState[1]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	sdata => \top|bc_map|cMuxP~0_combout\,
	aclr => \ALT_INV_resetn~clkctrl_outclk\,
	sload => VCC,
	ena => \top|bc_map|eP~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bo_map|RP|currentState\(1));

-- Location: LCCOMB_X58_Y34_N0
\top|bo_map|Cs100|Equal0~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Cs100|Equal0~1_combout\ = (\top|bo_map|Rtime|currentState\(2) & (!\top|bo_map|Rtime|currentState\(0) & (\top|bo_map|Rtime|currentState\(6) & !\top|bo_map|Rtime|currentState\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \top|bo_map|Rtime|currentState\(2),
	datab => \top|bo_map|Rtime|currentState\(0),
	datac => \top|bo_map|Rtime|currentState\(6),
	datad => \top|bo_map|Rtime|currentState\(3),
	combout => \top|bo_map|Cs100|Equal0~1_combout\);

-- Location: LCCOMB_X57_Y34_N12
\top|bo_map|Cs100|Equal0~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|Cs100|Equal0~2_combout\ = (!\top|bo_map|Rtime|currentState\(1) & (!\top|bo_map|Rtime|currentState\(4) & (\top|bo_map|Cs100|Equal0~1_combout\ & \top|bo_map|Cs100|Equal0~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \top|bo_map|Rtime|currentState\(1),
	datab => \top|bo_map|Rtime|currentState\(4),
	datac => \top|bo_map|Cs100|Equal0~1_combout\,
	datad => \top|bo_map|Cs100|Equal0~0_combout\,
	combout => \top|bo_map|Cs100|Equal0~2_combout\);

-- Location: LCCOMB_X56_Y34_N24
\top|bc_map|nextState.S6~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bc_map|nextState.S6~0_combout\ = (\top|bo_map|Cs100|Equal0~2_combout\ & \top|bc_map|currentState.S2~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \top|bo_map|Cs100|Equal0~2_combout\,
	datad => \top|bc_map|currentState.S2~regout\,
	combout => \top|bc_map|nextState.S6~0_combout\);

-- Location: LCFF_X56_Y34_N25
\top|bc_map|currentState.S6\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bc_map|nextState.S6~0_combout\,
	aclr => \ALT_INV_resetn~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bc_map|currentState.S6~regout\);

-- Location: LCCOMB_X57_Y34_N6
\top|bc_map|nextState.S3~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bc_map|nextState.S3~0_combout\ = (\top|bc_map|currentState.S2~regout\ & (\top|bo_map|Cs45|Equal0~0_combout\ & \top|bo_map|Cs45|Equal0~1_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \top|bc_map|currentState.S2~regout\,
	datac => \top|bo_map|Cs45|Equal0~0_combout\,
	datad => \top|bo_map|Cs45|Equal0~1_combout\,
	combout => \top|bc_map|nextState.S3~0_combout\);

-- Location: LCFF_X57_Y34_N7
\top|bc_map|currentState.S3\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bc_map|nextState.S3~0_combout\,
	aclr => \ALT_INV_resetn~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bc_map|currentState.S3~regout\);

-- Location: LCCOMB_X57_Y34_N8
\top|bc_map|eNS~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bc_map|eNS~0_combout\ = (\top|bc_map|currentState.S8~regout\) # ((\top|bc_map|currentState.S4~regout\) # ((\top|bc_map|currentState.S3~regout\) # (!\top|bc_map|currentState.init~regout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \top|bc_map|currentState.S8~regout\,
	datab => \top|bc_map|currentState.S4~regout\,
	datac => \top|bc_map|currentState.S3~regout\,
	datad => \top|bc_map|currentState.init~regout\,
	combout => \top|bc_map|eNS~0_combout\);

-- Location: LCCOMB_X54_Y34_N12
\top|bo_map|MEW|Equal2~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|MEW|Equal2~0_combout\ = (!\top|bc_map|currentState.S6~regout\ & ((\top|bc_map|currentState.S7~regout\) # (\top|bc_map|eNS~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001100110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \top|bc_map|currentState.S6~regout\,
	datac => \top|bc_map|currentState.S7~regout\,
	datad => \top|bc_map|eNS~0_combout\,
	combout => \top|bo_map|MEW|Equal2~0_combout\);

-- Location: LCCOMB_X56_Y34_N22
\top|bc_map|nextState.S5~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bc_map|nextState.S5~0_combout\ = (\top|bo_map|Cs55|Equal0~1_combout\ & \top|bc_map|currentState.S2~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \top|bo_map|Cs55|Equal0~1_combout\,
	datad => \top|bc_map|currentState.S2~regout\,
	combout => \top|bc_map|nextState.S5~0_combout\);

-- Location: LCFF_X56_Y34_N23
\top|bc_map|currentState.S5\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bc_map|nextState.S5~0_combout\,
	aclr => \ALT_INV_resetn~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bc_map|currentState.S5~regout\);

-- Location: LCCOMB_X56_Y34_N0
\top|bc_map|eEW\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bc_map|eEW~combout\ = (\top|bc_map|currentState.S6~regout\) # ((\top|bc_map|currentState.S5~regout\) # ((\top|bc_map|currentState.S4~regout\) # (!\top|bc_map|currentState.init~regout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \top|bc_map|currentState.S6~regout\,
	datab => \top|bc_map|currentState.S5~regout\,
	datac => \top|bc_map|currentState.S4~regout\,
	datad => \top|bc_map|currentState.init~regout\,
	combout => \top|bc_map|eEW~combout\);

-- Location: LCFF_X54_Y34_N13
\top|bo_map|REW|currentState[0]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bo_map|MEW|Equal2~0_combout\,
	aclr => \ALT_INV_resetn~clkctrl_outclk\,
	ena => \top|bc_map|eEW~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bo_map|REW|currentState\(0));

-- Location: LCCOMB_X54_Y34_N6
\top|bo_map|REW|currentState[1]~feeder\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|REW|currentState[1]~feeder_combout\ = \top|bc_map|currentState.S6~regout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \top|bc_map|currentState.S6~regout\,
	combout => \top|bo_map|REW|currentState[1]~feeder_combout\);

-- Location: LCFF_X54_Y34_N7
\top|bo_map|REW|currentState[1]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bo_map|REW|currentState[1]~feeder_combout\,
	aclr => \ALT_INV_resetn~clkctrl_outclk\,
	ena => \top|bc_map|eEW~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bo_map|REW|currentState\(1));

-- Location: LCCOMB_X54_Y34_N4
\top|bo_map|MEW|Equal2~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|MEW|Equal2~1_combout\ = (!\top|bc_map|currentState.S6~regout\ & (!\top|bc_map|currentState.S7~regout\ & !\top|bc_map|eNS~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \top|bc_map|currentState.S6~regout\,
	datac => \top|bc_map|currentState.S7~regout\,
	datad => \top|bc_map|eNS~0_combout\,
	combout => \top|bo_map|MEW|Equal2~1_combout\);

-- Location: LCFF_X54_Y34_N5
\top|bo_map|REW|currentState[2]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bo_map|MEW|Equal2~1_combout\,
	aclr => \ALT_INV_resetn~clkctrl_outclk\,
	ena => \top|bc_map|eEW~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bo_map|REW|currentState\(2));

-- Location: LCCOMB_X56_Y34_N26
\top|bo_map|MNS|Equal2~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|MNS|Equal2~0_combout\ = (!\top|bc_map|currentState.S7~regout\ & (!\top|bc_map|currentState.S4~regout\ & (!\top|bc_map|currentState.S6~regout\ & !\top|bc_map|currentState.S5~regout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \top|bc_map|currentState.S7~regout\,
	datab => \top|bc_map|currentState.S4~regout\,
	datac => \top|bc_map|currentState.S6~regout\,
	datad => \top|bc_map|currentState.S5~regout\,
	combout => \top|bo_map|MNS|Equal2~0_combout\);

-- Location: LCCOMB_X57_Y34_N2
\top|bo_map|MNS|Equal2~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|MNS|Equal2~1_combout\ = (!\top|bc_map|currentState.S3~regout\ & !\top|bo_map|MNS|Equal2~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \top|bc_map|currentState.S3~regout\,
	datad => \top|bo_map|MNS|Equal2~0_combout\,
	combout => \top|bo_map|MNS|Equal2~1_combout\);

-- Location: LCFF_X57_Y34_N3
\top|bo_map|RNS|currentState[0]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bo_map|MNS|Equal2~1_combout\,
	aclr => \ALT_INV_resetn~clkctrl_outclk\,
	ena => \top|bc_map|eNS~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bo_map|RNS|currentState\(0));

-- Location: LCFF_X57_Y34_N9
\top|bo_map|RNS|currentState[1]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	sdata => \top|bc_map|currentState.S3~regout\,
	aclr => \ALT_INV_resetn~clkctrl_outclk\,
	sload => VCC,
	ena => \top|bc_map|eNS~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bo_map|RNS|currentState\(1));

-- Location: LCCOMB_X57_Y34_N16
\top|bo_map|MNS|Equal2~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \top|bo_map|MNS|Equal2~2_combout\ = (!\top|bc_map|currentState.S3~regout\ & \top|bo_map|MNS|Equal2~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \top|bc_map|currentState.S3~regout\,
	datad => \top|bo_map|MNS|Equal2~0_combout\,
	combout => \top|bo_map|MNS|Equal2~2_combout\);

-- Location: LCFF_X57_Y34_N17
\top|bo_map|RNS|currentState[2]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \top|bo_map|MNS|Equal2~2_combout\,
	aclr => \ALT_INV_resetn~clkctrl_outclk\,
	ena => \top|bc_map|eNS~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \top|bo_map|RNS|currentState\(2));

-- Location: PIN_B20,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\readdata[0]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \top|bo_map|RP|currentState\(0),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_readdata(0));

-- Location: PIN_E20,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\readdata[1]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \top|bo_map|RP|currentState\(1),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_readdata(1));

-- Location: PIN_C19,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\readdata[2]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \top|bo_map|REW|currentState\(0),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_readdata(2));

-- Location: PIN_B19,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\readdata[3]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \top|bo_map|REW|currentState\(1),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_readdata(3));

-- Location: PIN_D19,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\readdata[4]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \top|bo_map|REW|currentState\(2),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_readdata(4));

-- Location: PIN_K16,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\readdata[5]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \top|bo_map|RNS|currentState\(0),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_readdata(5));

-- Location: PIN_D20,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\readdata[6]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \top|bo_map|RNS|currentState\(1),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_readdata(6));

-- Location: PIN_J16,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\readdata[7]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \top|bo_map|RNS|currentState\(2),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_readdata(7));
END structure;


