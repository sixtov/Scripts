function M = verifyEU(M,vehicle)
    switch (vehicle)
        case 1
            if (isfield(M,'ANALOG_RAW'))
                disp('**** ANALOG_RAW to ANALOG_EU conversion')    
                if (~isfield(M,'ANALOG_EU'))
                    M.ANALOG_EU = M.ANALOG_RAW;
                    M.ANALOG_EU.chan01 = single(M.ANALOG_RAW.chan01);
                    M.ANALOG_EU.chan02 = single(M.ANALOG_RAW.chan02)*0.0057 + 15.185;
                    M.ANALOG_EU.chan03 = single(M.ANALOG_RAW.chan03)*0.0114 + 30.411 - M.ANALOG_EU.chan02;
                    M.ANALOG_EU.chan04 = single(M.ANALOG_RAW.chan04)*0.1162 - 2.2870;
                    M.ANALOG_EU.chan05 = single(M.ANALOG_RAW.chan05)*6.6433;
                    M.ANALOG_EU.chan06 = single(M.ANALOG_RAW.chan06);
                    M.ANALOG_EU.chan07 = single(M.ANALOG_RAW.chan07)*0.0057 + 15.285;
                    M.ANALOG_EU.chan08 = single(M.ANALOG_RAW.chan08)*0.0114 + 30.428 - M.ANALOG_EU.chan07;
                    M.ANALOG_EU.chan09 = single(M.ANALOG_RAW.chan09)*0.1161 - 2.2827;
                    M.ANALOG_EU.chan10 = single(M.ANALOG_RAW.chan10)*6.6433;
                    M.ANALOG_EU.chan11 = single(M.ANALOG_RAW.chan11);
                    M.ANALOG_EU.chan12 = single(M.ANALOG_RAW.chan12)*6.6433;
                    M.ANALOG_EU.chan13 = single(M.ANALOG_RAW.chan13)*0.1162 - 2.2870;
                    M.ANALOG_EU.chan14 = single(M.ANALOG_RAW.chan14)*0.1161 - 2.2827;
                    M.ANALOG_EU.chan15 = single(M.ANALOG_RAW.chan15);
                    M.ANALOG_EU.chan16 = single(M.ANALOG_RAW.chan16);
                end
                M = rmfield(M,'ANALOG_RAW');
            end
            
