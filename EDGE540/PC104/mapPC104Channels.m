function PC104 = mapPC104Channels(pc104,csvFile)
    if ~isempty(csvFile)
        channelMap = decodeMapping(csvFile);
        idx = find(channelMap.idx);
        PC104.file = ' ';
        PC104.type = ' ';
        PC104.des = [];
        for i=1:length(idx)
            PC104.RAW.(channelMap.raw{idx(i)}) = pc104.data(:,channelMap.idx(idx(i)));
            PC104.EU.(channelMap.eu{idx(i)}) = channelMap.gain(idx(i))*PC104.RAW.(channelMap.raw{idx(i)}) + channelMap.bias(idx(i));
%             if i<10
%                 PC104.EU.(channelMap.eu{idx(i)}) = PC104.EU.(channelMap.eu{idx(i)}) - PC104.EU.(channelMap.eu{idx(i)})(1);
%             end
            PC104.des = [PC104.des; {channelMap.des{idx(i)}}];
        end

        PC104.Vt = [PC104.EU.LWOBSTRN  ...
                    PC104.EU.LWCTRSTRN ...
                    PC104.EU.LWIBSTRN  ...
                    PC104.EU.CTRLSTRN  ...
                    PC104.EU.CTRCSTRN  ...
                    PC104.EU.CTRRSTRN  ...
                    PC104.EU.RWIBSTRN  ...
                    PC104.EU.RWCTRSTRN ...
                    PC104.EU.RWOBSTRN];
        
        %% Convert Battery Voltages back to 21V-Base
        PC104.EU.FWDMTRUPR40VBATTV = PC104.EU.FWDMTRUPR40VBATTV - PC104.EU.FWDMTRLWR20VBATTV;
        PC104.EU.AFTMTRLWR40VBATTV = PC104.EU.AFTMTRLWR40VBATTV - PC104.EU.AFTMTRUPR20VBATTV;
        
        %% Process Strain Channels
        %% Up to this point the EU strain is the voltage at the bridge (Vch).
        %% This voltage needs to be converted to strain using the following
        %% equation:
        %%      strain = (-4Vr/GF(1+2Vr))(1+(Rl/Rg))
        %%                  where Vr = (Vch - Vo)/Vex
        %%                          Vo is the bridge voltage with no strain
        %%                          Vex is the excitation voltage (constant)
        %%                          GF is the gage factor (constant)
        %%                          Rl is the lead resistance (constant)
        %%                          Rg is the gauge resistance (constant)
        %%                          strain(Vch,Vo,Vex,GF,Rl,Rg);
        PC104.EU.LWOBSTRN  = strain(PC104.EU.LWOBSTRN ,0,5,2.085,0.7,350);
        PC104.EU.LWCTRSTRN = strain(PC104.EU.LWCTRSTRN,0,5,2.085,0.7,350);
        PC104.EU.LWIBSTRN  = strain(PC104.EU.LWIBSTRN ,0,5,2.085,0.7,350);
        PC104.EU.CTRLSTRN  = strain(PC104.EU.CTRLSTRN ,0,5,2.090,0.7,350);
        PC104.EU.CTRCSTRN  = strain(PC104.EU.CTRCSTRN ,0,5,2.090,0.7,350);
        PC104.EU.CTRRSTRN  = strain(PC104.EU.CTRRSTRN ,0,5,2.090,0.7,350);
        PC104.EU.RWIBSTRN  = strain(PC104.EU.RWIBSTRN ,0,5,2.085,0.7,350);
        PC104.EU.RWCTRSTRN = strain(PC104.EU.RWCTRSTRN,0,5,2.085,0.7,350);
        PC104.EU.RWOBSTRN  = strain(PC104.EU.RWOBSTRN ,0,5,2.085,0.7,350);

        PC104.ue = [PC104.EU.LWOBSTRN  ...
                    PC104.EU.LWCTRSTRN ...
                    PC104.EU.LWIBSTRN  ...
                    PC104.EU.CTRLSTRN  ...
                    PC104.EU.CTRCSTRN  ...
                    PC104.EU.CTRRSTRN  ...
                    PC104.EU.RWIBSTRN  ...
                    PC104.EU.RWCTRSTRN ...
                    PC104.EU.RWOBSTRN];
        
        %% Calculated EU Channels
        x = PC104.EU.RPM;
        %% Using Flight 08 Data
         p = [-0.000086 1.558386 -2331.056304];
        PC104.EU.RPM = polyval(p,x);
            
        %% Calculated EU Channels
        if ~exist('PC104.EU.altitude','var')
            x = PC104.EU.PSR;
            %p = [-1894 2.625e+004];
            %% Using Flight 08 Data
             p = [-1892.431263 31747.462524];
            PC104.EU.altitude = polyval(p,x);
        end
        if ~exist('PC104.EU.ias','var')
            x = PC104.EU.PDR;
            %numerator = [8084 -1588 3375 -2687 564.7 -25.45];
            %denominator = [1 -162.6 192 -71.1 8.446];
            %% Using Flight 08 Data
            numerator = [-14.017542 44.145244 -17.695942 -11.299440 6.620934 -0.593208];
            denominator = [1 -3.609827 4.330290 -2.133688 0.373162];
            PC104.EU.ias = polyval(numerator,x)./ ...
                           polyval(denominator,x);
        end
        PC104.MATRIX = pc104.data;
    end
return

