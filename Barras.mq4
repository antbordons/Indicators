//+------------------------------------------------------------------+
//|                                                        Bands.mq4 |
//|                      Copyright © 2005, MetaQuotes Software Corp. |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2005, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net/"

#property indicator_chart_window
#property indicator_buffers 3
#property indicator_color1 LightSeaGreen
#property indicator_color2 LightSeaGreen
#property indicator_color3 LightSeaGreen
//---- indicator parameters
//---- buffers
double MovingBuffer[];
double UpperBuffer[];
double LowerBuffer[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
//---- indicators
/*   SetIndexStyle(0,DRAW_LINE);
   SetIndexBuffer(0,MovingBuffer);
   SetIndexStyle(1,DRAW_LINE);
   SetIndexBuffer(1,UpperBuffer);
   SetIndexStyle(2,DRAW_LINE);
   SetIndexBuffer(2,LowerBuffer);
//----
   SetIndexDrawBegin(0,valSMA);
   SetIndexDrawBegin(1,valSMA);
   SetIndexDrawBegin(2,valSMA);
//----
   */
   return(0);
  }
  
int deinit()
   {
   if(ObjectFind("Barras") == 0)
      {
      ObjectDelete(0,"Barras");
      }   
   }
//+------------------------------------------------------------------+
//| Starc Bands                                                  |
//+------------------------------------------------------------------+
int start()
  {
   //int    i,k,counted_bars=IndicatorCounted();
   //double deviation;
   //double sum,oldval,newres;
//----
   if(ObjectFind("Barras") == 0)
      {
      ObjectDelete(0,"Barras");
      }
   ObjectCreate(0,"Barras", OBJ_LABEL, 0, 0, 0);
   ObjectSet("Barras", OBJPROP_CORNER, 0);
   ObjectSet("Barras", OBJPROP_XDISTANCE, 20);
   ObjectSet("Barras", OBJPROP_YDISTANCE, 20);                  
   ObjectSetText("Barras", Bars, 9, "Verdana", Yellow); 

/*   if(Bars<=valSMA) return(0);
//---- initial zero
   if(counted_bars<1)
      for(i=1;i<=valSMA;i++)
        {
         MovingBuffer[Bars-i]=EMPTY_VALUE;
         UpperBuffer[Bars-i]=EMPTY_VALUE;
         LowerBuffer[Bars-i]=EMPTY_VALUE;
        }
//----
   int limit=Bars-counted_bars;
   if(counted_bars>0) limit++;
   for(i=0; i<limit; i++)
      {
      MovingBuffer[i]=iMA(NULL,0,valSMA,0,MODE_SMA,mode,i);
      deviation=iATR(NULL,0,valATR,i)*valnumATR;
      UpperBuffer[i]=MovingBuffer[i]+deviation;
      LowerBuffer[i]=MovingBuffer[i]-deviation;
      }*/
//----
   /*i=Bars-valSMA+1;
   if(counted_bars>valSMA-1) i=Bars-counted_bars-1;
   while(i>=0)
     {
      sum=0.0;
      k=i+valSMA-1;
      oldval=MovingBuffer[i];
      while(k>=i)
        {
         newres=Close[k]-oldval;
         sum+=newres*newres;
         k--;
        }
      //deviation=BandsDeviations*MathSqrt(sum/BandsPeriod);
      deviation=iATR(NULL,0,valATR,0)*valnumATR;
      UpperBuffer[i]=oldval+deviation;
      LowerBuffer[i]=oldval-deviation;
      i--;
     }*/
//----
   return(0);
  }
//+------------------------------------------------------------------+