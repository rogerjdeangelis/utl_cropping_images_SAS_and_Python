Very fast cropping of images. SAS and Python.

original image
https://www.dropbox.com/s/gnibifew71allbl/utl_crop.png?dl=0

cropped image
https://www.dropbox.com/s/j4z3bvdw91x645i/utl_cropped.png?dl=0

also on github

  WORKING CODE (This is it)

    img = Image.open("d:/png/utl_crop.png");
    img2 = img.crop((300,300,700,700));
    img2.save("d:/png/utl_cropped.png");

see
http://matthiaseisen.com/pp/patterns/p0202/



HAVE (PNG output and we want to crop out the axes)
====================================================

   d:/png/utl_crop.png

   ** IMPORTANT - the origin for cropping is  (x=0,y=1)


   Y |    ___   ___
 1.0 +-> / _ \ / _ \
     |  | (_) | (_) |  ** (x=0,y=1)  is the orgin for cropping
     |   \___( )___/
     |       |/
     |
     |                  ***
     |               **     **
     |             ***        **
     |            **           **
     |            **            *
 0.5 +A           *             *
     |            *             *
     |             *           **
     |              **        **
     |               **     **
     |                  ***
     |
     |
     |
     |
     |
     |
 0.0 +
     -+-----------------+------------------+
     0.0               0.5               1.0

                       X
WANT
====

   d:/png/utl_croped.png



           ***
        **     **
      ***        **
     **           **
     **            *
     *             *
     *             *
      *           **
       **        **
        **     **
           ***


*                _                 _       _
 _ __ ___   __ _| | _____    _ __ | | ___ | |_
| '_ ` _ \ / _` | |/ / _ \  | '_ \| |/ _ \| __|
| | | | | | (_| |   <  __/  | |_) | | (_) | |_
|_| |_| |_|\__,_|_|\_\___|  | .__/|_|\___/ \__|
                            |_|
;

works;
data have;
  x=.6;
  y=.6;
  z=.25;
run;quit;


%utlfkil(d:/png/utl_crop.png);
ods graphics on / reset=all imagename="utl_crop" imagefmt=png width=1000px height=1000px;
ods listing gpath="d:/png";
  proc sgplot data=have noautolegend aspect=1;
  bubble x=x y=y size=z / bradiusmin=100px bradiusmax=101px
         dataskin=gloss nooutline;
  scatter x=x y=y ;
  xaxis min=0 max=1 offsetmin=0 display=(nolabel noticks noline novalues) grid;
  yaxis min=0 max=1 offsetmin=0 display=(nolabel noticks noline novalues) grid;
  run;quit;
ods listing close;
ods graphics off;

*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

;

%utlfkil(d:/png/cropped.png);
%utl_submit_py64('
    from PIL import Image;
    img = Image.open("d:/png/utl_crop.png");
    img2 = img.crop((300,300,700,700));
    img2.save("d:/png/utl_cropped.png");
');

Note

* keep in mind that the plot is 1000px by 1000px witha aspect 1

   x1  y1
  300,300 is measured down and over from the top left of the graphic in pixels

   x2  y2
  700,700 down 700 from top then over 700