% #if SLV_AIRCRAFT == SLV_R1
% 	mavlink_msg_analog_eu_send( // quick calibration: April 03 2012
%         chan,
% 		fPWM,	//  = (float)g.channel_roll.radio_in;
% 		f20vV,	// = (float)ac_ch[0]*0.0057 + 15.185;
% 		f40vV,	// = (float)ac_ch[2]*0.0114 + 30.411 - f20vV;
% 		fCurr,	// = (float)ac_ch[4]*0.1162 - 2.2870;
% 		fRPM,	// = (float)ac_ch[7]*6.6433; // (5/1024)*(6000/4.41);
% 		aPWM,	// = (float)g.channel_pitch.radio_in;
% 		a20vV,	// = (float)ac_ch[1]*0.0057 + 15.285;
% 		a40vV,	// = (float)ac_ch[3]*0.0114 + 30.428 - a20vV;
% 		aCurr,	// = (float)ac_ch[5]*0.1161 - 2.2827;
% 		aRPM,	//  = (float)ac_ch[6]*6.6433;
%         (float)(WptRadius), //(float)(ac_ch[10] * (1.0)         + (0.0)),
% 		aRPM,	//  = (float)ac_ch[6]*6.6433;
% 		fCurr,	// = (float)ac_ch[4]*0.1162 - 2.2870;
% 		aCurr,	// = (float)ac_ch[5]*0.1161 - 2.2827;
% 		aPWM,	// = (float)g.channel_pitch.radio_in;
%         (float)(ac_ch[15] * (1.0)         + (0.0)),
%         micros());
% #endif
            M = renameEU(M, ...
                {'fPWM','f20vV','f40vV','fCurr','fRPM', ...
                 'aPWM','a20vV','a40vV','aCurr','aRPM', ...
                 'WptRadius','aRPMCopy','fCurrCopy','aCurrCopy','aPWMCopy','nc'});
        case 2
            if (isfield(M,'ANALOG_RAW'))
                disp('**** ANALOG_RAW to ANALOG_EU conversion')    
                if (~isfield(M,'ANALOG_EU'))
                    M.ANALOG_EU = M.ANALOG_RAW;
                    M.ANALOG_EU.chan01 = single(M.ANALOG_RAW.chan01)*  0.095054  -  56.833400;
                    M.ANALOG_EU.chan02 = single(M.ANALOG_RAW.chan02)*  0.079356  -  44.599207;
                    M.ANALOG_EU.chan03 = single(M.ANALOG_RAW.chan03)*  0.111292  -  63.756075;
                    M.ANALOG_EU.chan04 = single(M.ANALOG_RAW.chan04)* -0.110489  +  63.768850;
                    M.ANALOG_EU.chan05 = single(M.ANALOG_RAW.chan05)* -0.078561  +  45.066120;
                    M.ANALOG_EU.chan06 = single(M.ANALOG_RAW.chan06)*  0.078078  -  43.682525;
                    M.ANALOG_EU.chan07 = single(M.ANALOG_RAW.chan07)*  0.160533  -  87.459090;
                    M.ANALOG_EU.chan08 = single(M.ANALOG_RAW.chan08)* (360.0 / 860) - (229.20);
                    M.ANALOG_EU.chan09 = single(M.ANALOG_RAW.chan09)* (360.0 / 860) - (226.30);
                    M.ANALOG_EU.chan10 = single(M.ANALOG_RAW.chan10)* (0.165)       + (59.211);
                    M.ANALOG_EU.chan11 = single(M.ANALOG_RAW.chan11);
                    M.ANALOG_EU.chan12 = single(M.ANALOG_RAW.chan12)*  6.976536  -  42.398147;
                    M.ANALOG_EU.chan13 = single(M.ANALOG_RAW.chan13)* (0.1230)      - (2.2160);
                    M.ANALOG_EU.chan14 = single(M.ANALOG_RAW.chan14)* (0.1239)      - (1.8683);
                    M.ANALOG_EU.chan15 = single(M.ANALOG_RAW.chan15);
                    M.ANALOG_EU.chan16 = single(M.ANALOG_RAW.chan16);
                end
                M = rmfield(M,'ANALOG_RAW');
            end
            
% #if SLV_AIRCRAFT == SLV_R2
% 	mavlink_msg_analog_eu_send( // quick calibration: April 03 2012
%         chan,
% 		  (float)(ac_ch[0]  *  0.095054  -  56.833400),	// quick calibration: April 03 2012
%         (float)(ac_ch[1]  *  0.079356  -  44.599207),	// quick calibration: April 03 2012
%         (float)(ac_ch[2]  *  0.111292  -  63.756075),	// quick calibration: April 03 2012
%         (float)(ac_ch[3]  * -0.110489  +  63.768850),	// quick calibration: April 03 2012
%         (float)(ac_ch[4]  * -0.078561  +  45.066120),	// quick calibration: April 03 2012
%         (float)(ac_ch[5]  *  0.078078  -  43.682525),	// quick calibration: April 03 2012
%         (float)(ac_ch[6]  *  0.160533  -  87.459090),	// quick calibration: April 03 2012
%         (float)(ac_ch[7]  * (360.0 / 860) - (229.20)),
%         (float)(ac_ch[8]  * (360.0 / 860) - (226.30)),
%         (float)(ac_ch[9]  * (0.165)       + (59.211)),
%         (float)(WptRadius), //(float)(ac_ch[10] * (1.0)         + (0.0)),
%         (float)(ac_ch[11] *  6.976536  -  42.398147),	// calibration: April 04 2012
%         (float)(ac_ch[12] * (0.1230)      - (2.2160)),
%         (float)(ac_ch[13] * (0.1239)      - (1.8683)),
%         (float)(ac_ch[14] * (1.0)         + (0.0)),
%         (float)(ac_ch[15] * (1.0)         + (0.0)),
%         micros());
% #endif
            M = renameEU(M, ...
                {'left_ail','left_flap','left_elev', ...
                 'right_elev','right_flap','right_ail', ...
                 'rudder','alpha','beta','mtrTemp', ...
                 'wp_radius','RPM','fwdCurr','aftCurr', ...
                 'MUX','sync'});
        case 3
            if (isfield(M,'ANALOG_RAW'))
                disp('**** ANALOG_RAW to ANALOG_EU conversion')    
                if (~isfield(M,'ANALOG_EU'))
                    M.ANALOG_EU = M.ANALOG_RAW;
                    M.ANALOG_EU.chan01 = single(M.ANALOG_RAW.chan01)* (40.0 / 360)  - (61.77);
                    M.ANALOG_EU.chan02 = single(M.ANALOG_RAW.chan02)* (20.0 / 238)  - (48.99);
                    M.ANALOG_EU.chan03 = single(M.ANALOG_RAW.chan03)* (45.0 / 424)  - (60.18);
                    M.ANALOG_EU.chan04 = single(M.ANALOG_RAW.chan04)* (40.5 / 406)  - (52.37);
                    M.ANALOG_EU.chan05 = single(M.ANALOG_RAW.chan05)* (20.0 / 203)  - (57.14);
                    M.ANALOG_EU.chan06 = single(M.ANALOG_RAW.chan06)* (41.5 / 355)  - (61.77);
                    M.ANALOG_EU.chan07 = single(M.ANALOG_RAW.chan07)* (50.0 / 293)  - (98.12);
                    M.ANALOG_EU.chan08 = single(M.ANALOG_RAW.chan08)* (360.0 / 860) - (229.20);
                    M.ANALOG_EU.chan09 = single(M.ANALOG_RAW.chan09)* (360.0 / 860) - (226.30);
                    M.ANALOG_EU.chan10 = single(M.ANALOG_RAW.chan10)* (0.165)       + (59.211);
                    M.ANALOG_EU.chan11 = single(M.ANALOG_RAW.chan11);
                    M.ANALOG_EU.chan12 = single(M.ANALOG_RAW.chan12)* (8.040868)    + (0.0);
                    M.ANALOG_EU.chan13 = single(M.ANALOG_RAW.chan13)* (0.1230)      - (2.2160);
                    M.ANALOG_EU.chan14 = single(M.ANALOG_RAW.chan14)* (0.1239)      - (1.8683);
                    M.ANALOG_EU.chan15 = single(M.ANALOG_RAW.chan15);
                    M.ANALOG_EU.chan16 = single(M.ANALOG_RAW.chan16);
                end
                M = rmfield(M,'ANALOG_RAW');
            end
            
