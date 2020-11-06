
# Martin Pring's KNOW SURE THING (KST) Indicator
# Daily KST Simple Moving Average
# Writen by Mike Wilgus
# fxmike.blogspot.com
# ------------------------------------------------
declare lower;

#--Input variables
input rocLength1 = 10;
input rocLength2 = 15;
input rocLength3 = 20;
input rocLength4 = 30;

def sumRocLength = rocLength1 + rocLength2 + rocLength3 + rocLength4;
def avgLength1 = 10;
def avgLength2 = 10;
def avgLength3 = 10;
def avgLength4 = 15;


#--Calc ROC - RateOfChange(length, color norm length, price)
def ROC1 = RateOfChange(rocLength1, rocLength1, close);
def ROC2 = RateOfChange(rocLength2, rocLength2, close);
def ROC3 = RateOfChange(rocLength3, rocLength3, close);
def ROC4 = RateOfChange(rocLength4, rocLength4, close);

#--Plot lines
plot zeroLine = 0;

plot fastKST = (Average(ROC1, avgLength1) * (rocLength1 / sumRocLength)) +
               (Average(ROC2, avgLength2) * (rocLength2 / sumRocLength)) +
               (Average(ROC3, avgLength3) * (rocLength3 / sumRocLength)) +
               (Average(ROC4, avgLength4) * (rocLength4 / sumRocLength));

plot slowKST = Average(fastKST, rocLength1);


#--Set Colors and Style
zeroLine.SetDefaultColor(GetColor(7));
fastKST.SetDefaultColor(GetColor(5));
fastKST.SetStyle(Curve.LONG_DASH);
slowKST.SetDefaultColor(GetColor(1));


#-- alerts
Alert(fastKST[1] < slowKST[1] and fastKST > slowKST, "Cross Above", Alert.BAR, Sound.RING);
Alert(fastKST[1] > slowKST[1] and fastKST < slowKST, "Cross Below", Alert.BAR, Sound.RING);

#--End Code--------------------------------------