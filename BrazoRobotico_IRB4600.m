function varargout = BrazoRobotico_IRB4600_v1(varargin)
% BRAZOROBOTICO_IRB4600_V1 MATLAB code for BrazoRobotico_IRB4600_v1.fig
%      BRAZOROBOTICO_IRB4600_V1, by itself, creates a new BRAZOROBOTICO_IRB4600_V1 or raises the existing
%      singleton*.
%
%      H = BRAZOROBOTICO_IRB4600_V1 returns the handle to a new BRAZOROBOTICO_IRB4600_V1 or the handle to
%      the existing singleton*.
%
%      BRAZOROBOTICO_IRB4600_V1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BRAZOROBOTICO_IRB4600_V1.M with the given input arguments.
%
%      BRAZOROBOTICO_IRB4600_V1('Property','Value',...) creates a new BRAZOROBOTICO_IRB4600_V1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BrazoRobotico_IRB4600_v1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BrazoRobotico_IRB4600_v1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BrazoRobotico_IRB4600_v1

% Last Modified by GUIDE v2.5 11-Apr-2022 22:06:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BrazoRobotico_IRB4600_v1_OpeningFcn, ...
                   'gui_OutputFcn',  @BrazoRobotico_IRB4600_v1_OutputFcn, ...
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


% --- Executes just before BrazoRobotico_IRB4600_v1 is made visible.
function BrazoRobotico_IRB4600_v1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BrazoRobotico_IRB4600_v1 (see VARARGIN)

movegui([-40,-125]);

LogoFI = imread('LogoFI.jpg');
axes(handles.LogoFI);
imshow(LogoFI); 

LogoIA = imread('LogoIA.jpg');
axes(handles.LogoIA);
imshow(LogoIA);

EscudoUAQ = imread('EscudoUAQ.jpg');
axes(handles.EscudoUAQ);
imshow(EscudoUAQ);

EscudoFI = imread('EscudoFI.jpg');
axes(handles.EscudoFI);
imshow(EscudoFI);

ImgIRB = imread('Gradosdelibertad.JPG');
axes(handles.Img_IRB4600);
imshow(ImgIRB);

Btn_LimpiarTabla_Callback(hObject, eventdata, handles)

% Choose default command line output for BrazoRobotico_IRB4600_v1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

global IRB4600 fig ...  % Objeto con el cual se instancia el mundo virtual del brazo robótico creado en VRLBuilder
    Grado1 Grado2 Grado3 Grado4 Grado5 Grado6 ... % Variables para instanciar Cada una de las piezas del mundo virtual.
    Rotation_Grado1 Rotation_Grado2 Rotation_Grado3 Rotation_Grado4 Rotation_Grado5 Rotation_Grado6 ... %Varibles que almacenaran los vectores de rotación de cada pieza en el brazo robótico
    Valor_Grado1 Valor_Grado2 Valor_Grado3 Valor_Grado4 Valor_Grado5 Valor_Grado6... % Variables para almacenar los valores.
    A_Valor_Grado1 A_Valor_Grado2 A_Valor_Grado3 A_Valor_Grado4 A_Valor_Grado5 A_Valor_Grado6... % Variables para almacenar los valores obtenidos  anitguos.
    DataTabla s i A_i n Stop Step ... % Variable para almacenar información en la Tabla
    PositionGrado1 PositionGrado2 PositionGrado3 PositionGrado4 PositionGrado5 PositionGrado6 ...   % Variables para almacenar el valor del ángulo en radianes
    A_PositionGrado1 A_PositionGrado2 A_PositionGrado3 A_PositionGrado4 A_PositionGrado5 A_PositionGrado6 ...
    Viewpoint...

% Inicializar varibles.
DataTabla = [];
s = 0.0;
i = 0.19;
n = 0;
Stop = 0;
A_i = 0.19;
Step = 0.1;
Viewpoint = 1;
%%%%%%%%%%%%%%%%%%%%%%%

axis off

IRB4600 = vrworld('IRB4600.WRL','new');%

open(IRB4600);
fig=vrfigure(IRB4600);    %Cargando Mundo VRML
set(fig,'Position',[40 300 800 500]);
set(fig,'Headlight','off');
set(fig,'Name','Brazo Robótico - IRB4600 - Mecatrónica 2022-1 ')

% Iniciar el brazo robótico en una posición
IRB4600.Pieza_A.rotation = [0 0 1 deg2rad(-5) ];
IRB4600.Pieza_B.rotation = [0 1 0 deg2rad(-35) ];
IRB4600.Pieza_C.rotation = [0 1 0 deg2rad(25) ];

set(fig,'ZoomFactor',0.8);
set(fig,'NavMode','Examine');

% set(fig,'Viewpoint','Frente');
% set(fig,'Viewpoint','Superior');
% set(fig,'Viewpoint','Isometrico');
set(fig,'Viewpoint','Inicio');

% Instanciar cada pieza del mundo virtual
Grado1 = vrnode(IRB4600,'Pieza_A'); %cargando nodo de VRML
Grado2 = vrnode(IRB4600,'Pieza_B');
Grado3 = vrnode(IRB4600,'Pieza_C');
Grado4 = vrnode(IRB4600,'Pieza_D');
Grado5 = vrnode(IRB4600,'Pieza_E');
Grado6 = vrnode(IRB4600,'Pieza_F');

set(handles.Edit_Grado1,'String','');
set(handles.Edit_Grado2,'String','');
set(handles.Edit_Grado3,'String','');
set(handles.Edit_Grado4,'String','');
set(handles.Edit_Grado5,'String','');
set(handles.Edit_Grado6,'String','');

%x = nodes(IRB4600, '-full');

