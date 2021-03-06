%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
%           METEOSTUNAMI SURROGATE MODEL USER INTERFACE                   %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Created by Celia Bolzer & Clea Denamiel
% For information contact: Clea Denamiel at cdenamie@izor.hr
% last modifications: 29/06/2019
%
% The user friendly interface is used to run the meteotsunami surrogate
% model, display the results and save the output in surrogate_results.mat.
%
% output:
% 1x9 struct array with fields:
%    input_surrogate
%    station_name
%    zeta_max
%    tide_max
%
%    output(1).input_surrogate
%         amplitude:      [1x1 struct]
%         direction:      [1x1 struct]
%         speed:          [1x1 struct]
%         period:         [1x1 struct]
%         start_latitude: [1x1 struct]
%         width:          [1x1 struct]
%    output(1:9).station_name
%         Harbor of Vela Luka
%         Harbor of Rijeka Dubrova?ka
%         Harbor of Stari Grad
%         Harbor of Vrboska
%         Harbor of Viganj
%         Harbor of Mali Ston
%         Harbor of Ston
%         Harbor of Mali Lo�inj
%         Harbor of Ist
%    output(1:9).zeta_max
%         value: [1x20000 double] / 20000 samples generated by surrogate model
%         units: 'm'
%         nan: 'values under 0.1m'
%         long_name: 'Maximum Meteotsunami Elevation including tide'
%    output(1:9).tide_max
%         value: [1x1 double] / maximum daily tidal elevation
%         units: 'm'
%         long_name: 'Maximum Tidal Elevation extracted with TMD from the Mediterranean OSU model'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Initialisation
%--------------------------------------------------------------------------
function varargout = meteotsunami_surrogate_model(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @meteotsunami_surrogate_model_OpeningFcn, ...
                   'gui_OutputFcn',  @meteotsunami_surrogate_model_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
path(path,'TMD_FUNCTIONS');
%--------------------------------------------------------------------------
%% Default display settings
%--------------------------------------------------------------------------
function meteotsunami_surrogate_model_OpeningFcn(hObject, eventdata, handles, varargin)
% Choose default command line output for statistics
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
set(handles.min_start_location,'Enable','On')
set(handles.min_amplitude,'Enable','On')
set(handles.min_direction,'Enable','On')
set(handles.min_speed,'Enable','On')
set(handles.min_period,'Enable','On')
set(handles.min_width,'Enable','On')
set(handles.max_start_location,'Enable','On')
set(handles.max_amplitude,'Enable','On')
set(handles.max_direction,'Enable','On')
set(handles.max_speed,'Enable','On')
set(handles.max_period,'Enable','On')
set(handles.max_width,'Enable','On')
nom_legende=[];
assignin('base','nom_legende',nom_legende)
% Update maps
set(handles.Axe_trace,'Visible','on')
axes(handles.Axe_trace)
box on;
plot([0 0.5],[0 0],'w')
ylim([0 1])
xlim([0 3])
xlabel('Maximum Elevation (m)')
ylabel('Probability')
set(gca,'FontSize',20)
function varargout = meteotsunami_surrogate_model_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;
%--------------------------------------------------------------------------
%% start location
%--------------------------------------------------------------------------
function min_start_location_Callback(hObject, eventdata, handles) %#ok<*DEFNU>
axes(handles.Axe_trace)
legend off
cla
set(handles.Superimpose,'Visible','Off')
set(handles.Station,'Value',1)
set(handles.Download_OK,'Value',0)
set(handles.Infos,'String','Download New Data then Select Station')
function min_start_location_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function max_start_location_Callback(hObject, eventdata, handles)
axes(handles.Axe_trace)
legend off
cla
set(handles.Superimpose,'Visible','Off')
set(handles.Station,'Value',1)
set(handles.Download_OK,'Value',0)
set(handles.Infos,'String','Download New Data then Select Station')
function max_start_location_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function imposed_start_location_Callback(hObject, eventdata, handles)
axes(handles.Axe_trace)
cla
legend off
set(handles.Superimpose,'Visible','Off')
set(handles.Station,'Value',1)
set(handles.Download_OK,'Value',0)
set(handles.Infos,'String','Download New Data then Select Station')
valeur=get(handles.imposed_start_location,'Value');
if valeur == 0
    set(handles.min_start_location,'Enable','on')
    set(handles.max_start_location,'Enable','on')
else 
    set(handles.min_start_location,'Enable','on')
    set(handles.max_start_location,'Enable','off')
    set(handles.max_start_location,'String','43.65')
end
%--------------------------------------------------------------------------
%% amplitude
%--------------------------------------------------------------------------
function min_amplitude_Callback(hObject, eventdata, handles)
axes(handles.Axe_trace)
cla
legend off
set(handles.Superimpose,'Visible','Off')
set(handles.Station,'Value',1)
set(handles.Download_OK,'Value',0)
set(handles.Infos,'String','Download New Data then Select Station')
function min_amplitude_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function max_amplitude_Callback(hObject, eventdata, handles)
axes(handles.Axe_trace)
cla
legend off
set(handles.Superimpose,'Visible','Off')
set(handles.Station,'Value',1)
set(handles.Download_OK,'Value',0)
set(handles.Infos,'String','Download New Data then Select Station')
function max_amplitude_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function imposed_amplitude_Callback(hObject, eventdata, handles)
valeur=get(handles.imposed_amplitude,'Value');
axes(handles.Axe_trace)
cla
legend off
set(handles.Superimpose,'Visible','Off')
set(handles.Station,'Value',1)
set(handles.Download_OK,'Value',0)
set(handles.Infos,'String','Download New Data then Select Station')
if valeur == 0
    set(handles.min_amplitude,'Enable','on')
    set(handles.max_amplitude,'Enable','on')
else 
    set(handles.min_amplitude,'Enable','on')
    set(handles.max_amplitude,'Enable','off')
    set(handles.max_amplitude,'String','400')
end
%--------------------------------------------------------------------------
%% direction
%--------------------------------------------------------------------------
function min_direction_Callback(hObject, eventdata, handles)
axes(handles.Axe_trace)
cla
legend off
set(handles.Superimpose,'Visible','Off')
set(handles.Station,'Value',1)
set(handles.Download_OK,'Value',0)
set(handles.Infos,'String','Download New Data then Select Station')
function min_direction_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function max_direction_Callback(hObject, eventdata, handles)
axes(handles.Axe_trace)
cla
legend off
set(handles.Superimpose,'Visible','Off')
set(handles.Station,'Value',1)
set(handles.Download_OK,'Value',0)
set(handles.Infos,'String','Download New Data then Select Station')
function max_direction_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function imposed_direction_Callback(hObject, eventdata, handles)
axes(handles.Axe_trace)
cla
legend off
set(handles.Superimpose,'Visible','Off')
set(handles.Station,'Value',1)
set(handles.Download_OK,'Value',0)
set(handles.Infos,'String','Download New Data then Select Station')
valeur=get(handles.imposed_direction,'Value');
if valeur == 0
    set(handles.min_direction,'Enable','on')
    set(handles.max_direction,'Enable','on')
else 
    set(handles.min_direction,'Enable','on')
    set(handles.max_direction,'Enable','off')
    set(handles.max_direction,'String','1.5707')
end
%--------------------------------------------------------------------------
%% speed
%--------------------------------------------------------------------------
function min_speed_Callback(hObject, eventdata, handles)
axes(handles.Axe_trace)
cla
legend off
set(handles.Superimpose,'Visible','Off')
set(handles.Station,'Value',1)
set(handles.Download_OK,'Value',0)
set(handles.Infos,'String','Download New Data then Select Station')
function min_speed_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function max_speed_Callback(hObject, eventdata, handles)
axes(handles.Axe_trace)
cla
legend off
set(handles.Superimpose,'Visible','Off')
set(handles.Station,'Value',1)
set(handles.Download_OK,'Value',0)
set(handles.Infos,'String','Download New Data then Select Station')
function max_speed_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function imposed_speed_Callback(hObject, eventdata, handles)
axes(handles.Axe_trace)
cla
legend off
set(handles.Superimpose,'Visible','Off')
set(handles.Station,'Value',1)
set(handles.Download_OK,'Value',0)
set(handles.Infos,'String','Download New Data then Select Station')
valeur=get(handles.imposed_speed,'Value');
if valeur == 0
    set(handles.min_speed,'Enable','on')
    set(handles.max_speed,'Enable','on')
else 
    set(handles.min_speed,'Enable','on')
    set(handles.max_speed,'Enable','off')
    set(handles.max_speed,'String','40')
end
%--------------------------------------------------------------------------
%% period
%--------------------------------------------------------------------------
function min_period_Callback(hObject, eventdata, handles)
axes(handles.Axe_trace)
cla
legend off
set(handles.Superimpose,'Visible','Off')
set(handles.Station,'Value',1)
set(handles.Download_OK,'Value',0)
set(handles.Infos,'String','Download New Data then Select Station')
function min_period_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function max_period_Callback(hObject, eventdata, handles)
axes(handles.Axe_trace)
cla
legend off
set(handles.Superimpose,'Visible','Off')
set(handles.Station,'Value',1)
set(handles.Download_OK,'Value',0)
set(handles.Infos,'String','Download New Data then Select Station')
function max_period_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function imposed_period_Callback(hObject, eventdata, handles)
axes(handles.Axe_trace)
cla
legend off
set(handles.Superimpose,'Visible','Off')
set(handles.Station,'Value',1)
set(handles.Download_OK,'Value',0)
set(handles.Infos,'String','Download New Data then Select Station')
valeur=get(handles.imposed_period,'Value');
if valeur == 0
    set(handles.min_period,'Enable','on')
    set(handles.max_period,'Enable','on')
else 
    set(handles.min_period,'Enable','on')
    set(handles.max_period,'Enable','off')
    set(handles.max_period,'String','1800')
end
%--------------------------------------------------------------------------
%% width 
%--------------------------------------------------------------------------
function min_width_Callback(hObject, eventdata, handles)
axes(handles.Axe_trace)
cla
legend off
set(handles.Superimpose,'Visible','Off')
set(handles.Station,'Value',1)
set(handles.Download_OK,'Value',0)
set(handles.Infos,'String','Download New Data then Select Station')
function min_width_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function max_width_Callback(hObject, eventdata, handles)
axes(handles.Axe_trace)
cla
legend off
set(handles.Superimpose,'Visible','Off')
set(handles.Station,'Value',1)
set(handles.Download_OK,'Value',0)
set(handles.Infos,'String','Download New Data then Select Station')
function max_width_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function imposed_width_Callback(hObject, eventdata, handles)
axes(handles.Axe_trace)
cla
legend off
set(handles.Superimpose,'Visible','Off')
set(handles.Station,'Value',1)
set(handles.Download_OK,'Value',0)
set(handles.Infos,'String','Download New Data then Select Station')
valeur=get(handles.imposed_width,'Value');
if valeur == 0
    set(handles.min_width,'Enable','on')
    set(handles.max_width,'Enable','on')
else 
    set(handles.min_width,'Enable','on')
    set(handles.max_width,'Enable','off')
    set(handles.max_width,'String','150000')
end
function year_Callback(hObject, eventdata, handles)
axes(handles.Axe_trace)
%--------------------------------------------------------------------------
cla
legend off
set(handles.Superimpose,'Visible','Off')
set(handles.Station,'Value',1)
set(handles.Download_OK,'Value',0)
set(handles.Infos,'String','Download New Data then Select Station')
function year_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function month_Callback(hObject, eventdata, handles)
axes(handles.Axe_trace)
cla
legend off
set(handles.Superimpose,'Visible','Off')
set(handles.Station,'Value',1)
set(handles.Download_OK,'Value',0)
set(handles.Infos,'String','Download New Data then Select Station')
function month_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function day_Callback(hObject, eventdata, handles)
axes(handles.Axe_trace)
cla
legend off
set(handles.Superimpose,'Visible','Off')
set(handles.Station,'Value',1)
set(handles.Download_OK,'Value',0)
set(handles.Infos,'String','Download New Data then Select Station')
function day_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function imposed_date_Callback(hObject, eventdata, handles)
axes(handles.Axe_trace)
cla
legend off
set(handles.Superimpose,'Visible','Off')
set(handles.Station,'Value',1)
set(handles.Download_OK,'Value',0)
set(handles.Infos,'String','Download New Data then Select Station')
valeur=get(handles.imposed_date,'Value');
if valeur == 1
    set(handles.year,'Enable','on')
    set(handles.month,'Enable','on')
    set(handles.day,'Enable','on')
else 
    set(handles.year,'Enable','off')
    set(handles.month,'Enable','off')
    set(handles.day,'Enable','off')
    set(handles.year,'String','2000')
    set(handles.month,'String','1')
    set(handles.day,'String','1')
end
%--------------------------------------------------------------------------
%% Surrogate model run & Infos
%--------------------------------------------------------------------------
% Informations
function Infos_Callback(hObject, eventdata, handles) %#ok<*INUSD>
function Infos_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function Download_Callback(hObject, eventdata, handles)
% reset legend
nom_legende=[];
assignin('base','nom_legende',nom_legende)
% open surrogate model file
h=waitbar(0,'Downloading Surrogate Model Data');
fichier='gPCE_coeff_hat_max.mat';
load(fichier);
maxdeg  = 7;
nmaxdeg = 6;
nmodes = 6;
a = nan(nmodes,1);
b = nan(nmodes,1);
s = nan(nmodes,1);
% Read the data input 
% Atm. Pres. wave min_amplitude (Pascal)
a(1) = str2double(get(handles.min_amplitude,'String'));
b(1) = str2double(get(handles.max_amplitude,'String'));
s(1) = get(handles.imposed_amplitude,'Value');
% Atm. Pres. wave min_direction of propagation (radian)
a(2) = str2double(get(handles.min_direction,'String'));
b(2) = str2double(get(handles.max_direction,'String'));
s(2) = get(handles.imposed_direction,'Value');
% Atm. Pres. wave speed (meter per second)
a(3) = str2double(get(handles.min_speed,'String'));
b(3) = str2double(get(handles.max_speed,'String'));
s(3) = get(handles.imposed_speed,'Value');
% Atm. Pres. wave period (second)
a(4) = str2double(get(handles.min_period,'String'));
b(4) = str2double(get(handles.max_period,'String'));
s(4) = get(handles.imposed_period,'Value');
% Atm. Pres. wave start latitude (degree)
a(5) = str2double(get(handles.min_start_location,'String'));
b(5) = str2double(get(handles.max_start_location,'String'));
s(5) = get(handles.imposed_start_location,'Value');
% Atm. Pres. wave width (meter)
a(6) = str2double(get(handles.min_width,'String'));
b(6) = str2double(get(handles.max_width,'String'));
s(6) = get(handles.imposed_width,'Value');
% number of random samples
nw = 20000;
% generation of the random numbers on [0 1] interval
rng(0,'twister')
seed_01 = rand(nmodes,nw);
% rescaling to fit the appropriate intervals
Zw = repmat(a,1,nw) + repmat((b-a),1,nw).*seed_01;
for i=1:nmodes
    if s(i)== 1
        Zw(i,:)=a(i).*ones(1,nw);
    end
end
waitbar(0.5,h,'Generating Meteotsunami Maximum Elevation')
ar = nan(nmodes,1);
br = nan(nmodes,1);
% Atm. Pres. wave Amplitude (Pascal)
ar(1) = 50.0;
br(1) = 400.0;
% Atm. Pres. wave direction of propagation (radian)
ar(2) = -pi/3;
br(2) =  pi/2;
% Atm. Pres. wave speed (meter per second)
ar(3) = 15.0;
br(3) = 40.0;
% Atm. Pres. wave period (second)
ar(4) =  300.0;
br(4) = 1800.0;
% Atm. Pres. wave start latitude (degree)
ar(5) = 41.25;
br(5) = 43.65;
% Atm. Pres. wave width (meter)
ar(6) =  30000.0;
br(6) = 150000.0;
% Legendre Polynomials up to maxdeg
Le    = cell(maxdeg,1);
Le{1} = 1;       % L_1 = 1
Le{2} = [1 0];   % L_2 = x
for n = 3:maxdeg    
   Le{n} = ((2*n-3)/(n-1))*[Le{n-1} 0] - ((n-2)/(n-1))*[0 0 Le{n-2}];
end
% Computation of the PCE
nx=size(coeff_hat(1).zeta,1);
zeta_max = zeros(nx,nw);
for alpha_norm1 = max(0,nmaxdeg-nmodes+1):nmaxdeg
    % Smolyak coefficient
    C_alpha = (-1).^(nmaxdeg-alpha_norm1).*nchoosek(nmodes-1,nmaxdeg-alpha_norm1);
    % Retrieving the hat coefficients
    alpha    = coeff_hat(alpha_norm1+1).alpha;
    zeta_hat = coeff_hat(alpha_norm1+1).zeta;
    nww      = size(alpha,1);
    for l = 1:nww
        multH = 1;
        for n = 1:nmodes;
            multH = multH.*polyval(Le{alpha(l,n)+1},(2*Zw(n,:)-ar(n)-br(n))./(br(n)-ar(n)));
        end
        for i = 1:nx        
            zeta_max(i,:)= squeeze(zeta_max(i,:))+ C_alpha.*squeeze(zeta_hat(i,l))'*multH;
        end
    end
end
% ignoring values below 0.1m from surrogate model
zeta_max(zeta_max<=0.1)=nan;
% adding the tides
tide=get(handles.imposed_date,'Value');
if tide == 1
    waitbar(0.75,h,'Adding Maximum Tidal Elevation')
    lat = [43.64  ;42.9573;42.37  ;42.1189;41.9074;40.1473;43.5059;43.0345;...
        42.6565;42.3701;42.0814;42.7395;43.1346;42.7395 ;42.9658;42.6362;  ...
        43.1367;43.1367;42.9699;42.8009;42.8009;44.5399;44.271];
    lon = [13.5043;13.902 ;14.4148;15.5016;16.1791;18.52  ;16.4403;17.3984;...
        18.0633;18.6562; 19.062;16.7029;16.5938;17.6202;16.6635;18.0968;   ...
        16.5988;16.5988;17.2053;17.6955;17.6955;14.4416;14.7649];            
    d0=datenum(1992,1,1);
    ds=datenum(str2num(get(handles.year,'String')),str2num(get(handles.month,'String')),str2num(get(handles.day,'String'))); %#ok<*ST2NM>
    d1 = ds + (0:24)/24;
    time = d1-d0;
    day_tide = nan(23,25);
    [amp,pha,~,conList] = tmd_extract_HC('Model_Med',lat,lon,'z',[]);
    for jj = 1:23        
        cph=-1i*pha(:,jj)*pi/180;
        hc=amp(:,jj).*exp(cph);
        hc=squeeze(hc);
        TS=harp1(time,hc,conList);
        dh = InferMinor(hc,conList,d1);
        day_tide(jj,:)= TS + dh;
    end
    max_tide = max(day_tide,[],2);
    zeta_max = zeta_max + repmat(max_tide,1,nw);
else
    max_tide(1:23)=0.;
end
% save final results
if (s(1) == 0)
    output.input_surrogate.amplitude.value  = [a(1) b(1)];
else
    output.input_surrogate.amplitude.value  = a(1);
end
output.input_surrogate.amplitude.units = 'Pa';
output.input_surrogate.amplitude.long_name = 'Amplitude of the Atmospheric Pressure IGW';
if (s(2) == 0)
    output.input_surrogate.direction.value  = [a(2) b(2)].*180/pi;
else
    output.input_surrogate.direction.value  = a(2).*180/pi;
end
output.input_surrogate.direction.units = 'degrees (trigonometric convention)';
output.input_surrogate.direction.long_name = 'Direction of the Atmospheric Pressure IGW';
if (s(3) == 0)
    output.input_surrogate.speed.value  = [a(3) b(3)];
else
    output.input_surrogate.speed.value  = a(3);
end
output.input_surrogate.speed.units = 'm/s';
output.input_surrogate.speed.long_name = 'Speed of the Atmospheric Pressure IGW';
if (s(4) == 0)
    output.input_surrogate.period.value  = [a(4) b(4)];
else
    output.input_surrogate.period.value  = a(4);
end
output.input_surrogate.period.units = 's';
output.input_surrogate.period.long_name = 'Period of the Atmospheric Pressure IGW';
if (s(5) == 0)
    output.input_surrogate.start_latitude.value  = [a(5) b(5)];
else
    output.input_surrogate.start_latitude.value  = a(5);
end
output.input_surrogate.start_latitude.units = '�N';
output.input_surrogate.start_latitude.long_name = 'Start latitude of the Atmospheric Pressure IGW';
if (s(6) == 0)
    output.input_surrogate.width.value  = [a(6) b(6)]./1000;
else
    output.input_surrogate.width.value  = a(6)/1000;
end
output.input_surrogate.width.units = 'km';
output.input_surrogate.width.long_name = 'Width of the Atmospheric Pressure IGW';
output(1).station_name = 'Harbor of Vela Luka';
output(1).zeta_max.value     = zeta_max(15,:);
output(1).tide_max.value     = max_tide(15);
output(2).station_name = 'Harbor of Rijeka Dubrova?ka';
output(2).zeta_max.value     = zeta_max(16,:);
output(2).tide_max.value     = max_tide(16);
output(3).station_name = 'Harbor of Stari Grad';
output(3).zeta_max.value     = zeta_max(17,:);
output(3).tide_max.value     = max_tide(17);
output(4).station_name = 'Harbor of Vrboska';
output(4).zeta_max.value     = zeta_max(18,:);
output(4).tide_max.value     = max_tide(18);
output(5).station_name = 'Harbor of Viganj';
output(5).zeta_max.value     = zeta_max(19,:);
output(5).tide_max.value     = max_tide(19);
output(6).station_name = 'Harbor of Mali Ston';
output(6).zeta_max.value     = zeta_max(20,:);
output(6).tide_max.value     = max_tide(20);
output(7).station_name = 'Harbor of Ston';
output(7).zeta_max.value     = zeta_max(21,:);
output(7).tide_max.value     = max_tide(21);
output(8).station_name = 'Harbor of Mali Lo�inj';
output(8).zeta_max.value     = zeta_max(22,:);
output(8).tide_max.value     = max_tide(22);
output(9).station_name = 'Harbor of Ist';
output(9).zeta_max.value     = zeta_max(23,:);
output(9).tide_max.value     = max_tide(23);
for i = 1:9
    output(i).zeta_max.units = 'm';
    output(i).zeta_max.nan   = 'values under 0.1m';
    output(i).zeta_max.long_name = 'Maximum Meteotsunami Elevation including tide';
    output(i).tide_max.units = 'm';
    output(i).tide_max.long_name = 'Maximum Tidal Elevation extracted with TMD from the Mediterranean OSU model';
end
save surrogate_results.mat output
assignin('base','zeta_max',zeta_max);
waitbar(1)
set(handles.Download_OK,'Value',1)
set(handles.Infos,'String','Select a Station')
close (h)
%--------------------------------------------------------------------------
%% Non visible - to insure everything went OK
function Download_OK_Callback(hObject, eventdata, handles) 
%--------------------------------------------------------------------------
%% Station choice
function Station_Callback(hObject, eventdata, handles)
zoom out
superimpose=get(handles.Superimpose,'Value');
if superimpose == 0 %Remise � z�ro de l'axe de trac�
    delete(findobj(handles.Axe_trace,'Type','Line'))
    axes(handles.Axe_trace)
    legend off    
else
    delete(findobj(handles.Axe_trace,'Type','Legend'))
    delete(findobj(handles.Axe_trace,'Type','Line'))
    set(handles.CDF,'Visible','off')
    set(handles.CDF,'Value',0)
end
delete(findobj(handles.Axe_trace,'Type','Legend'))
set(handles.OK,'Visible','On')
function Station_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%--------------------------------------------------------------------------
%% Display of the distributions 
%--------------------------------------------------------------------------
function OK_Callback(hObject, eventdata, handles) %#ok<*INUSL>
download_ok=get(handles.Download_OK,'String');
download_ok=str2double(download_ok);
if download_ok == 0
    set(handles.Infos,'String','First Download New Data then Select Station')
else
    min_start_location=get(handles.min_start_location,'String');
    min_start_location=str2double(min_start_location);
    max_start_location=get(handles.max_start_location,'String');
    max_start_location=str2double(max_start_location);        
    min_amplitude=get(handles.min_amplitude,'String');
    min_amplitude=str2double(min_amplitude);
    max_amplitude=get(handles.max_amplitude,'String');
    max_amplitude=str2double(max_amplitude);
    min_direction=get(handles.min_direction,'String');
    min_direction=str2double(min_direction);
    max_direction=get(handles.max_direction,'String');
    max_direction=str2double(max_direction);    
    min_speed=get(handles.min_speed,'String');
    min_speed=str2double(min_speed);
    max_speed=get(handles.max_speed,'String');
    max_speed=str2double(max_speed);    
    min_period=get(handles.min_period,'String');
    min_period=str2double(min_period);
    max_period=get(handles.max_period,'String');
    max_period=str2double(max_period);
    min_width=get(handles.min_width,'String');
    min_width=str2double(min_width);
    max_width=get(handles.max_width,'String');
    max_width=str2double(max_width);
    station=get(handles.Station,'Value');
    if or(min_start_location <41.25 , max_start_location>43.65) 
        set(handles.Infos,'String','The choosen value of start location is not within the interval [41.25 43.65]')
    elseif or(min_amplitude <50 , max_amplitude>400)
        set(handles.Infos,'String','The choosen value of  amplitude is not within the interval[50  400]')
    elseif or(min_direction <-pi/3 , max_direction>pi/2)
        set(handles.Infos,'String','The choosen value of direction is not within the interval [-1.0471 1.5707]')
    elseif or(min_speed <15 , max_speed>40)
        set(handles.Infos,'String','The choosen value of speed is not within the interval [15 40]')
    elseif or(min_period <300 , max_period>1800)
        set(handles.Infos,'String','The choosen value of period is not within the interval [300 1800]')
    elseif or(min_width <30000 , max_width>150000)
        set(handles.Infos,'String','The choosen value of width is not within the interval [30000 150000]')
    else
        % test selection of station
        if station == 1
            set(handles.Infos,'String','Select a Station')
        else
            set(handles.CDF,'Visible','On')    
            set(handles.Superimpose,'Visible','On')
            station_name(1,:)='Harbor of Vela Luka        ';
            station_name(2,:)='Harbor of Rijeka Dubrova.  ';
            station_name(3,:)='Harbor of Stari Grad       ';
            station_name(4,:)='Harbor of Vrboska          ';
            station_name(5,:)='Harbor of Viganj           ';
            station_name(6,:)='Harbor of Mali Ston        ';
            station_name(7,:)='Harbor of Ston             ';
            station_name(8,:)='Harbor of Mali Lo�inj      ';
            station_name(9,:)='Harbor of Ist              ';
            superimpose=get(handles.Superimpose,'Value');
            cdf=get(handles.CDF,'Value');
            zeta_max=evalin('base','zeta_max');
            nom_legende=evalin('base','nom_legende');
            if superimpose == 0 % Courbes non surperpos�es
                axes(handles.Axe_trace)
                cla                                
                nom_legende= station_name(station-1,:);
                assignin('base','nom_legende',nom_legende)
                axes(handles.Axe_trace)
                histogram(zeta_max(station+13,:),0:0.1:4,'Normalization','probability');
                if cdf == 1
                     nom_legende=[nom_legende;'Cumulative Density Function'];
                     [f,x] = ecdf(zeta_max(station+13,:));
                     hold on
                     plot(x,f,'r')
                end                
                xlabel('Maximum Elevation (m)')
                ylabel('Probability')               
                legend(nom_legende)
                set(gca,'FontSize',20)
                hold off
            else
                nom_legende=[nom_legende; station_name(station-1,:)];
                assignin('base','nom_legende',nom_legende)
                set(handles.CDF,'Value',0)
                set(handles.CDF,'Visible','Off')
                axes(handles.Axe_trace)
                hold on
                histogram(zeta_max(station+13,:),0:0.1:4,'Normalization','probability');
                xlabel('Maximum Elevation (m)')
                ylabel('Probability')
                set(gca,'FontSize',20)                    
                legend(nom_legende)                
            end
            val = zeta_max(station+13,:);
            val = val(~isnan(val));
            tot = length(val);
            ind_00 = length(find(val >= 0.35))*100/tot;
            ind_05 = length(find(val >= 0.45))*100/tot;
            ind_10 = length(find(val >= 0.55))*100/tot;
            ind_15 = length(find(val >= 0.65))*100/tot;
            ind_20 = length(find(val >= 1.05))*100/tot;
            ind_25 = length(find(val >= 1.55))*100/tot;
            ind_30 = length(find(val >= 2.05))*100/tot;              
            set(handles.per_00,'String',num2str(ceil(ind_00)));
            set(handles.per_05,'String',num2str(ceil(ind_05)));
            set(handles.per_10,'String',num2str(ceil(ind_10)));
            set(handles.per_15,'String',num2str(ceil(ind_15)));
            set(handles.per_20,'String',num2str(ceil(ind_20)));
            set(handles.per_25,'String',num2str(ceil(ind_25)));
            set(handles.per_30,'String',num2str(ceil(ind_30)));
        end
    end
end
set(handles.OK,'Visible','Off')
set(handles.Station,'Value',1)
%--------------------------------------------------------------------------
%% superimpose
%--------------------------------------------------------------------------
function Superimpose_Callback(hObject, eventdata, handles)
val=get(handles.Superimpose,'Value');
if val == 0
    set(handles.CDF,'Visible','On')
end
%--------------------------------------------------------------------------
%% CDF
%--------------------------------------------------------------------------
function CDF_Callback(hObject, eventdata, handles)
%--------------------------------------------------------------------------
%% statistics
%--------------------------------------------------------------------------
function per_00_Callback(hObject, eventdata, handles)
function per_00_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function per_05_Callback(hObject, eventdata, handles)
function per_05_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function per_10_Callback(hObject, eventdata, handles)
function per_10_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function per_15_Callback(hObject, eventdata, handles)
function per_15_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function per_20_Callback(hObject, eventdata, handles)
function per_20_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function per_25_Callback(hObject, eventdata, handles)
function per_25_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function per_30_Callback(hObject, eventdata, handles)
function per_30_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
