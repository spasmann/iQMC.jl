
function reeds_data(Nx=1000)
    sigt = zeros(Nx)
    sigs = zeros(Nx)
    source = zeros(Nx)
    xspan = LinRange(-8.0,8.0,Nx)
    count = 1
    for x in xspan
        """
        if (x<2.0)
            sigt[count] = 50.0
            sigs[count] = 0.0
            source[count] = 50.0
        elseif (2.0<= x <= 3.0)
            sigt[count] = 5.0
            sigs[count] = 0.0
            source[count] = 0.0
        elseif (3.0<= x <= 5.0)
            sigt[count] = 0.0#1e-16
            sigs[count] = 0.0#1e-16
            source[count] = 0.0#1e-16
        elseif (5.0<= x <= 6.0)
            sigt[count] = 1.0
            sigs[count] = 0.9
            source[count] = 1.0
        else
            sigt[count] = 1.0
            sigs[count] = 0.9
            source[count] = 0.0
        end
        """
        if (x < -6.0)
            sigt[count] = 1.0
            sigs[count] = 0.9
            source[count] = 0.0
        elseif (-6.0 <= x < -5.0)
            sigt[count] = 1.0
            sigs[count] = 0.9
            source[count] = 1.0
        elseif (-5.0 <= x < -3.0)
            sigt[count] = 0.0#1e-16
            sigs[count] = 0.0#1e-16
            source[count] = 0.0#1e-16
        elseif (-3.0 <= x < -2.0)
            sigt[count] = 5.0
            sigs[count] = 0.0
            source[count] = 0.0
        elseif (-2.0 <= x < 2.0)
            sigt[count] = 50.0
            sigs[count] = 0.0
            source[count] = 50.0
        elseif (2.0 <= x < 3.0)
            sigt[count] = 5.0
            sigs[count] = 0.0
            source[count] = 0.0
        elseif (3.0<= x < 5.0)
            sigt[count] = 0.0#1e-16
            sigs[count] = 0.0#1e-16
            source[count] = 0.0#1e-16
        elseif (5.0<= x < 6.0)
            sigt[count] = 1.0
            sigs[count] = 0.9
            source[count] = 1.0
        elseif (6.0<= x)
            sigt[count] = 1.0
            sigs[count] = 0.9
            source[count] = 0.0
        end
        count += 1
    end
    siga = (sigt .- sigs)
    return sigt, sigs, siga, source
end

#sigt,sigs,siga,source = reeds_data()
