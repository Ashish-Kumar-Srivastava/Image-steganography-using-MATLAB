function varargout = greyim(varargin)
% GREYIM MATLAB code for greyim.fig
%      GREYIM, by itself, creates a new GREYIM or raises the existing
%      singleton*.
%
%      H = GREYIM returns the handle to a new GREYIM or the handle to
%      the existing singleton*.
%
%      GREYIM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GREYIM.M with the given input arguments.
%
%      GREYIM('Property','Value',...) creates a new GREYIM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before greyim_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to greyim_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help greyim

% Last Modified by GUIDE v2.5 18-Apr-2018 00:38:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @greyim_OpeningFcn, ...
                   'gui_OutputFcn',  @greyim_OutputFcn, ...
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


% --- Executes just before greyim is made visible.
function greyim_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to greyim (see VARARGIN)

% Choose default command line output for greyim
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes greyim wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = greyim_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile('*.*', 'Pick an Image');
    if isequal(filename,0) || isequal(pathname,0)
       warndlg('User pressed cancel')
    else
       img=imread(strcat(pathname,filename));
       axes(handles.axes1);
       handles.inputimg=img;
       imshow(img);
       
    end
 
    % Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open('msg.txt');

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fid=fopen('msg.txt','r+');
f=fread(fid);
bin=transpose(dec2bin(f,8));
bs=bin(:);
len=length(bs);

b=zeros(len,1);
for k=1:len
if(bs(k)=='1')
b(k)=1;
else
b(k)=0;
end
end

new=handles.inputimg;
t=new;
h=size(new,1);
w=size(new,2);
s1=h*w;

if len> s1 
    fprintf('\nImage File Size  %d\n',s1);
    fprintf('Text  File Size  %d\n',len);
    disp('Text File is too Large');
else
    fprintf('\nImage File Size  %d\n',s1);
    fprintf('Text  File Size  %d\n',len);
    disp('Text File is Small');
    
    ms=1;
    for i=1:h
        for j=1:w
                if(ms<=len)
                    lsb=mod(double(new(i,j)),2);
                    if(lsb==1 && b(ms)==0)
                    t(i,j)=new(i,j)-1;
                    elseif(lsb==0 && b(ms)==1)
                    t(i,j)=new(i,j)+1;
                    else
                    t(i,j)=new(i,j);
                    end
                end
                ms=ms+1;
        end
    end
   imwrite(t,'hide.tif');
end
msgbox('Message is Encrypted');
handles.sz=len;
guidata(hObject,handles);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile('*.*', 'Pick an Image');
    if isequal(filename,0) || isequal(pathname,0)
       warndlg('User pressed cancel')
    else
       stego=imread(strcat(pathname,filename));
       axes(handles.axes2);
       handles.inputsteg=stego;
       imshow(stego);
       
    end
 
    % Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imag=handles.inputsteg;
ln=handles.sz;
h1 = size(imag,1);
w1 = size(imag,2);
    r=1;
    for i = 1 : h1
        for j = 1 : w1
            if (r <= ln)
                b(r) = mod(double(imag(i,j)),2);
            end
            r=r+1;
        end
    end
    a=ln/8;
    bv=num2str(b);
    bv(isspace(bv))='';
    bf=bv(:);
    t=[8 a];
    bs=reshape(bf,t);
    bt=transpose(bs);
    bd=bin2dec(bt);
    td=transpose(bd);
    sh=char(td);
    fi=fopen('hidden.txt','wt');
    fprintf(fi,'%s',sh);
    fclose(fi);
    msgbox('Message is successfully Decrypted');

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open('hidden.txt');