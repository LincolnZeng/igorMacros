#pragma rtGlobals=3		// Use modern global access method and strict wave access.
function plot3D()

variable i
wave plot
wave wave0
duplicate/o wave0 ttemp


for(i=0;i<1500;i+=1)
duplicate/o $("wave"+num2str(3*i+2)) ttemp
plot[][i]=ttemp[p]
endfor

end