Rotation_Grado1 = getfield( IRB4600.Pieza_A, 'rotation' );
Rotation_Grado2 = getfield( IRB4600.Pieza_B, 'rotation' );
Rotation_Grado3 = getfield( IRB4600.Pieza_C, 'rotation' );
Rotation_Grado4 = getfield( IRB4600.Pieza_D, 'rotation' );
Rotation_Grado5 = getfield( IRB4600.Pieza_E, 'rotation' );
Rotation_Grado6 = getfield( IRB4600.Pieza_F, 'rotation' );

% Iniciar las etiquetas con el valor del ángulo que tiene cada Pieza.

set(handles.Slider_Grado1,'Value', rad2deg(Rotation_Grado1(4)) );
set(handles.Slider_Grado2,'Value', rad2deg(Rotation_Grado2(4)) );
set(handles.Slider_Grado3,'Value', rad2deg(Rotation_Grado3(4)) );
set(handles.Slider_Grado4,'Value', rad2deg(Rotation_Grado4(4)) );
set(handles.Slider_Grado5,'Value', rad2deg(Rotation_Grado5(4)) );
set(handles.Slider_Grado6,'Value', rad2deg(Rotation_Grado6(4)) );

set(handles.Text_Grado1,'String', get(handles.Slider_Grado1,'Value') );
set(handles.Text_Grado2,'String', get(handles.Slider_Grado2,'Value') );
set(handles.Text_Grado3,'String', get(handles.Slider_Grado3,'Value') );
set(handles.Text_Grado4,'String', get(handles.Slider_Grado4,'Value') );
set(handles.Text_Grado5,'String', get(handles.Slider_Grado5,'Value') );
set(handles.Text_Grado6,'String', get(handles.Slider_Grado6,'Value') );

Valor_Grado1 = rad2deg(Rotation_Grado1(4));
Valor_Grado2 = rad2deg(Rotation_Grado2(4));
Valor_Grado3 = rad2deg(Rotation_Grado3(4));
Valor_Grado4 = rad2deg(Rotation_Grado4(4));
Valor_Grado5 = rad2deg(Rotation_Grado5(4));
Valor_Grado6 = rad2deg(Rotation_Grado6(4));

A_Valor_Grado1 = Valor_Grado1;
A_Valor_Grado2 = Valor_Grado2;
A_Valor_Grado3 = Valor_Grado3;
A_Valor_Grado4 = Valor_Grado4;
A_Valor_Grado5 = Valor_Grado5;
A_Valor_Grado6 = Valor_Grado6;

PositionGrado1 = Rotation_Grado1(4);
PositionGrado2 = Rotation_Grado2(4);
PositionGrado3 = Rotation_Grado3(4);
PositionGrado4 = Rotation_Grado4(4);
PositionGrado5 = Rotation_Grado5(4);
PositionGrado6 = Rotation_Grado6(4);

A_PositionGrado1 = PositionGrado1;
A_PositionGrado2 = PositionGrado2;
A_PositionGrado3 = PositionGrado3;
A_PositionGrado4 = PositionGrado4;
A_PositionGrado5 = PositionGrado5;
A_PositionGrado6 = PositionGrado6;

% UIWAIT makes BrazoRobotico_IRB4600_v1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = BrazoRobotico_IRB4600_v1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function Slider_Grado1_Callback(hObject, eventdata, handles)
% hObject    handle to Slider_Grado1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global IRB4600 Grado1 Valor_Grado1 A_Valor_Grado1

A_Valor_Grado1 = Valor_Grado1;      %% Valor antiguo se queda con el valor actual antes de actualizarse
Valor_Grado1 = get(hObject,'Value');
Valor_Grado1 = floor(Valor_Grado1);
Grado1.rotation = [ 0 0 1 deg2rad(Valor_Grado1) ];
set(handles.Text_Grado1,'String',Valor_Grado1);  % Escribe el valor del ángulo seleccionado en el Texto Estático
vrdrawnow;

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function Slider_Grado1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Slider_Grado1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Slider_Grado2_Callback(hObject, eventdata, handles)
% hObject    handle to Slider_Grado2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global IRB4600 Grado2 Valor_Grado2 A_Valor_Grado2

A_Valor_Grado2 = Valor_Grado2;
Valor_Grado2 = get(hObject,'Value');
Valor_Grado2 = floor(Valor_Grado2);
Grado2.rotation = [ 0 1 0 deg2rad(Valor_Grado2) ];
set(handles.Text_Grado2,'String',Valor_Grado2);  % Escribe el valor del ángulo seleccionado en el Texto Estático
vrdrawnow;

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function Slider_Grado2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Slider_Grado2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Slider_Grado3_Callback(hObject, eventdata, handles)
% hObject    handle to Slider_Grado3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global IRB4600 Grado3 Valor_Grado3 A_Valor_Grado3

A_Valor_Grado3 = Valor_Grado3;
Valor_Grado3 = get(hObject,'Value');
Valor_Grado3 = round(Valor_Grado3);
Grado3.rotation = [ 0 1 0 deg2rad(Valor_Grado3) ];
set(handles.Text_Grado3,'String',Valor_Grado3);  % Escribe el valor del ángulo seleccionado en el Texto Estático
vrdrawnow;

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function Slider_Grado3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Slider_Grado3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Slider_Grado4_Callback(hObject, eventdata, handles)
% hObject    handle to Slider_Grado4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global IRB4600 Grado4 Valor_Grado4 A_Valor_Grado4

