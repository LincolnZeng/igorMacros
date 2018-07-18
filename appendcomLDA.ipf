#pragma rtGlobals=1		// Use modern global access method.
#pragma rtGlobals=1		// Use modern global access method.



function appendcomLDA(wavefrom,wavefrom2,wavefrom3,wavefrom4,wavefrom5,wavefrom6,wavefrom7,waveto,offset2,offset3,offset4)

variable wavefrom,wavefrom2,wavefrom3,wavefrom4,wavefrom5,wavefrom6,wavefrom7,waveto,offset2,offset3,offset4
string namewave,namewaveweight,namewavey,namewaveyy,namewaveyyy,namewaveyyyy,namewaveyyyyy,namewaveyyyyyy,namewaveyyyyyyy
string wavex_1,wavex_2,wavex_3,wavex_4,wavex_5,wavex_6,wavex_7
string wavey1,wavex2,wavey3,wavey4,wavey5,wavey6,wavey7

variable p

      wavex_1="wave"+num2str(wavefrom)
      duplicate/o $wavex_1,plotx1
 
      wavex_2="wave"+num2str(wavefrom2)
      duplicate/o $wavex_2,plotx2
      plotx2*=-1//cause have to change XM to MX
      plotx2+=offset2+offset3    
      
      
     wavex_3="wave"+num2str(wavefrom3)
      duplicate/o $wavex_3,plotx3
      plotx3*=-1
      plotx3+=offset3*2+offset2
      
       wavex_4="wave"+num2str(wavefrom4)
      duplicate/o $wavex_4,plotx4
      plotx4+=offset3*2+offset2
      
      wavex_5="wave"+num2str(wavefrom5)
      duplicate/o $wavex_5,plotx5
      plotx5+=offset3*2+offset2+offset4
      
      wavex_6="wave"+num2str(wavefrom6)
      duplicate/o $wavex_6,plotx6
      plotx6*=-1// change XM to MX
      plotx6+=offset3*3+2*offset2+offset4
      
       wavex_7="wave"+num2str(wavefrom7)
      duplicate/o $wavex_7,plotx7
      plotx7*=-1//change XG to GX
      plotx7+=offset3*4+2*offset2+offset4
      
 for(p=wavefrom;p<wavefrom2;p+=3)
     // namewavex1="wave"+num2str(p)
      namewavey="wave"+num2str(p+1)
      appendtograph $namewavey vs plotx1
      //print namewavey
 endfor
// print "GM"
  for(p=wavefrom2;p<wavefrom3;p+=3)
     // namewavex2="wave"+num2str(p)
      namewaveyy="wave"+num2str(p+1)
      appendtograph $namewaveyy vs plotx2
      //print namewavey,plotx2
 endfor
 //print "MX"
   for(p=wavefrom3;p<wavefrom4;p+=3)
     // namewavex2="wave"+num2str(p)
      namewaveyyy="wave"+num2str(p+1)
      appendtograph $namewaveyyy vs plotx3
     // print namewaveyyy,plotx3
 endfor
 //print "XG"
  for(p=wavefrom4;p<wavefrom5;p+=3)
     // namewavex2="wave"+num2str(p)
      namewaveyyyy="wave"+num2str(p+1)
      appendtograph $namewaveyyyy vs plotx4
      //print namewaveyyyy,plotx4
 endfor
 //print "GZ"
  for(p=wavefrom5;p<wavefrom6;p+=3)
     // namewavex2="wave"+num2str(p)
      namewaveyyyyy="wave"+num2str(p+1)
      appendtograph $namewaveyyyyy vs plotx5
      //print namewaveyyyyy,plotx5
 endfor
 //print "ZA"
  for(p=wavefrom6;p<wavefrom7;p+=3)
     // namewavex2="wave"+num2str(p)
      namewaveyyyyyy="wave"+num2str(p+1)
      appendtograph $namewaveyyyyyy vs plotx6
      //print namewaveyyyyyy,plotx6
 endfor
 //print "AR"
  for(p=wavefrom7;p<waveto;p+=3)
     //namewavex2="wave"+num2str(p)
      namewaveyyyyyyy="wave"+num2str(p+1)
      appendtograph $namewaveyyyyyyy vs plotx7
      //print namewaveyyyyyyy,plotx7
 endfor
 //print "RZ"
 print plotx1[dimsize(plotx1,0)]
  print plotx2[dimsize(plotx2,0)]
   print plotx3[dimsize(plotx3,0)]
    print plotx4[dimsize(plotx4,0)]
     print plotx5[dimsize(plotx5,0)]
      print plotx6[dimsize(plotx6,0)]
       print plotx7[dimsize(plotx7,0)]
 
 SetAxis left -1.5,0.2
variable i,n,m
wave wavechange
for(i=wavefrom;i<waveto;i+=3)
namewave="wave"+num2str(i+1)
namewaveweight="wave"+num2str(i+2)
m=1
duplicate/o $namewaveweight,wavechange
for(n=0;n<dimsize(wavechange,0);n=n+1)
if( wavechange[n]==0.07)
m+=1
endif
if(m==dimsize(wavechange,0))
wavechange[0]+=0.001
endif
endfor
duplicate/o wavechange, $namewaveweight
ModifyGraph mode($namewave)=3,marker($namewaveweight)=19;DelayUpdate
ModifyGraph zmrkSize($namewave)={$namewaveweight,*,*,1,10};DelayUpdate
ModifyGraph zColor($namewave)={$namewaveweight,*,*,YellowHot,1}
endfor 
ModifyGraph marker=19
ModifyGraph mirror=2,fSize=14,font="Times"
ModifyGraph nticks(bottom)=0
end
