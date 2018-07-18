#pragma rtGlobals=1		// Use modern global access method.



function appendLDA(wavefrom,waveto,firstwave4x,firstwave4y,firstwave4weight,center,period)

variable wavefrom,waveto,firstwave4x,firstwave4y,firstwave4weight,center,period
string namewavex,namewavey,namewaveweight,namewave_weight
string namewave_x,namewave_y//namewave_weight
namewavex="wave"+num2str(firstwave4x)
duplicate/o $namewavex,plotx
plotx-=center
duplicate/o plotx,plot_x// 1
duplicate/o plotx,plotxx// 2 
duplicate/o plotx,plot_xx// 3
//duplicate/o plotx,plot_xxx//offset
plot_x*=-1//negative x
print plot_x,plotx
plotxx-=2*period
plot_xx=plot_x+2*period
//plot_xxx=plot_x+offset
namewavey="wave"+num2str(firstwave4y)
duplicate/o $namewavey,ploty
namewaveweight="wave"+num2str(firstwave4weight)
duplicate/o $namewaveweight,plotweight
//appendtograph ploty vs plotx
//appendtograph ploty vs plot_x
//ModifyGraph zmrkSize(plotx)={namewave[plotweight],*,*,1,10}
variable i,p
 //for(i=wavefrom;i<(waveto+1)/3;i+=1)
 for(p=wavefrom;p<waveto+1;p+=3)
 
   //namewaveweight="wave"+num2str(firstwave4weight+p)
    namewave_y="wave"+num2str(p+firstwave4y)
    duplicate/o $namewave_y,ploty
   // namewave_weight="wave"+num2str(p+firstwave4weight)
    //print namewave_weight
    //duplicate/o $namewave_weight,plotweight
       appendtograph $namewave_y vs plot_x
      appendtograph $namewave_y vs plotx
      appendtograph $namewave_y vs plotxx
      appendtograph $namewave_y vs plot_xx//offset
          //ModifyGraph zmrkSize(namewave_y)={namewave_weight,*,*,1,10}
          //ModifyGraph zColor(namewave_y)={namewave_weight,*,*,YellowHot,0}
  
   print namewave_y,namewave_weight
 endfor
end