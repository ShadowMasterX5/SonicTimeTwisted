// Control method: classic smartphone touchscreen controls
if(smartphone_controls_enabled)
{
    input_method_smartphone_common();
    pressingGamepad = -1;
    // jump button
    if(!objScreen.paused)
    {
        var input_state = 0;
        joyx = dpadx;
        joyy = dpady;
        current_dpadx = dpadx;
        current_dpady = dpady;
        // gyroscope
        input_state |= script_execute(input_gyro_script);
        for(var device = 0; device <= 4; device++)
        {
            if(device_mouse_check_button(device, mb_any))
            {
                var dpx = device_mouse_x_to_gui(device);
                var dpy = device_mouse_y_to_gui(device);
                
                // jump button
                if(point_in_circle(device_mouse_x_to_gui(device), device_mouse_y_to_gui(device),
                    bax, bay, bar
                ))
                {
                    input_state |= cC;
                }
                
                // dpad
                var p_distance = point_distance(dpadx, dpady, dpx, dpy);
                if(p_distance > 2 && p_distance <= bar * 2)
                {
                    var d_direction = point_direction(dpadx, dpady, dpx, dpy);
                    var d_radians = degtorad(d_direction);
                    joyx = current_dpadx;
                    joyy = dpy;
                    // draw the joystick under the thumb, but dont'd draw it completely outside of the base
                    if(!point_in_circle(joyx, joyy, dpadx, dpady, bar))
                    {
                        joyx = dpadx;
                        joyy = dpady - sin(d_radians) * bar;
                    }
                    if(p_distance > used_deadzone)
                    {
                        if(d_direction <= 180)
                        {
                            input_state |= cUP;
                        }
                        else
                        {
                            input_state |= cDOWN;
                        }
                    }
                }

                // Pressing Start overrides everything else
                if(point_in_rectangle(device_mouse_x_to_gui(device), device_mouse_y_to_gui(device),
                    bsx, bsy, bsx + 24, bsy + 24
                ))
                {
                    input_state = cSTART;
                    break;
                }
            }
        }
        objProgram.inputManager.state |= input_state;
    }
}
