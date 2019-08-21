//+------------------------------------------------------------------+
//|                                                        Bears.mq4 |
//|                   Copyright 2005-2014, MetaQuotes Software Corp. |
//|                                              http://www.mql4.com |
//+------------------------------------------------------------------+
#property copyright   "2005-2014, MetaQuotes Software Corp."
#property link        "http://www.mql4.com"
#property description "Bears Power"
#property strict

//--- indicator settings
#property indicator_separate_window
#property indicator_buffers 1
#property indicator_color1 Red
#property indicator_color2 DarkGreen
//--- input parameter
input int InPeriod=3; // Bears Period
//--- buffers
double ExtBuffer1[];
double ExtBuffer2[];
int lowofSome;
int highofSome;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
void OnInit(void)
  {
   string short_name;
//--- 1 additional buffer used for counting.
   IndicatorBuffers(2);
   IndicatorDigits(Digits);
//--- indicator line
   SetIndexStyle(1,DRAW_HISTOGRAM,0,3);
   SetIndexBuffer(1,ExtBuffer1);
   SetIndexStyle(0,DRAW_HISTOGRAM,0,3);
   SetIndexBuffer(0,ExtBuffer2);
//--- name for DataWindow and indicator subwindow label
   short_name="day_trend("+IntegerToString(InPeriod)+")";
   IndicatorShortName(short_name);
   SetIndexLabel(1,short_name);
   SetIndexLabel(2,short_name);
     }

//+------------------------------------------------------------------+
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

bool ChangeDay (int ultima)
   {
   static datetime lastbar=0;
   datetime curbar = Time[ultima];
   if ( TimeDay(lastbar) != TimeDay(curbar))
   {
      lastbar=curbar;
      return (true);
   }
   else
   {
      return(false);
   }
}

int start()
{
   int counted_bars = IndicatorCounted();

   int limit=Bars-counted_bars-1000;
   //mio
   //int i;
   int numdia=1;
   datetime previotime;
   //if (TimeDayOfWeek( Time[0])== 1) numdia++;
   previotime= Time[0];
   for(int i=0; i<limit; i++) {
   
      if (NewBar(i)==true){
         if (i>=1 && ChangeDay(i) != true)
            {
            ExtBuffer1[i]= ExtBuffer1[i-1];
            ExtBuffer2[i]= ExtBuffer2[i-1];
            
            }
         else
            {      
            lowofSome =iLowest(NULL,1440,MODE_CLOSE,InPeriod,numdia+1);
            highofSome =iHighest(NULL,1440,MODE_CLOSE,InPeriod,numdia+1); 
            if ((iClose(NULL,1440,numdia)) >= (iOpen(NULL,1440,numdia)))
               {
               if (iClose (NULL,1440,numdia) < iClose (NULL,1440,highofSome) )
           //if (iLow(NULL,1440,numdia) <= (iClose(NULL,1440,()) || iClose(NULL,1440,numdia) < iClose(NULL,1440, highofSome)
               { // lateral
                  ExtBuffer1[i]= 0;
                 
                  }
               else 
                  {
                  ExtBuffer1[i]=2;
                  }
               }
            else
               {
               if (iClose(NULL,1440,numdia) >= iClose(NULL,1440,lowofSome))
                   { // lateral
                  ExtBuffer2[i]=0;
                  }
               else ExtBuffer2[i] = 2;
               }
               
           if (TimeDay(Time[i])!= TimeDay(previotime))
               {
               numdia++;
               //para saltarnos el domingo noche/
               
               }
            previotime = Time[i];
            }
      }
   //ExtBuffer[i] = 1;   
   //ExtTempBuffer[i]= ExtBuffer[i];      
   }

   return (0);
}