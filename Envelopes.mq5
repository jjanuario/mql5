//+------------------------------------------------------------------+
//| São Paulo, 13 de Novembro de 2019                                |
//|Criando indicadores para uso de analise grafica, utilizando meta  |
//|                                                    Envelopes.mq5 |
//|                                                Jeferson Januario |
//|                                   https://asterixsolucoes.com.br |
//+------------------------------------------------------------------+
#property copyright "Jeferson Januario"
#property link      "https://asterixsolucoes.com.br"
#property version   "1.00"
#property indicator_chart_window
#property indicator_buffers 2
#property indicator_plots   2
//--- plot Superior
#property indicator_label1  "Superior"
#property indicator_type1   DRAW_LINE
#property indicator_color1  clrBlue
#property indicator_style1  STYLE_SOLID
#property indicator_width1  3
//--- plot Inferior
#property indicator_label2  "Inferior"
#property indicator_type2   DRAW_LINE
#property indicator_color2  clrRed
#property indicator_style2  STYLE_SOLID
#property indicator_width2  3
//--- indicator buffers
double         SuperiorBuffer[];
double         InferiorBuffer[];

//--- Declaração de variaveis
input int periodos = 14;
input double desvio = 0.1;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   SetIndexBuffer(0,SuperiorBuffer,INDICATOR_DATA);
   SetIndexBuffer(1,InferiorBuffer,INDICATOR_DATA);

//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//---

//--- Eu começo a incluir codigo aqui

   for(int i=periodos-1; i<rates_total; i++)
     {
      double media = 0;
      for(int j=0; j<periodos; j++)
        {
         media = media + close[i-j] / periodos;
        }
      SuperiorBuffer[i] = media *(1+desvio/100);
      InferiorBuffer[i] = media* (1-desvio/100);
     }

//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
