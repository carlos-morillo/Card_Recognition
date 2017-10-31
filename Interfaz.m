 function varargout = Interfaz(varargin)
% INTERFAZ MATLAB code for Interfaz.fig
%      INTERFAZ, by itself, creates a new INTERFAZ or raises the existing
%      singleton*.
%
%      H = INTERFAZ returns the handle to a new INTERFAZ or the handle to
%      the existing singleton*.
%
%      INTERFAZ('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERFAZ.M with the given input arguments.
%
%      INTERFAZ('Property','Value',...) creates a new INTERFAZ or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Interfaz_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Interfaz_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Interfaz

% Last Modified by GUIDE v2.5 11-Jan-2016 21:26:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Interfaz_OpeningFcn, ...
                   'gui_OutputFcn',  @Interfaz_OutputFcn, ...
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
function Interfaz_OpeningFcn(hObject, eventdata, handles, varargin)
global vid todo 
handles.output = hObject;
guidata(hObject, handles);
todo = handles;
% CREACION DEL VIDEO
vid = videoinput('winvideo', 2, 'YUY2_640x480');
set(vid,'ReturnedColorSpace','rgb');
set(vid,'TriggerRepeat',Inf);
set(vid,'FramesPerTrigger',1);
vid.FrameGrabInterval = 1;
triggerconfig(vid,'manual');
vidRes = vid.VideoResolution; 
nBands = vid.NumberOfBands; 
hImage = image(zeros(vidRes(2),vidRes(1), nBands),'Parent',handles.axes1);
preview(vid, hImage);


function varargout = Interfaz_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function boton_stop_Callback(hObject, eventdata, handles)

function boton_procesar_Callback(hObject, eventdata, handles)
    global carta vid 

    cla(handles.axes3) 
    set(handles.text2,'String','');
    cla(handles.axes4)
    set(handles.text3,'String','');
    cla(handles.axes5)
    set(handles.text4,'String','');
    cla(handles.axes6)
    set(handles.text5,'String','');
        carta=grabar(vid);


function checkbox1_Callback(hObject, eventdata, handles)


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3