A_Valor_Grado4 = Valor_Grado4;
Valor_Grado4 = get(hObject,'Value');
Valor_Grado4 = round(Valor_Grado4);
Grado4.rotation = [ 1 0 0 deg2rad(Valor_Grado4) ];
set(handles.Text_Grado4,'String',Valor_Grado4);  % Escribe el valor del ángulo seleccionado en el Texto Estático
vrdrawnow;

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function Slider_Grado4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Slider_Grado4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Slider_Grado5_Callback(hObject, eventdata, handles)
% hObject    handle to Slider_Grado5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global IRB4600 Grado5  Valor_Grado5 A_Valor_Grado5

A_Valor_Grado5 = Valor_Grado5;
Valor_Grado5 = get(hObject,'Value');
Valor_Grado5 = round(Valor_Grado5);
Grado5.rotation = [ 0 1 0 deg2rad(Valor_Grado5) ];
set(handles.Text_Grado5,'String',Valor_Grado5);  % Escribe el valor del ángulo seleccionado en el Texto Estático
vrdrawnow;

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function Slider_Grado5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Slider_Grado5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Slider_Grado6_Callback(hObject, eventdata, handles)
% hObject    handle to Slider_Grado6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global IRB4600 Grado6 Valor_Grado6 A_Valor_Grado6

A_Valor_Grado6 = Valor_Grado6;
Valor_Grado6 = get(hObject,'Value');
Valor_Grado6 = round(Valor_Grado6);
Grado6.rotation = [ 1 0 0 deg2rad(Valor_Grado6) ];
set(handles.Text_Grado6,'String',Valor_Grado6);  % Escribe el valor del ángulo seleccionado en el Texto Estático
vrdrawnow;

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function Slider_Grado6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Slider_Grado6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function Edit_Grado1_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Grado1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global IRB4600 Grado1 Valor_Grado1 A_Valor_Grado1 

Valor_Grado1 = str2double( get(hObject,'String') );
set(handles.Edit_Grado1,'String','');   % Limpiar la caja de texto después de ingresar el valor.

if isnan( Valor_Grado1 )
    errordlg('El valor debe ser numérico','ERROR');
    return;
end

Valor_Grado1 = round( Valor_Grado1 );

if (Valor_Grado1 < -180) || (Valor_Grado1 > 180)
    errordlg('El Rango es incorrecto (-180° a 180°)','ERROR');
    return;
end

AnimacionEdit_Callback(hObject, eventdata, handles)

A_Valor_Grado1 = Valor_Grado1;


% Hints: get(hObject,'String') returns contents of Edit_Grado1 as text
%        str2double(get(hObject,'String')) returns contents of Edit_Grado1 as a double


% --- Executes during object creation, after setting all properties.
function Edit_Grado1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Grado1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_Grado2_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Grado2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global IRB4600 Grado2 Valor_Grado2 A_Valor_Grado2

Valor_Grado2 = str2double( get(hObject,'String') );
set(handles.Edit_Grado2,'String','');   % Limpiar la caja de texto después de ingresar el valor.

if isnan( Valor_Grado2 )
    errordlg('El valor debe ser numérico','ERROR');
    return;
end

Valor_Grado2 = round( Valor_Grado2 );

if (Valor_Grado2 < -90) || (Valor_Grado2 > 150)
    errordlg('El Rango es incorrecto (-90° a 150°)','ERROR');
    return;
end

AnimacionEdit_Callback(hObject, eventdata, handles)

A_Valor_Grado2 = Valor_Grado2;

% Hints: get(hObject,'String') returns contents of Edit_Grado2 as text
%        str2double(get(hObject,'String')) returns contents of Edit_Grado2 as a double


% --- Executes during object creation, after setting all properties.
function Edit_Grado2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Grado2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_Grado3_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Grado3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global IRB4600 Grado3 Valor_Grado3 A_Valor_Grado3

Valor_Grado3 = str2double( get(hObject,'String') );
set(handles.Edit_Grado3,'String','');   % Limpiar la caja de texto después de ingresar el valor.

if isnan( Valor_Grado3 )
    errordlg('El valor debe ser numérico','ERROR');
    return;
end

Valor_Grado3 = round( Valor_Grado3 );

if (Valor_Grado3 < -180) || (Valor_Grado3 > 75)
    errordlg('El Rango es incorrecto (-180° a 75°)','ERROR');
    return;
end

AnimacionEdit_Callback(hObject, eventdata, handles)

A_Valor_Grado3 = Valor_Grado3;

% Hints: get(hObject,'String') returns contents of Edit_Grado3 as text
%        str2double(get(hObject,'String')) returns contents of Edit_Grado3 as a double


% --- Executes during object creation, after setting all properties.
function Edit_Grado3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Grado3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_Grado4_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Grado4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global IRB4600 Grado4 Valor_Grado4 A_Valor_Grado4

Valor_Grado4 = str2double( get(hObject,'String') );
set(handles.Edit_Grado4,'String','');   % Limpiar la caja de texto después de ingresar el valor.

if isnan( Valor_Grado4 )
    errordlg('El valor debe ser numérico','ERROR');
    return;
end

Valor_Grado4 = round( Valor_Grado4 );

if (Valor_Grado4 < -180) || (Valor_Grado4 > 180)
    errordlg('El Rango es incorrecto (-180° a 180°)','ERROR');
    return;
end

AnimacionEdit_Callback(hObject, eventdata, handles)

A_Valor_Grado4 = Valor_Grado4;

% Hints: get(hObject,'String') returns contents of Edit_Grado4 as text
%        str2double(get(hObject,'String')) returns contents of Edit_Grado4 as a double


% --- Executes during object creation, after setting all properties.
function Edit_Grado4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Grado4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_Grado5_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Grado5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global IRB4600 Grado5 Valor_Grado5 A_Valor_Grado5

Valor_Grado5 = str2double( get(hObject,'String') );
set(handles.Edit_Grado5,'String','');   % Limpiar la caja de texto después de ingresar el valor.

