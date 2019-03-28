function varargout = simpleOrbitGUI(varargin)
% SIMPLEORBITGUI MATLAB code for simpleOrbitGUI.fig
%      SIMPLEORBITGUI, by itself, creates a new SIMPLEORBITGUI or raises the existing
%      singleton*.
%
%      H = SIMPLEORBITGUI returns the handle to a new SIMPLEORBITGUI or the handle to
%      the existing singleton*.
%
%      SIMPLEORBITGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIMPLEORBITGUI.M with the given input arguments.
%
%      SIMPLEORBITGUI('Property','Value',...) creates a new SIMPLEORBITGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before simpleOrbitGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to simpleOrbitGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help simpleOrbitGUI

% Last Modified by GUIDE v2.5 27-Mar-2019 12:10:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @simpleOrbitGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @simpleOrbitGUI_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before simpleOrbitGUI is made visible.
function simpleOrbitGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to simpleOrbitGUI (see VARARGIN)

% Choose default command line output for simpleOrbitGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes simpleOrbitGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = simpleOrbitGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function sldEcc_Callback(hObject, eventdata, handles)
% hObject    handle to sldEcc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value = get(hObject, 'Value');
valueStr = sprintf('%0.3f', value); 
set(handles.txtEccValue, 'String', valueStr);

% --- Executes during object creation, after setting all properties.
function sldEcc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sldEcc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pbGo.
function pbGo_Callback(hObject, eventdata, handles)
% hObject    handle to pbGo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% set(hObject, 'BackgroundColor', 'green');

set(hObject, 'BackgroundColor', 'green', 'String', 'Plotting');

e = get(handles.sldEcc, 'Value');
mu_S = str2double(get(handles.edtSunParam, 'String'))*10^9;
R_S = str2double(get(handles.edtSunRad, 'String'))*10^6;
a = str2double(get(handles.edtSemiAxis, 'String'))*10^6;

thetaArray = {0 pi/4 pi/2 3*pi/4 pi};
theta0 = thetaArray{get(handles.pumTheta, 'Value')};


[r,v,~, ev] = simpleorbit(e, mu_S, R_S, a, theta0);

[sx,sy,sz] = sphere(100);
surf(R_S*sx,R_S*sy,R_S*sz,'EdgeColor','none','FaceColor','y')

hold on
axis equal
grid on
axis([-2*a,2*a,-2*a,2*a,-2*R_S,2*R_S])
% Plot:
% quiver3(0,0,0,h(1,1),h(1,2),h(1,3))
quiver3(0,0,0, ev(1),ev(2),ev(3))
comet3(r(:,1),r(:,2),r(:,3))
quiver3(r(1:10:end,1),r(1:10:end,2),r(1:10:end,3),v(1:10:end,1),v(1:10:end,2),v(1:10:end,3))
set(hObject, 'BackgroundColor', [0.94 0.94 0.94], 'String', 'Go');



% --- Executes on button press in pbClearPlot.
function pbClearPlot_Callback(hObject, eventdata, handles)
% hObject    handle to pbClearPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axOrbitPlt);
cla reset



function edtSunParam_Callback(hObject, eventdata, handles)
% hObject    handle to edtSunParam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtSunParam as text
%        str2double(get(hObject,'String')) returns contents of edtSunParam as a double


% --- Executes during object creation, after setting all properties.
function edtSunParam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtSunParam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtSunRad_Callback(hObject, eventdata, handles)
% hObject    handle to edtSunRad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtSunRad as text
%        str2double(get(hObject,'String')) returns contents of edtSunRad as a double


% --- Executes during object creation, after setting all properties.
function edtSunRad_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtSunRad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtSemiAxis_Callback(hObject, eventdata, handles)
% hObject    handle to edtSemiAxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtSemiAxis as text
%        str2double(get(hObject,'String')) returns contents of edtSemiAxis as a double


% --- Executes during object creation, after setting all properties.
function edtSemiAxis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtSemiAxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pumTheta.
function pumTheta_Callback(hObject, eventdata, handles)
% hObject    handle to pumTheta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pumTheta contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pumTheta


% --- Executes during object creation, after setting all properties.
function pumTheta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pumTheta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
