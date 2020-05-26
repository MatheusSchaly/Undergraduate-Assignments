transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/HsMatheus/Desktop/Sistema_de_Um_Semáforo_Para_Controle_de_Um_Cruzamento_-_Alan_Djon_Ludke_e_Matheus_Henrique_Schaly/VHDL/traffic_light_top.vhd}
vcom -93 -work work {C:/Users/HsMatheus/Desktop/Sistema_de_Um_Semáforo_Para_Controle_de_Um_Cruzamento_-_Alan_Djon_Ludke_e_Matheus_Henrique_Schaly/VHDL/adder_n_bits.vhd}
vcom -93 -work work {C:/Users/HsMatheus/Desktop/Sistema_de_Um_Semáforo_Para_Controle_de_Um_Cruzamento_-_Alan_Djon_Ludke_e_Matheus_Henrique_Schaly/VHDL/BC.vhd}
vcom -93 -work work {C:/Users/HsMatheus/Desktop/Sistema_de_Um_Semáforo_Para_Controle_de_Um_Cruzamento_-_Alan_Djon_Ludke_e_Matheus_Henrique_Schaly/VHDL/register_n_bits.vhd}
vcom -93 -work work {C:/Users/HsMatheus/Desktop/Sistema_de_Um_Semáforo_Para_Controle_de_Um_Cruzamento_-_Alan_Djon_Ludke_e_Matheus_Henrique_Schaly/VHDL/compareIfEqual_n_bits.vhd}
vcom -93 -work work {C:/Users/HsMatheus/Desktop/Sistema_de_Um_Semáforo_Para_Controle_de_Um_Cruzamento_-_Alan_Djon_Ludke_e_Matheus_Henrique_Schaly/VHDL/BO.vhd}
vcom -93 -work work {C:/Users/HsMatheus/Desktop/Sistema_de_Um_Semáforo_Para_Controle_de_Um_Cruzamento_-_Alan_Djon_Ludke_e_Matheus_Henrique_Schaly/VHDL/mux2x1_n_bits.vhd}
vcom -93 -work work {C:/Users/HsMatheus/Desktop/Sistema_de_Um_Semáforo_Para_Controle_de_Um_Cruzamento_-_Alan_Djon_Ludke_e_Matheus_Henrique_Schaly/VHDL/mux4x1_n_bits.vhd}

