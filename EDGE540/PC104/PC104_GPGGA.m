%%
function PC104_GPGGA()
    flist = dir('*F201*.mat');
    if isempty(flist)
        return
    end
    N = length(flist);
    if (N>1)
        return
    end
    load(flist(1).name,'pc104');
    %load('EDGE540R2_FLT10_F201_071610_1344.mat','pc104');
    %load('EDGE540R2_FLT11_NORMAL_F201_082410_1018.mat','pc104');
    read_GPS();

    %%
    flist = dir('*F200*.mat');
    if isempty(flist)
        return
    end
    N = length(flist);
    if (N>1)
        return
    end
    load(flist(1).name,'pc104');
    %load('EDGE540R2_FLT10_F200_071610_1344.mat','pc104');
    %load('EDGE540R2_FLT11_NORMAL_F200_082410_1018.mat','pc104');
    read_quaternions();

    %%
    pos_and_orient();
    clear
    load('pos_and_orient.mat');

    %%
    % GPGGA = char(pc104.data);
    % N = size(GPGGA,1);
    % GPStime = [];
    % lat = [];
    % lon = [];
    % alt = [];
    % 
    % %%
    % for i=1:N
    %     [ltime llat llon lalt] = parse_latlonalt(GPGGA(i,:));
    %     if (ltime>0)
    %         GPStime = [GPStime; ltime];
    %         lat = [lat; llat];
    %         lon = [lon; llon];
    %         alt = [alt; lalt];
    %     end
    % end
    % GPStime = GPStime-GPStime(1);
    % 
    % %%
    % PC.ts_lat = timeseries(lat,GPStime,'name','lat');
    % PC.ts_lon = timeseries(lon,GPStime,'name','lon');
    % PC.ts_alt = timeseries(alt,GPStime,'name','alt');
    % 
    % PC.ts_lat20hz = PC.ts_lat.resample(PC.ts_psi.time);
    % PC.ts_lon20hz = PC.ts_lon.resample(PC.ts_psi.time);
    % PC.ts_alt20hz = PC.ts_alt.resample(PC.ts_psi.time);
    % 
    %%
    hold off
    plot(PC.ts_lat.time,PC.ts_lat.data,'b')
    hold on
    plot(PC.ts_lat20hz.time,PC.ts_lat20hz.data,'r')

    %%
    hold off
    plot(PC.ts_lon.time,PC.ts_lon.data,'b')
    hold on
    plot(PC.ts_lon20hz.time,PC.ts_lon20hz.data,'r')

    %%
    hold off
    plot(PC.ts_lon20hz.data,PC.ts_lat20hz.data,':b.')
    grid on

    %%
    % %%
    % %% Use PC104 Data
    % T = 1/20;
    % %da = [PC.ts_lat20hz.data+0.008 -PC.ts_lon20hz.data-0.235580 PC.ts_alt20hz.data PC.ts_phi.data  PC.ts_theta.data PC.ts_psi.data 3000*ones(size(PC.ts_theta.data)) ones(size(PC.ts_theta.data))];
    % da = [PC.ts_lat.data PC.ts_lon.data PC.ts_alt.data zeros(size(PC.ts_lat.data,1),3) 3000*ones(size(PC.ts_lat.data)) zeros(size(PC.ts_lat.data))];
    % %da = da(6500:17000,:);
    % dline = da(1,:);
    % 
return
