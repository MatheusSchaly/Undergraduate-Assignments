# -*- coding: utf-8 -*-
"""
Created on Sat Aug 25 18:26:06 2018

Traffic Light 2
"""

def Traffic_Light_VHDL(clock, reset, mnt, init_helper):
    
    # Helpers sao apenas para ajudar a descrever o codigo, eles nao seriam implementados em VHDL
    if init_helper:
        # mnt = "S0" # Nao considerando mnt
        cur_state = "S1"
        next_state = "S2"
        sec_40 = 40
        sec_25 = 25
        sec_5 = 5
        count = sec_40
        lights = [1,0,0,0,0,1,0,1] # State 1
        init_helper = False
        count_loops_helper = 0
        show_lights_helper = ["G", "Y", "R", "G", "Y", "R", "G", "R"]
        
    
    while (True):
        
        print(str(count_loops_helper) + ": ", end = "")
        for i in range(len(lights)):
            if lights[i] == 1:
                print(show_lights_helper[i], end = "")
        print()
        
        # O codigo entre as linas 34 e 91 seriam mais similar (possivelmente) ao codigo em VHDL
        while (True):
            if reset == 1:
                cur_state = "S1"
                next_state = "S2"
                count = sec_40
                break
            # if mnt == 1:
             #   cur_state = "S0"
             #   next_state = "S1"
             #   count = -1
             #   break
            if count == sec_5: # 5 Seconds have passed
                # Checks if the current_state is a 5 seconds state
                if (cur_state == "S2") or (cur_state == "S3") or (cur_state == "S5") or (cur_state == "S6") or (cur_state == "S8"):     
                    cur_state = next_state
                    break # Leave the second while loop
                
            elif count == sec_25: # 25 Seconds have passed
                # Checks if the current_state is a 25 seconds state
                if (cur_state == "S7"):
                    cur_state = next_state
                    break # Leave the second while loop
            
            elif count == sec_40: # 40 Seconds have passed
                # Checks if the current_state is a 40 seconds state
                if (cur_state == "S1") or (cur_state == "S4"):
                    cur_state = next_state
                    break # Leave the second while loop
            count -= 1


        if cur_state == "S1":
            lights = [1,0,0,0,0,1,0,1] # G R R
            next_state = "S2"
            count = sec_40
        elif cur_state == "S2":
            lights = [0,1,0,0,0,1,0,1] # Y R R
            next_state = "S3"
            count = sec_5
        elif cur_state == "S3":
            lights = [0,0,1,0,0,1,0,1] # R R R
            next_state = "S4"
            count = sec_5
        elif cur_state == "S4":
            lights = [0,0,1,1,0,0,0,1] # R G R
            next_state = "S5"
            count = sec_40
        elif cur_state == "S5":
            lights = [0,0,1,0,1,0,0,1] # R Y R
            next_state = "S6"
            count = sec_5
        elif cur_state == "S6":
            lights = [0,0,1,0,0,1,0,1] # R R R
            next_state = "S7"
            count = sec_5
        elif cur_state == "S7":
            lights = [0,0,1,0,0,1,1,0] # R R G
            next_state = "S8"
            count = sec_25
        elif cur_state == "S8":
            lights = [0,0,1,0,0,1,0,1] # R R R
            next_state = "S1"
            count = sec_5
        
        count_loops_helper += 1
        if count_loops_helper > 20:
            break # Para nao ficar em loop infinito
        
Traffic_Light_VHDL(0, 0, 0, True) # Chama a funcao