% #if SLV_AIRCRAFT == SLV_R3
% 	mavlink_msg_analog_eu_send(
%         chan,
%         (float)(ac_ch[0]  * (40.0 / 360)  - (61.77)),
%         (float)(ac_ch[1]  * (20.0 / 238)  - (48.99)),
%         (float)(ac_ch[2]  * (45.0 / 424)  - (60.18)),
%         (float)(ac_ch[3]  * (40.5 / 406)  - (52.37)),
%         (float)(ac_ch[4]  * (20.0 / 203)  - (57.14)),
%         (float)(ac_ch[5]  * (41.5 / 355)  - (61.77)),
%         (float)(ac_ch[6]  * (50.0 / 293)  - (98.12)),
%         (float)(ac_ch[7]  * (360.0 / 860) - (229.20)),
%         (float)(ac_ch[8]  * (360.0 / 860) - (226.30)),
%         (float)(ac_ch[9]  * (0.165)       + (59.211)),
%         (float)(WptRadius), //(float)(ac_ch[10] * (1.0)         + (0.0)),
%         (float)(ac_ch[11] * (8.040868)    + (0.0)),
%         (float)(ac_ch[12] * (0.1230)      - (2.2160)),
%         (float)(ac_ch[13] * (0.1239)      - (1.8683)),
%         (float)(ac_ch[14] * (1.0)         + (0.0)),
%         (float)(ac_ch[15] * (1.0)         + (0.0)),
%         micros());
% #endif
            M = renameEU(M, ...
                {'left_ail','left_flap','left_elev', ...
                 'right_elev','right_flap','right_ail', ...
                 'rudder','alpha','beta','mtrTemp', ...
                 'wp_radius','RPM','fwdCurr','aftCurr', ...
                 'MUX','sync'});
        case 4
            if (isfield(M,'ANALOG_RAW'))
                disp('**** ANALOG_RAW to ANALOG_EU conversion')    
                if (~isfield(M,'ANALOG_EU'))
                    M.ANALOG_EU = M.ANALOG_RAW;
                    M.ANALOG_EU.chan01 = single(M.ANALOG_RAW.chan01);
                    M.ANALOG_EU.chan02 = single(M.ANALOG_RAW.chan02)*0.0057 + 15.185;
                    M.ANALOG_EU.chan03 = single(M.ANALOG_RAW.chan03)*0.0114 + 30.411 - M.ANALOG_EU.chan02;
                    M.ANALOG_EU.chan04 = single(M.ANALOG_RAW.chan04)*0.1162 - 2.2870;
                    M.ANALOG_EU.chan05 = single(M.ANALOG_RAW.chan05)*6.6433;
                    M.ANALOG_EU.chan06 = single(M.ANALOG_RAW.chan06);
                    M.ANALOG_EU.chan07 = single(M.ANALOG_RAW.chan07)*0.0057 + 15.285;
                    M.ANALOG_EU.chan08 = single(M.ANALOG_RAW.chan08)*0.0114 + 30.428 - M.ANALOG_EU.chan07;
                    M.ANALOG_EU.chan09 = single(M.ANALOG_RAW.chan09)*0.1161 - 2.2827;
                    M.ANALOG_EU.chan10 = single(M.ANALOG_RAW.chan10)*6.6433;
                    M.ANALOG_EU.chan11 = single(M.ANALOG_RAW.chan11);
                    M.ANALOG_EU.chan12 = single(M.ANALOG_RAW.chan12)*6.6433;
                    M.ANALOG_EU.chan13 = single(M.ANALOG_RAW.chan13)*0.1162 - 2.2870;
                    M.ANALOG_EU.chan14 = single(M.ANALOG_RAW.chan14)*0.1161 - 2.2827;
                    M.ANALOG_EU.chan15 = single(M.ANALOG_RAW.chan15);
                    M.ANALOG_EU.chan16 = single(M.ANALOG_RAW.chan16);
                end
                M = rmfield(M,'ANALOG_RAW');
            end
            