if isnan( Valor_Grado5 )
    errordlg('El valor debe ser numérico','ERROR');
    return;
end

Valor_Grado5 = round( Valor_Grado5 );

if (Valor_Grado5 < -120) || (Valor_Grado5 > 125)
    errordlg('El Rango es incorrecto (-120° a 125°)','ERROR');
    return;
end

AnimacionEdit_Callback(hObject, eventdata, handles)

A_Valor_Grado5 = Valor_Grado5;

% Hints: get(hObject,'String') returns contents of Edit_Grado5 as text
%        str2double(get(hObject,'String')) returns contents of Edit_Grado5 as a double


% --- Executes during object creation, after setting all properties.
function Edit_Grado5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Grado5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_Grado6_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Grado6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global IRB4600 Grado6 Valor_Grado6 A_Valor_Grado6

Valor_Grado6 = str2double( get(hObject,'String') );
set(handles.Edit_Grado6,'String','');   % Limpiar la caja de texto después de ingresar el valor.

if isnan( Valor_Grado6 )
    errordlg('El valor debe ser numérico','ERROR');
    return;
end

Valor_Grado6 = round( Valor_Grado6 );

if (Valor_Grado6 < -180) || (Valor_Grado6 > 180)
    errordlg('El Rango es incorrecto (-180° a 180°)','ERROR');
    return;
end

AnimacionEdit_Callback(hObject, eventdata, handles)

A_Valor_Grado6 = Valor_Grado6;

% Hints: get(hObject,'String') returns contents of Edit_Grado6 as text
%        str2double(get(hObject,'String')) returns contents of Edit_Grado6 as a double


% --- Executes during object creation, after setting all properties.
function Edit_Grado6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Grado6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Btn_GuardarSecuencia.
function Btn_GuardarSecuencia_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_GuardarSecuencia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global IRB4600 Grado1 Grado2 Grado3 Grado4 Grado5 Grado6 ...
    Rotation_Grado1 Rotation_Grado2 Rotation_Grado3 Rotation_Grado4 Rotation_Grado5 Rotation_Grado6 ... %Varibles que almacenaran los vectores de rotación de cada pieza en el brazo robótico
    PositionGrado1 PositionGrado2 PositionGrado3 PositionGrado4 PositionGrado5 PositionGrado6 ...
    A_PositionGrado1 A_PositionGrado2 A_PositionGrado3 A_PositionGrado4 A_PositionGrado5 A_PositionGrado6 ...
    n n0 DataTabla    ... % Variable para almacenar información de la tabla
    
Rotation_Grado1 = getfield( IRB4600.Pieza_A, 'rotation' );
Rotation_Grado2 = getfield( IRB4600.Pieza_B, 'rotation' );
Rotation_Grado3 = getfield( IRB4600.Pieza_C, 'rotation' );
Rotation_Grado4 = getfield( IRB4600.Pieza_D, 'rotation' );
Rotation_Grado5 = getfield( IRB4600.Pieza_E, 'rotation' );
Rotation_Grado6 = getfield( IRB4600.Pieza_F, 'rotation' );

PositionGrado1 = Rotation_Grado1(4);
PositionGrado2 = Rotation_Grado2(4);
PositionGrado3 = Rotation_Grado3(4);
PositionGrado4 = Rotation_Grado4(4);
PositionGrado5 = Rotation_Grado5(4);
PositionGrado6 = Rotation_Grado6(4);

if( (PositionGrado1 == A_PositionGrado1) && (PositionGrado2 == A_PositionGrado2) && (PositionGrado3 == A_PositionGrado3) && (PositionGrado4 == A_PositionGrado4) && (PositionGrado5 == A_PositionGrado5) && (PositionGrado6 == A_PositionGrado6) )
    return;
end
% --    CONSIDERAR QUE NO SE GUARDE LA MISMA POSICIÓN, POR LO QUE:

% Considerar que se debe de tener en cuenta que el nuevo ángulo de cada
% pieza no haya sido modificada por el control deslizante o por la caja de
% texto

n=n+1;  % Aumentar el número de posiciónes

n0=1:n; %Creando Filas 

%ingresando datos 
DataTabla(n0,1)=n0;
DataTabla(n,2) = rad2deg( PositionGrado1 );
DataTabla(n,3) = rad2deg( PositionGrado2 );
DataTabla(n,4) = rad2deg( PositionGrado3 );
DataTabla(n,5) = rad2deg( PositionGrado4 );
DataTabla(n,6) = rad2deg( PositionGrado5 );
DataTabla(n,7) = rad2deg( PositionGrado6 );

set(handles.Tabla,'Data',DataTabla);

A_PositionGrado1 = PositionGrado1;
A_PositionGrado2 = PositionGrado2;
A_PositionGrado3 = PositionGrado3;
A_PositionGrado4 = PositionGrado4;
A_PositionGrado5 = PositionGrado5;
A_PositionGrado6 = PositionGrado6;

