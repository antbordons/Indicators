#property indicator_chart_window
#property indicator_buffers 3
#property indicator_color1 clrNONE
#property indicator_color2 Blue
#property indicator_color3 Red
#property indicator_width1 2
#property indicator_width2 2
#property indicator_width3 2

extern int period = 16;
extern int method = 3; // MODE_SMA
extern int price = 0; // PRICE_CLOSE
extern int shift = 0;

double Uptrend[];
double Dntrend[];
double ExtMapBuffer[];

double vect[];

static bool bs = false, ba = false;
static int bTime = 0;

int init()
{
	IndicatorBuffers(4);
	SetIndexBuffer(0, ExtMapBuffer);
	SetIndexBuffer(1, Uptrend);
	SetIndexBuffer(2, Dntrend);
	SetIndexBuffer(3, vect);

	SetIndexStyle(0, DRAW_LINE);
	SetIndexStyle(1, DRAW_LINE);
	SetIndexStyle(2, DRAW_LINE);

	SetIndexDrawBegin(0, 1*period);
	SetIndexDrawBegin(1, 2*period);
	SetIndexDrawBegin(2, 3*period);

	IndicatorShortName("IFX HMA(" + period + ")");
	SetIndexLabel(1, "UP");
	SetIndexLabel(2, "DN");

	bs = false;
	ba = false;
	bTime = 0;

	return (0);
}

int deinit()
{
	return (0);
}

double GetWMA(int x, int p)
{
	return (iMA(NULL, 0, p, 0, method, price, x + shift));
}

int start()
{
	int p = MathSqrt(period);

	int i, limit0, limit1, limit2;

	int counted_bars = IndicatorCounted();
	if (counted_bars < 0)
		return (-1);
	if (counted_bars > 0)
		counted_bars--;
	limit2 = Bars - counted_bars;
	if (counted_bars == 0)
		limit2--;

	limit1 = limit2;
	limit0 = limit1;

	if (counted_bars == 0)
	{
		limit1 -= (period);
		limit2 -= (2*period);
	}

	for (i = limit0; i >= 0; i--)
		vect[i] = 2 * GetWMA(i, period / 2) - GetWMA(i, period);
	for (i = limit1; i >= 0; i--)
		ExtMapBuffer[i] = iMAOnArray(vect, 0, p, 0, method, i);
	for (i = limit2; i >= 0; i--)
	{
		Uptrend[i] = EMPTY_VALUE;
		if (ExtMapBuffer[i] > ExtMapBuffer[i + 1])
		{
			Uptrend[i + 1] = ExtMapBuffer[i + 1];
			Uptrend[i] = ExtMapBuffer[i];
		}
		Dntrend[i] = EMPTY_VALUE;
		if (ExtMapBuffer[i] < ExtMapBuffer[i + 1])
		{
			Dntrend[i + 1] = ExtMapBuffer[i + 1];
			Dntrend[i] = ExtMapBuffer[i];
		}
	}
	if (bTime != Time[0])
	{
		bTime = Time[0];
		bs = false;
		ba = false;
	}
	return (0);
}
// +------------------------------------------------------------------+