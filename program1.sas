*Using the DATA step to manipulate data*

data cars_update;
    set sashelp.cars;
	keep Make Model MSRP Invoice AvgMPG;
	AvgMPG=mean(MPG_Highway, MPG_City);
	label MSRP="Manufacturer Suggested Retail Price"
          AvgMPG="Average Miles per Gallon"
          Invoice = "Invoice Price";
run;

proc means data=cars_update min mean max;
    var MSRP Invoice;
run;

proc print data=cars_update label;
    var Make Model MSRP Invoice AvgMPG;
run;

*Generating reports using PROC steps*

title1 'Counts of Selected Park Types by Park Region';
ods graphics on;
proc freq data=pg1.np_codelookup order=freq;
	tables Type*Region / crosslist plots=freqplot(twoway=stacked orient=horizontal);
	where type in ('National Historic Site', 'National Monument', 'National Park');
run;

/*part b*/
title1 'Counts of Selected Park Types by Park Region';
proc sgplot data=pg1.np_codelookup;
    where Type in ('National Historic Site', 'National Monument', 'National Park');
    hbar region / group=type dataskin = gloss fillattrs = (transparency = 0.5) ;
    keylegend / opaque across=1 position=bottomright location=inside;
    xaxis grid;
run;
title;

