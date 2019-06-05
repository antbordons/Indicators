//+------------------------------------------------------------------+
//|                                                 Pivot Points.mq4 |
//|                                                          Akuma99 |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Antonio Bordons"
#property link      ""

#property indicator_chart_window
#property indicator_buffers 7
#property indicator_color1 DarkGreen
#property indicator_color2 Red
#property indicator_color3 Blue
#property indicator_color4 Gray
#property indicator_color5 Yellow
#property indicator_color6 Green
#property indicator_color7 Red

double PivotBuffer0[]; //r3
double PivotBuffer1[]; //r2
double PivotBuffer2[]; //r1
double PivotBuffer3[]; //p
double PivotBuffer4[]; //s1
double PivotBuffer5[]; //s2
double PivotBuffer6[]; //s3

int init() {

   /*SetIndexStyle(0,DRAW_LINE, 0, 1);
   SetIndexBuffer(0,PivotBuffer0);
   SetIndexEmptyValue(0,0.0);
   SetIndexLabel(0,"Resistance 3");*/
   SetIndexStyle(1,DRAW_LINE, 0, 1);
   SetIndexBuffer(1,PivotBuffer1);
   SetIndexEmptyValue(1,0.0);
   SetIndexLabel(1,"Resistance 2");
   SetIndexStyle(2,DRAW_LINE, 0, 1);
   SetIndexBuffer(2,PivotBuffer2);
   SetIndexEmptyValue(2,0.0);
   SetIndexLabel(2,"Resistance 1");
   SetIndexStyle(3,DRAW_LINE, 0, 1);
   SetIndexBuffer(3,PivotBuffer3);
   SetIndexEmptyValue(3,0.0);
   SetIndexLabel(3,"Pivot");
   SetIndexStyle(4,DRAW_LINE, 0, 1);
   SetIndexBuffer(4,PivotBuffer4);
   SetIndexEmptyValue(4,0.0);
   SetIndexLabel(4,"Support 1");
   SetIndexStyle(5,DRAW_LINE, 0, 1);
   SetIndexBuffer(5,PivotBuffer5);
   SetIndexEmptyValue(5,0.0);
   SetIndexLabel(5,"Support 2");
   /*SetIndexStyle(6,DRAW_LINE, 0, 1);
   SetIndexBuffer(6,PivotBuffer6);
   SetIndexEmptyValue(6,0.0);
   SetIndexLabel(6,"Support 3");*/
   return(0);

}
bool NewBar(int ultima)
{
   static datetime lastbar = 0;
   datetime curbar = Time[ultima];
   if(lastbar!=curbar)
   {
      lastbar=curbar;
      return (true);
   }
   else
   {
      return(false);
   }
}
   
   
int start() {
   
   int counted_bars = IndicatorCounted();
   double yHigh, yLow, yClose, p, r3, r2, r1, s3, s2, s1;
   int limit=Bars-counted_bars;
   //mio
   //int i;
   int numdia=1;
   datetime previotime;
   //if (TimeDayOfWeek( Time[0])== 1) numdia++;
   previotime= Time[0];
   for(int i=0; i<limit; i++) {
   
      if (NewBar(i)==true){
      
         yHigh = iHigh(NULL, PERIOD_D1, numdia);
         yLow = iLow(NULL, PERIOD_D1, numdia);
         yClose = iClose(NULL, PERIOD_D1, numdia);
   
         p = (yHigh+yLow+yClose)/3;
         r1 = 2*p-yLow;
         s1 = 2*p-yHigh; 
         s2 = p-(r1-s1);
         r2 = p+(r1-s1);
         s3 = 2*p - (2 * yHigh - yLow);
         r3 = 2*p + (yHigh - 2 * yLow);

   
         if (TimeDay(Time[i])!= TimeDay(previotime))
            {
            numdia++;
            //para saltarnos el domingo noche/
            
            }
         previotime = Time[i];
         PivotBuffer0[i-1] = r3;
         PivotBuffer1[i-1] = r2;
         PivotBuffer2[i-1] = r1;
         PivotBuffer3[i-1] = p;
         PivotBuffer4[i-1] = s1;
         PivotBuffer5[i-1] = s2;
         PivotBuffer6[i-1] = s3;
      
         }
     }
        
   
   
   
   return(0);

}