% #if SLV_AIRCRAFT == SLV_R1
% 	mavlink_msg_analog_eu_send( // quick calibration: April 03 2012
%         chan,
% 		fPWM,	//  = (float)g.channel_roll.radio_in;
% 		f20vV,	// = (float)ac_ch[0]*0.0057 + 15.185;
% 		f40vV,	// = (float)ac_ch[2]*0.0114 + 30.411 - f20vV;
% 		fCurr,	// = (float)ac_ch[4]*0.1162 - 2.2870;
% 		fRPM,	// = (float)ac_ch[7]*6.6433; // (5/1024)*(6000/4.41);
% 		aPWM,	// = (float)g.channel_pitch.radio_in;
% 		a20vV,	// = (float)ac_ch[1]*0.0057 + 15.285;
% 		a40vV,	// = (float)ac_ch[3]*0.0114 + 30.428 - a20vV;
% 		aCurr,	// = (float)ac_ch[5]*0.1161 - 2.2827;
% 		aRPM,	//  = (float)ac_ch[6]*6.6433;
%         (float)(WptRadius), //(float)(ac_ch[10] * (1.0)         + (0.0)),
% 		aRPM,	//  = (float)ac_ch[6]*6.6433;
% 		fCurr,	// = (float)ac_ch[4]*0.1162 - 2.2870;
% 		aCurr,	// = (float)ac_ch[5]*0.1161 - 2.2827;
% 		aPWM,	// = (float)g.channel_pitch.radio_in;
%         (float)(ac_ch[15] * (1.0)         + (0.0)),
%         micros());
% #endif
            M = renameEU(M, ...
                {'fPWM','f20vV','f40vV','fCurr','fRPM', ...
                 'aPWM','a20vV','a40vV','aCurr','aRPM', ...
                 'WptRadius','aRPMCopy','fCurrCopy','aCurrCopy','aPWMCopy','nc'});
        otherwise
			%fprintf('Unknown Vehicle: id[%d]',vehicle);
    end
return

function M = renameEU(M,newName)
    if (isfield(M,'ANALOG_EU'))
        fn = fieldnames(M.ANALOG_EU);
        N = length(newName);
        L = length(fn);
        K = min(N,L);
        for i=1:K
            if (~isfield(M.ANALOG_EU,newName{i}))
                ifield = sprintf('chan%02d',i);
                M.ANALOG_EU.(newName{i}) = M.ANALOG_EU.(ifield);
                M.ANALOG_EU = rmfield(M.ANALOG_EU,ifield);
            end
        end
    end
return

