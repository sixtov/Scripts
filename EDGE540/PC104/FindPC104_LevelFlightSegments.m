%%
function tseg = FindPC104_LevelFlightSegments(dfile,a,b,c,d,e,f)
    load(dfile);
    PC104 = genPC104TimeSeries(PC104);
    tseg = FindPC104_TS_LevelFlightSegments(PC104,a,b,c,d,e,f);
return