% --- Executes on button press in Btn_LimpiarTabla.
function Btn_LimpiarTabla_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_LimpiarTabla (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global n DataTabla 
n=0;
DataTabla =[];%tabla en cero
set(handles.Tabla,'Data',DataTabla);


% --- Executes on button press in Btn_PosicionInicial.
function Btn_PosicionInicial_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_PosicionInicial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global IRB4600 fig ...  % Objeto con el cual se instancia el mundo virtual del brazo robótico creado en VRLBuilder
    Valor_Grado1 Valor_Grado2 Valor_Grado3 Valor_Grado4 Valor_Grado5 Valor_Grado6... % Variables para almacenar los valores.
    Viewpoint...
    
set(fig,'ZoomFactor',0.6);

Valor_Grado1 = -5;
Valor_Grado2 = -35;
Valor_Grado3 = 25;
Valor_Grado4 = 0;
Valor_Grado5 = 0;
Valor_Grado6 = 0;

Viewpoint = 2;
SelectViewpoint_Callback( hObject, eventdata, handles );

AnimacionEdit_Callback( hObject, eventdata, handles );


% --- Executes on button press in Btn_Demostracion.
function Btn_Demostracion_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_Demostracion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global IRB4600 fig ...  % Objeto con el cual se instancia el mundo virtual del brazo robótico creado en VRLBuilder
    Valor_Grado1 Valor_Grado2 Valor_Grado3 Valor_Grado4 Valor_Grado5 Valor_Grado6... % Variables para almacenar los valores.
    Viewpoint...

Btn_PosicionInicial_Callback(hObject, eventdata, handles);

Valor_Grado1 = 0;
Valor_Grado2 = -30;
Valor_Grado3 = -90;
Valor_Grado4 = -180;
Valor_Grado5 = -90;
Valor_Grado6 = 180;

set(fig,'ZoomFactor',0.8);
Viewpoint = 4;
SelectViewpoint_Callback( hObject, eventdata, handles );

Animacion_Callback( hObject, eventdata, handles );

Valor_Grado1 = -180;
Valor_Grado2 = -30;
Valor_Grado3 = -90;
Valor_Grado4 = -180;
Valor_Grado5 = -90;
Valor_Grado6 = 180;

set(fig,'ZoomFactor',0.8);
Viewpoint = 2;
SelectViewpoint_Callback( hObject, eventdata, handles );

Animacion_Callback( hObject, eventdata, handles );

Valor_Grado1 = -180;
Valor_Grado2 = -90;
Valor_Grado3 = 0;
Valor_Grado4 = 180;
Valor_Grado5 = -90;
Valor_Grado6 = 0;

set(fig,'ZoomFactor',0.8);
Viewpoint = 3;
SelectViewpoint_Callback( hObject, eventdata, handles );

Animacion_Callback( hObject, eventdata, handles );

Valor_Grado1 = 180;
Valor_Grado2 = -90;
Valor_Grado3 = 0;
Valor_Grado4 = 180;
Valor_Grado5 = -90;
Valor_Grado6 = 0;

set(fig,'ZoomFactor',0.8);
Viewpoint = 4;
SelectViewpoint_Callback( hObject, eventdata, handles );

Animacion_Callback( hObject, eventdata, handles );

Valor_Grado1 = 180;
Valor_Grado2 = -90;
Valor_Grado3 = 75;
Valor_Grado4 = 180;
Valor_Grado5 = 75;
Valor_Grado6 = 45;

set(fig,'ZoomFactor',0.8);
Viewpoint = 4;
SelectViewpoint_Callback( hObject, eventdata, handles );

Animacion_Callback( hObject, eventdata, handles );

Valor_Grado1 = 180;
Valor_Grado2 = 0;
Valor_Grado3 = 75;
Valor_Grado4 = 180;
Valor_Grado5 = 75;
Valor_Grado6 = 90;

set(fig,'ZoomFactor',0.8);
Viewpoint = 2;
SelectViewpoint_Callback( hObject, eventdata, handles );

Animacion_Callback( hObject, eventdata, handles );

Valor_Grado1 = 90;
Valor_Grado2 = 0;
Valor_Grado3 = 75;
Valor_Grado4 = 180;
Valor_Grado5 = 75;
Valor_Grado6 = 90;

set(fig,'ZoomFactor',0.8);
Viewpoint = 1;
SelectViewpoint_Callback( hObject, eventdata, handles );

Animacion_Callback( hObject, eventdata, handles );

% --- Executes on button press in Btn_EjecutarSecuencia.
function Btn_EjecutarSecuencia_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_EjecutarSecuencia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global IRB4600 fig DataTabla n...  % Objeto con el cual se instancia el mundo virtual del brazo robótico creado en VRLBuilder
    Valor_Grado1 Valor_Grado2 Valor_Grado3 Valor_Grado4 Valor_Grado5 Valor_Grado6... % Variables para almacenar los valores.

Btn_PosicionInicial_Callback(hObject, eventdata, handles);

for i = 1 : n
    DataTabla(i,1)=-i;
    set(handles.Tabla,'Data',DataTabla);
    Valor_Grado1 = DataTabla(i,2);
    Valor_Grado2 = DataTabla(i,3);
    Valor_Grado3 = DataTabla(i,4);
    Valor_Grado4 = DataTabla(i,5);
    Valor_Grado5 = DataTabla(i,6);
    Valor_Grado6 = DataTabla(i,7);

    Animacion_Callback( hObject, eventdata, handles );
end

for i = 1 : n
    DataTabla(i,1)=i;
    set(handles.Tabla,'Data',DataTabla);
end




% --- Executes on button press in Btn_Detener.
function Btn_Detener_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_Detener (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Función que permite ejecutar la animación de las piezas de acuerdo a
% los nuevos valores de ángulo capturados.
function AnimacionEdit_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_Detener (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global IRB4600 Grado1 Grado2 Grado3 Grado4 Grado5 Grado6 ...
    Rotation_Grado1 Rotation_Grado2 Rotation_Grado3 Rotation_Grado4 Rotation_Grado5 Rotation_Grado6 ... %Varibles que almacenaran los vectores de rotación de cada pieza en el brazo robótico
    Valor_Grado1 Valor_Grado2 Valor_Grado3 Valor_Grado4 Valor_Grado5 Valor_Grado6... % Variables para almacenar los valores.
    A_Valor_Grado1 A_Valor_Grado2 A_Valor_Grado3 A_Valor_Grado4 A_Valor_Grado5 A_Valor_Grado6... % Variables para almacenar los valores obtenidos  anitguos.
    Step

Step = 0.5;

% Deshabilitar los botones para que no se ejecute otra función.
set(handles.Btn_GuardarSecuencia,'Enable','off');
set(handles.Btn_Demostracion,'Enable','off');
set(handles.Btn_Detener,'Enable','off');
set(handles.Btn_EjecutarSecuencia,'Enable','off');
set(handles.Btn_LimpiarTabla,'Enable','off');
set(handles.Btn_PosicionInicial,'Enable','off');
% set(handles.Btn_AnteriorViewpoint,'Enable','off');
% set(handles.Btn_SiguienteViewpoint,'Enable','off');

% set(handles.Slider_Grado1,'Enable','off');
% set(handles.Slider_Grado2,'Enable','off');
% set(handles.Slider_Grado3,'Enable','off');
% set(handles.Slider_Grado4,'Enable','off');
% set(handles.Slider_Grado5,'Enable','off');
% set(handles.Slider_Grado6,'Enable','off');

%--- OBTENER EL ÁNGULO EN EL QUE SE ENCUENTRA CADA PIEZA
Rotation_Grado1 = getfield( IRB4600.Pieza_A, 'rotation' );
Rotation_Grado2 = getfield( IRB4600.Pieza_B, 'rotation' );
Rotation_Grado3 = getfield( IRB4600.Pieza_C, 'rotation' );
Rotation_Grado4 = getfield( IRB4600.Pieza_D, 'rotation' );
Rotation_Grado5 = getfield( IRB4600.Pieza_E, 'rotation' );
Rotation_Grado6 = getfield( IRB4600.Pieza_F, 'rotation' );

%--- CONDICIÓN PARA EL PRIMER GRADO
if( Valor_Grado1 ~= A_Valor_Grado1)
    if( (Valor_Grado1 - rad2deg( Rotation_Grado1(4) ) ) >= 0  )
        for i = rad2deg( Rotation_Grado1(4) ): Step : Valor_Grado1
            Grado1.rotation = [0 0 1 deg2rad(i)];
            set(handles.Text_Grado1, 'String', round(i) );
            set(handles.Slider_Grado1,'Value', round(i) );

            vrdrawnow;
        end
    else
       for i = rad2deg( Rotation_Grado1(4) ): -Step : Valor_Grado1
            Grado1.rotation = [0 0 1 deg2rad(i)];
            set(handles.Text_Grado1, 'String', round(i) );
            set(handles.Slider_Grado1,'Value', round(i) );

            vrdrawnow;
        end 
    end
end


%--- CONDICIÓN PARA EL SEGUNDO GRADO
if( Valor_Grado2 ~= A_Valor_Grado2)
    if( (Valor_Grado2 - rad2deg( Rotation_Grado2(4) ) ) >= 0  )
        for i = rad2deg( Rotation_Grado2(4) ): Step : Valor_Grado2
            Grado2.rotation = [0 1 0 deg2rad(i)];
            set(handles.Text_Grado2, 'String', round(i) );
            set(handles.Slider_Grado2,'Value', round(i) );

            vrdrawnow;
        end
    else
       for i = rad2deg( Rotation_Grado2(4) ): -Step : Valor_Grado2
            Grado2.rotation = [0 1 0 deg2rad(i)];
            set(handles.Text_Grado2, 'String', round(i) );
            set(handles.Slider_Grado2,'Value', round(i) );

            vrdrawnow;
        end 
    end
end

%--- CONDICIÓN PARA EL TERCER GRADO
if( Valor_Grado3 ~= A_Valor_Grado3)
    if( (Valor_Grado3 - rad2deg( Rotation_Grado3(4) ) ) >= 0  )
        for i = rad2deg( Rotation_Grado3(4) ): Step : Valor_Grado3
            Grado3.rotation = [0 1 0 deg2rad(i)];
            set(handles.Text_Grado3, 'String', round(i) );
            set(handles.Slider_Grado3,'Value', round(i) );

            vrdrawnow;
        end
    else
       for i = rad2deg( Rotation_Grado3(4) ): -Step : Valor_Grado3
            Grado3.rotation = [0 1 0 deg2rad(i)];
            set(handles.Text_Grado3, 'String', round(i) );
            set(handles.Slider_Grado3,'Value', round(i) );

            vrdrawnow;
        end 
    end
end

%--- CONDICIÓN PARA EL CUARTO GRADO
if( Valor_Grado4 ~= A_Valor_Grado4)
    if( (Valor_Grado4 - rad2deg( Rotation_Grado4(4) ) ) >= 0  )
        for i = rad2deg( Rotation_Grado4(4) ): Step : Valor_Grado4
            Grado4.rotation = [1 0 0 deg2rad(i)];
            set(handles.Text_Grado4, 'String', round(i) );
            set(handles.Slider_Grado4,'Value', round(i) );

            vrdrawnow;
        end
    else
       for i = rad2deg( Rotation_Grado4(4) ): -Step : Valor_Grado4
            Grado4.rotation = [1 0 0 deg2rad(i)];
            set(handles.Text_Grado4, 'String', round(i) );
            set(handles.Slider_Grado4,'Value', round(i) );

            vrdrawnow;
        end 
    end
end

%--- CONDICIÓN PARA EL QUINTO GRADO
if( Valor_Grado5 ~= A_Valor_Grado5)
    if( (Valor_Grado5 - rad2deg( Rotation_Grado5(4) ) ) >= 0  )
        for i = rad2deg( Rotation_Grado5(4) ): Step : Valor_Grado5
            Grado5.rotation = [0 1 0 deg2rad(i)];
            set(handles.Text_Grado5, 'String', round(i) );
            set(handles.Slider_Grado5,'Value', round(i) );

            vrdrawnow;
        end
    else
       for i = rad2deg( Rotation_Grado5(4) ): -Step : Valor_Grado5
            Grado5.rotation = [0 1 0 deg2rad(i)];
            set(handles.Text_Grado5, 'String', round(i) );
            set(handles.Slider_Grado5,'Value', round(i) );

            vrdrawnow;
        end 
    end
end

%--- CONDICIÓN PARA EL SEXTO GRADO
if( Valor_Grado6 ~= A_Valor_Grado6)
    if( (Valor_Grado6 - rad2deg( Rotation_Grado6(4) ) ) >= 0  )
        for i = rad2deg( Rotation_Grado6(4) ): Step : Valor_Grado6
            Grado6.rotation = [1 0 0 deg2rad(i)];
            set(handles.Text_Grado6, 'String', round(i) );
            set(handles.Slider_Grado6,'Value', round(i) );

            vrdrawnow;
        end
    else
       for i = rad2deg( Rotation_Grado6(4) ): -Step : Valor_Grado6
            Grado6.rotation = [1 0 0 deg2rad(i)];
            set(handles.Text_Grado6, 'String', round(i) );
            set(handles.Slider_Grado6,'Value', round(i) );

            vrdrawnow;
        end 
    end
end

A_Valor_Grado1 = Valor_Grado1;
A_Valor_Grado2 = Valor_Grado2;
A_Valor_Grado3 = Valor_Grado3;
A_Valor_Grado4 = Valor_Grado4;
A_Valor_Grado5 = Valor_Grado5;
A_Valor_Grado6 = Valor_Grado6;

% Habilitar los botones y sliders

set(handles.Btn_GuardarSecuencia,'Enable','on');
set(handles.Btn_Demostracion,'Enable','on');
set(handles.Btn_Detener,'Enable','on');
set(handles.Btn_EjecutarSecuencia,'Enable','on');
set(handles.Btn_LimpiarTabla,'Enable','on');
set(handles.Btn_PosicionInicial,'Enable','on');
% set(handles.Btn_AnteriorViewpoint,'Enable','on');
% set(handles.Btn_SiguienteViewpoint,'Enable','on');

% set(handles.Slider_Grado1,'Enable','on');
% set(handles.Slider_Grado2,'Enable','on');
% set(handles.Slider_Grado3,'Enable','on');
% set(handles.Slider_Grado4,'Enable','on');
% set(handles.Slider_Grado5,'Enable','on');
% set(handles.Slider_Grado6,'Enable','on');

function Animacion_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_Detener (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global IRB4600 Grado1 Grado2 Grado3 Grado4 Grado5 Grado6 ...
    Rotation_Grado1 Rotation_Grado2 Rotation_Grado3 Rotation_Grado4 Rotation_Grado5 Rotation_Grado6 ... %Varibles que almacenaran los vectores de rotación de cada pieza en el brazo robótico
    Valor_Grado1 Valor_Grado2 Valor_Grado3 Valor_Grado4 Valor_Grado5 Valor_Grado6... % Variables para almacenar los valores.
    A_Valor_Grado1 A_Valor_Grado2 A_Valor_Grado3 A_Valor_Grado4 A_Valor_Grado5 A_Valor_Grado6... % Variables para almacenar los valores obtenidos  anitguos.
    Step

Step = 2;

G1 = [];
G2 = [];
G3 = [];
G4 = [];
G5 = [];
G6 = [];
G = [];
i_max = 0;

% Deshabilitar los botones para que no se ejecute otra función.
set(handles.Btn_GuardarSecuencia,'Enable','off');
set(handles.Btn_Demostracion,'Enable','off');
set(handles.Btn_Detener,'Enable','off');
set(handles.Btn_EjecutarSecuencia,'Enable','off');
set(handles.Btn_LimpiarTabla,'Enable','off');
set(handles.Btn_PosicionInicial,'Enable','off');

%--- OBTENER EL ÁNGULO EN EL QUE SE ENCUENTRA CADA PIEZA
Rotation_Grado1 = getfield( IRB4600.Pieza_A, 'rotation' );
Rotation_Grado2 = getfield( IRB4600.Pieza_B, 'rotation' );
Rotation_Grado3 = getfield( IRB4600.Pieza_C, 'rotation' );
Rotation_Grado4 = getfield( IRB4600.Pieza_D, 'rotation' );
Rotation_Grado5 = getfield( IRB4600.Pieza_E, 'rotation' );
Rotation_Grado6 = getfield( IRB4600.Pieza_F, 'rotation' );

% Generar los vectores de desplazamiento para cada grado de libertad
if(Valor_Grado1 ~= A_Valor_Grado1)
     if( (Valor_Grado1 - rad2deg( Rotation_Grado1(4) ) ) >= 0  )
        G1 = rad2deg( Rotation_Grado1(4) ): Step : Valor_Grado1;
    else
        G1 = rad2deg( Rotation_Grado1(4) ): -Step : Valor_Grado1;
    end
end

if(Valor_Grado2 ~= A_Valor_Grado2)
     if( (Valor_Grado2 - rad2deg( Rotation_Grado2(4) ) ) >= 0  )
        G2 = rad2deg( Rotation_Grado2(4) ): Step : Valor_Grado2;
    else
        G2 = rad2deg( Rotation_Grado2(4) ): -Step : Valor_Grado2;
    end
end

if(Valor_Grado3 ~= A_Valor_Grado3)
     if( (Valor_Grado3 - rad2deg( Rotation_Grado3(4) ) ) >= 0  )
        G3 = rad2deg( Rotation_Grado3(4) ): Step : Valor_Grado3;
    else
        G3 = rad2deg( Rotation_Grado3(4) ): -Step : Valor_Grado3;
    end
end

if(Valor_Grado4 ~= A_Valor_Grado4)
     if( (Valor_Grado4 - rad2deg( Rotation_Grado4(4) ) ) >= 0  )
        G4 = rad2deg( Rotation_Grado4(4) ): Step : Valor_Grado4;
    else
        G4 = rad2deg( Rotation_Grado4(4) ): -Step : Valor_Grado4;
    end
end

if(Valor_Grado5 ~= A_Valor_Grado5)
     if( (Valor_Grado5 - rad2deg( Rotation_Grado5(4) ) ) >= 0  )
        G5 = rad2deg( Rotation_Grado5(4) ): Step : Valor_Grado5;
    else
        G5 = rad2deg( Rotation_Grado5(4) ): -Step : Valor_Grado5;
    end
end

if(Valor_Grado6 ~= A_Valor_Grado6)
     if( (Valor_Grado6 - rad2deg( Rotation_Grado6(4) ) ) >= 0  )
        G6 = rad2deg( Rotation_Grado6(4) ): Step : Valor_Grado6;
    else
        G6 = rad2deg( Rotation_Grado6(4) ): -Step : Valor_Grado6;
    end
end

G(1) =  length(G1);
G(2) =  length(G2);
G(3) =  length(G3);
G(4) =  length(G4);
G(5) =  length(G5);
G(6) =  length(G6);

% Obtener el número máximo de iteraciones que se realizarán para un grado
% de libertad
for i = 1 : length(G)
    if(i_max < G(i) )
        i_max = G(i);
    end
end

% Realizar un bucle general para todos los grados de libertad.
for i = 1 : i_max
    
    if( i <= G(1) )
        Grado1.rotation = [0 0 1 deg2rad( G1(i) )];
        set(handles.Text_Grado1, 'String', round( G1(i) ) );
        set(handles.Slider_Grado1,'Value', round( G1(i) ) );
    end
    
    if( i <= G(2) )
        Grado2.rotation = [0 1 0 deg2rad( G2(i) )];
        set(handles.Text_Grado2, 'String', round( G2(i) ) );
        set(handles.Slider_Grado2,'Value', round( G2(i) ) );
    end
    
    if( i <= G(3) )
        Grado3.rotation = [0 1 0 deg2rad( G3(i) )];
        set(handles.Text_Grado3, 'String', round( G3(i) ) );
        set(handles.Slider_Grado3,'Value', round( G3(i) ) );
    end
    
    if( i <= G(4) )
        Grado4.rotation = [1 0 0 deg2rad( G4(i) )];
        set(handles.Text_Grado4, 'String', round( G4(i) ) );
        set(handles.Slider_Grado4,'Value', round( G4(i) ) );
    end
    
    if( i <= G(5) )
        Grado5.rotation = [0 1 0 deg2rad( G5(i) )];
        set(handles.Text_Grado5, 'String', round( G5(i) ) );
        set(handles.Slider_Grado5,'Value', round( G5(i) ) );
    end
    
    if( i <= G(6) )
        Grado6.rotation = [1 0 0 deg2rad( G6(i) )];
        set(handles.Text_Grado6, 'String', round( G6(i) ) );
        set(handles.Slider_Grado6,'Value', round( G6(i) ) );
    end
    
    vrdrawnow;

end

A_Valor_Grado1 = Valor_Grado1;
A_Valor_Grado2 = Valor_Grado2;
A_Valor_Grado3 = Valor_Grado3;
A_Valor_Grado4 = Valor_Grado4;
A_Valor_Grado5 = Valor_Grado5;
A_Valor_Grado6 = Valor_Grado6;

% Habilitar los botones y sliders

set(handles.Btn_GuardarSecuencia,'Enable','on');
set(handles.Btn_Demostracion,'Enable','on');
set(handles.Btn_Detener,'Enable','on');
set(handles.Btn_EjecutarSecuencia,'Enable','on');
set(handles.Btn_LimpiarTabla,'Enable','on');
set(handles.Btn_PosicionInicial,'Enable','on');

function SelectViewpoint_Callback(hObject, eventdata, handles)

global IRB4600 fig ...  % Objeto con el cual se instancia el mundo virtual del brazo robótico creado en VRLBuilder
    Viewpoint ...

if( Viewpoint == 1)
    set(fig,'Viewpoint','Inicio');
    set(handles.Text_Viewpoint,'String','Inicio');
elseif(Viewpoint == 2)
    set(fig,'Viewpoint','Frente');
    set(handles.Text_Viewpoint,'String','Frente');
elseif(Viewpoint == 3)
    set(fig,'Viewpoint','Superior');
    set(handles.Text_Viewpoint,'String','Superior');
elseif(Viewpoint == 4)
    set(fig,'Viewpoint','Isometrico');
    set(handles.Text_Viewpoint,'String','Isométrico');
end



% --- Executes on button press in Btn_AnteriorViewpoint.
function Btn_AnteriorViewpoint_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_AnteriorViewpoint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Viewpoint

Viewpoint = Viewpoint - 1;
if(Viewpoint == 0)
    Viewpoint = 1;
end

SelectViewpoint_Callback(hObject, eventdata, handles);


% --- Executes on button press in Btn_SiguienteViewpoint.
function Btn_SiguienteViewpoint_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_SiguienteViewpoint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Viewpoint

Viewpoint = Viewpoint + 1;
if(Viewpoint == 5)
    Viewpoint = 4;
end

SelectViewpoint_Callback(hObject, eventdata, handles);

