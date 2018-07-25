function varargout = grey(varargin)
% GREY MATLAB code for grey.fig
%      GREY, by itself, creates a new GREY or raises the existing
%      singleton*.
%
%      H = GREY returns the handle to a new GREY or the handle to
%      the existing singleton*.
%
%      GREY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GREY.M with the given input arguments.
%
%      GREY('Property','Value',...) creates a new GREY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before grey_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to grey_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help grey

% Last Modified by GUIDE v2.5 18-Apr-2018 01:15:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @grey_OpeningFcn, ...
                   'gui_OutputFcn',  @grey_OutputFcn, ...
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


% --- Executes just before grey is made visible.
function grey_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to grey (see VARARGIN)

% Choose default command line output for grey
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes grey wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = grey_OutputFcn(hObject, eventdata, handles) 
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
[filename, pathname] = uigetfile('*.*', 'Pick an Image');
    if isequal(filename,0) || isequal(pathname,0)
       warndlg('User pressed cancel')
    else
       im=imread(strcat(pathname,filename));
       axes(handles.axes2);
       handles.secret=im;
       imshow(im);
    end
 
    % Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=handles.inputimg;
b=handles.secret;
h1=size(a,1);
w1=size(a,2);
h2=size(b,1);
w2=size(b,2);
len=8*h2*w2;
s1=h1*w1*3;
if len> s1 
    fprintf('\nCover image size  %d\n',s1);
    fprintf('Secret image size  %d\n',len);
    disp('Secret image is too Large');
else
    fprintf('\nCover image size  %d\n',s1);
    fprintf('Secret image size  %d\n',len);
    disp('Secret image is Small');

new=a;
t=1;
    for j=1:w2
        for i=1:h2
            for l=1:8
            if(t<=len)
            bs(t)=mod(double(b(i,j)),2);
            b(i,j)=floor(double(b(i,j))/2);
            t=t+1;
            end
            end
        end
    end
ms=1;
    for i2=1:h1
        for j2=1:w1
            for k2=1:3
                if(ms<=len)
                    lsb=mod(double(a(i2,j2,k2)),2);
                    if(lsb==1 && bs(ms)==0)
                    new(i2,j2,k2)=a(i2,j2,k2)-1;
                    elseif(lsb==0 && bs(ms)==1)
                    new(i2,j2,k2)=a(i2,j2,k2)+1;
                    else
                    new(i2,j2,k2)=a(i2,j2,k2);
                    end
                end
                ms=ms+1;
            end
        end
    end
end    
imwrite(new,'hide_grey.png');
handles.length=len;
handles.height=h2;
handles.width=w2;
guidata(hObject,handles);
msgbox('Successfully Encrypted');

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile('*.*', 'Pick an Image');
    if isequal(filename,0) || isequal(pathname,0)
       warndlg('User pressed cancel')
    else
       ima=imread(strcat(pathname,filename));
       axes(handles.axes3);
       handles.hide=ima;
       imshow(ima);
    end
 
    % Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
an=handles.hide;
k=handles.length;
ht=handles.height;
wd=handles.width;
h=size(an,1);
w=size(an,2);
t=1;
for i=1:h
    for j=1:w
        for l=1:3
            if(t<=k)
            lsb(t)=mod(double(an(i,j,l)),2);
            end
            t=t+1;
        end
    end
end
    sz=k/8;
    bv=num2str(lsb);
    bv(isspace(bv))='';
    bw=fliplr(bv);
    bf=bw(:);
    arr=[8 sz];
    bs=reshape(bf,arr);  
    tran=transpose(bs);
    n1=bin2dec(tran);
    for i=1:sz
      n(i)=n1(sz);
      sz=sz-1;
    end
    re=reshape(n,ht,wd);
    res=uint8(re);
    imwrite(res,'orig_grey.tif');
msgbox('Successfully Decrypted');

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes4);
imshow('orig_grey.tif');