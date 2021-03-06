function varargout = BodePlotGui(varargin)
% BODEPLOTGUI Application M-file for BodePlotGui.fig
%    FIG = BODEPLOTGUI launch BodePlotGui GUI.
%    BODEPLOTGUI('callback_name', ...) invoke the named callback.

% Last Modified by GUIDE v2.5 31-Oct-2003 15:16:28

%Written by Erik Cheever (Copyright 2002)
%Contact: erik_cheever@swarthmore.edu
% Erik Cheever
% Dept. of Engineering
% Swarthmore College
% 500 College Avenue
% Swarthmore, PA 19081  USA

%This function acts as a switchyard for several callbacks.  It also intializes
%the variables used by the GUI.  Note that all variables are initialized here to
%default values.  A brief description of each variable is included.

if nargin == 0  %If no arguments
    disp(' ');
    disp('Asymptotic Bode Plotter - proper usage is ''BodePlotGui(Sys)'',')
    disp('  where ''Sys'' is a transfer function object.');
    disp(' '); disp(' ');
    
    %Check if first argument is a 'tf'.  The GUI only works with transfer function objects.
elseif isa(varargin{1},'tf')    
    % LAUNCH GUI
    disp(' ');
    disp(' ');
    
    fig = openfig(mfilename,'new');
    
    % Generate a structure of handles to pass to callbacks, and store it. 
    handles = guihandles(fig);  %Get handles structure.
    
    handles.Sys=varargin{1};    %The variable Sys is the transfer function.
    handles.sysInc=varargin{1}; %The variable sysInc is that part of the transfer
    % function that will be plotted (with no poles or zeros excluded).  Start with
    % it equal to Sys.  This variable is modified in BodePlotSys
    
    handles.Terms=[];
    %The structure "Term" has three elements.
    %            type: this can be any of the 7 types listed above.
    %           value: this is the location of the pole or zero (or in the case
    %                  of the multiplicative constant, its value).
    %    multiplicity: this gives the multiplicity of the pole or zero.  It has
    %                  no meaning in the case of the multiplicative constant.
    
    %The variable "Acc" is a relative accuracy used to determine whether or not
    %two poles (or zeros) are the same.  Because Matlab uses an approximate 
    %technique to find roots of an equation, it is likely to give slightly
    %different locations to identical roots.
    handles.Acc=1E-3;
    guidata(fig, handles);          %Save handles.
    
    %The function BodePlotTerms separates the transfer function into its consituent parts.
    % The variable DoQuit will come back as non-zero if there was a problem.
    DoQuit=BodePlotTerms(handles);
    handles=guidata(fig);           %Load handles (w/ changes from BodePlotTerms).
    
    %if DoQuit is zero, there were no problems and we may continue.
    if ~DoQuit,
        
        handles.IncludeString=[];   %An array of strings representing terms to include in the plot.
        handles.ExcludeString=[];   %An array of strings representing terms to exclude from plot.
        handles.IncElem=[];         %An array of indices of terms corresponding to their
        % location in the IncludeString array.
        handles.ExcElem=[];         %An array of indices of terms corresponding to their
        % location in the ExcludeString array.
        handles.FirstPlot=1;        %This term is 1 the first time a plot is made.  This lets
        % Matlab do the original autoscaling.  The scales are then
        % saved and reused.
        handles.MagLims=[];         %The limits on the magnitude plot determined by MatLab autoscaling.
        handles.PhaseLims=[];       %The limits on the phase plot determined by MatLab autoscaling.
        handles.LnWdth=2;
        set(handles.LineWidth,'String',num2str(handles.LnWdth));
        
        %Set the color of lines used in gray scale.  The plotting functions
        %cycle through these colors (and then cycle through the linestyles).
        handles.Gray=[0.75 0.75 0.75; 0.5 0.5 0.5; 0.25 0.25 0.25];
        handles.GrayZero=[0.9 0.9 0.9];  %This is the color used for the zero reference.
        
        %Set the color of lines used in color plots.  The plotting functions
        %cycle through these colors (and then cycle through the linestyles).
        handles.Color=[0 1 1; 0 0 1; 0 1 0; 1 0 0; 1 0 1;1 0.52 0.40];
        handles.ColorZero=[1 1 0];  %Yellow, this is the color used for the zero reference.
        
        %Sets order of linestyles used.
        handles.linestyle={':','--','-.'};
        
        %This sets the default scheme to color (GUI can set them to gray scale).
        handles.colors=handles.Color;
        handles.zrefColor=handles.ColorZero;
        handles.exactColor=[0 0 0]; %Black
        
        guidata(fig, handles);      %Save changes to handles.
        
        if nargout > 0              %If output argument is used, set it to figure.
            varargout{1} = fig;
        end
        
        BodePlotter(handles);       %Make plot
        handles=guidata(fig);       %Reload handles after function call.    
        
        %DoQuit was non-zero, so there was a problem.  Quit program.    
    else
        CloseButton_Callback(fig,'',handles,'');
    end
    
elseif ischar(varargin{1}) % INVOKE NAMED SUBFUNCTION OR CALLBACK
    
    try
        [varargout{1:nargout}] = feval(varargin{:}); % FEVAL switchyard
    catch
        disp(lasterr);
    end
    
end
% ------------------End of function BodePlotGui ----------------------


%| ABOUT CALLBACKS:
%| GUIDE automatically appends subfunction prototypes to this file, and 
%| sets objects' callback properties to call them through the FEVAL 
%| switchyard above. This comment describes that mechanism.
%|
%| Each callback subfunction declaration has the following form:
%| <SUBFUNCTION_NAME>(H, EVENTDATA, HANDLES, VARARGIN)
%|
%| The subfunction name is composed using the object's Tag and the 
%| callback type separated by '_', e.g. 'slider2_Callback',
%| 'figure1_CloseRequestFcn', 'axis1_ButtondownFcn'.
%|
%| H is the callback object's handle (obtained using GCBO).
%|
%| EVENTDATA is empty, but reserved for future use.
%|
%| HANDLES is a structure containing handles of components in GUI using
%| tags as fieldnames, e.g. handles.figure1, handles.slider2. This
%| structure is created at GUI startup using GUIHANDLES and stored in
%| the figure's application data using GUIDATA. A copy of the structure
%| is passed to each callback.  You can store additional information in
%| this structure at GUI startup, and you can change the structure
%| during callbacks.  Call guidata(h, handles) after changing your
%| copy to replace the stored original so that subsequent callbacks see
%| the updates. Type "help guihandles" and "help guidata" for more
%| information.
%|
%| VARARGIN contains any extra arguments you have passed to the
%| callback. Specify the extra arguments by editing the callback
%| property in the inspector. By default, GUIDE sets the property to:
%| <MFILENAME>('<SUBFUNCTION_NAME>', gcbo, [], guidata(gcbo))
%| Add any extra arguments after the last argument, before the final
%| closing parenthesis.


% --------------------------------------------------------------------
function varargout = IncludedElements_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.IncludedElements.
% If a term in the "Included Elements" box is clicked, this callback is invoked.
i=get(handles.IncludedElements,'Value');  %Get index of element in box that is chosen.%If the index corresponds to one of the terms of the transfer function, deal with it.
% The alternative is that it corresponds to another string in the box (there is a blank
% line, a line with dashes "----" and a line instructing the user to click on an element
% to include it).
if i<=length(handles.IncElem)
    TermsInd=handles.IncElem(i);        %Get the index of the included element.
    handles.Terms(TermsInd).display=0;  %Set display to 0 (to exclude it)
    guidata(handles.AsymBodePlot, handles); %save changes to handles.
    BodePlotter(handles);                   %Plot the Transfer function.
    handles=guidata(handles.AsymBodePlot);  %Reload handles after function call.
end
% ------------------End of function IncludedElements_Callback --------


% --------------------------------------------------------------------
function varargout = ExcludedElements_Callback(h, eventdata, handles, varargin)
% Callback of the uicontrol handles.ExcludedElements.
% If a term in the "Excluded Elements" box is clicked, this callback is invoked.
i=get(handles.ExcludedElements,'Value');  %Get index of element in box that is chosen.
%If the index corresponds to one of the terms of the transfer function, deal with it.
% The alternative is that it corresponds to another string in the box (there is a blank
% line, a line with dashes "----" and a line instructing the user to click on an element
% to exclude it).
if i<=length(handles.ExcElem)               
    TermsInd=handles.ExcElem(i);        %Get the index of the excluded element.
    handles.Terms(TermsInd).display=1;  %Set display to 1 (to include it)
    guidata(handles.AsymBodePlot, handles); %save changes to handles.
    BodePlotter(handles);                   %Plot the Transfer function.
    handles=guidata(handles.AsymBodePlot);  %Reload handles after function call.
end
% ------------------End of function ExcludedElements_Callback --------


% --------------------------------------------------------------------
function varargout = CloseButton_Callback(h, eventdata, handles, varargin)
% Callback for the uicontrol handles.CloseButton.
%This function closes the window, and displays a message.
disp(' '); disp('Asymptotic Bode Plotter closed.'); disp(' '); disp(' ');
delete(handles.AsymBodePlot);
% ------------------End of function CloseButton_Callback -------------


% --------------------------------------------------------------------
function DoQuit=BodePlotTerms(handles)
%This function takes a system and splits it up into terms that are plotted
%individually when making a Bode plot by hand (it finds
%1) The multiplicative constant.
%2) All real poles
%3) All real zeros
%4) All complex poles
%5) All complex zeros
%6) All poles at the origin
%7) All zeros at the origin
%
%In addition to finding the poles and zeros, it determines their multiplicity.
%If two poles or zeros are very close they are determined to be the same pole
%or zero.

sys=handles.Sys;
Acc=handles.Acc;   %Relative accuracy.

[z,p,k]=zpkdata(sys,'v');   %Get pole and zero data.

%Find gain term.
[n,d]=tfdata(sys,'v');
k=n(max(find(n~=0)))/d(max(find(d~=0)));
term(1).type='Constant';
term(1).value=k;
term(1).multiplicity=1;

%Get all poles.
j=length(term);
for i=1:length(p),
    term(j+i).value=p(i);
    term(j+i).multiplicity=1;
    term(j+i).type='Pole';
end
%Get all zeros.
j=length(term);
for i=1:length(z),
    term(j+i).value=z(i);
    term(j+i).multiplicity=1;
    term(j+i).type='Zero';
end

%Check for multiplicity
for i=2:length(term),
    for k=(i+1):length(term),
        %Handle pole or zero at origin as special case.
        if (term(i).value==0),
            %Multiple pole or zero at origin.
            if (term(k).value==0),   
                term(i).multiplicity=term(i).multiplicity+term(k).multiplicity;
                %Set multiplicity of kth term to 0 to signify that it has been
                % subsumed by term(i) (by increasing the ith term's multiplicity).
                term(k).multiplicity=0;
            end
            %We know term is not at origin, so check for (approximate) equality
            %  Since we know this term is not at origin, we can divide by value.
        elseif (abs((term(i).value-term(k).value)/term(i).value) < Acc),
            term(i).multiplicity=term(i).multiplicity+term(k).multiplicity;
            %Set multiplicity of kth term to 0 to signify that it has been
            % subsumed by term(i) (by increasing the ith term's multiplicity).
            term(k).multiplicity=0;
        end
    end
end

%Check for location of poles and zeros (and remove complex conjugates).
i=2;
while (i<=length(term)),
    %If root is at origin, handle it separately
    if (term(i).value==0),
        term(i).type=['Origin' term(i).type];
        %If imaginary part is sufficiently small...
    elseif (abs(imag(term(i).value)/term(i).value)<Acc),
        term(i).type=['Real' term(i).type];  %...Add "Real" to type
        term(i).value=real(term(i).value);   %...And set imaginary part=0
        %If imaginary part is *not* small...    
    else
        term(i).type=['Complex' term(i).type];  %...Add "Complex" to type
        term(i+1).multiplicity=0;               %...Remove complex conjugate
        i=i+1;                                  %...And skip conjugate.
    end
    i=i+1;  %Go to next root.
end

%Remove all terms with multiplicity 0.
j=0;
for i=1:length(term),
    if (term(i).multiplicity~=0)
        j=j+1;
        term(j)=term(i);
        term(j).display=1;
    end
end

term=term(1:j);

DoQuit=0;
%Check for poles or zeros in right half plane, 
% or on imaginary axis. Poles and zeros at origin are OK.
if any(real(p)>0),  %Poles in RHP.
    beep;
    waitfor(errordlg('System has poles with positive real part, cannot make plot.'));
    DoQuit=1;
    return;
end
if any(real(z)>0),  %Zeros in RHP.
    disp(' ');
    disp('************Warning******************');
    handles.Sys
    disp('is a nonminimum phase system (zeros in right half plane).');
    disp('The standard rules for phase do not apply.');
    disp(' ');
    disp('Also - The plots produced may be different than the Matlab Bode plot');
    disp('  by a factor of 360 degrees.  So though the graphs don''t look');
    disp('  the same, they are equivalent');
    disp(' ');
    disp('Location(s) of zero(s):');
    disp(z);
    disp('*************************************');
    disp(' ');
    disp(' ');
    beep;
    waitfor(warndlg('System has zeros with positive real part.  See Command Window for caveats.'));
end
for i=2:length(term),       %Check for terms near imaginary axis.
    if (term(i).value~=0),
        if (abs(real(term(i).value)/term(i).value)<Acc),
            disp(' ');
            disp('************Warning******************');
            handles.Sys
            disp('has a pole or zero near, or on, the imaginary axis.');
            disp('The plots may be inaccurate near that frequency.')
            disp(' ');
            disp('--------');
            disp('Pole(s):');
            disp(p)
            disp('--------');
            disp('Zero(s):');
            disp(z);
            disp('*************************************');
            disp(' ');
            disp(' ');
            disp(' ');
            beep;
            waitfor(warndlg('System has polse or zeros with real part near zero.  See Command Window.'));
        end
    end
end

handles.Terms=term;
guidata(handles.AsymBodePlot, handles);  %save changes to handles.
% ------------------End of function BodePlotTerms --------------------


% --------------------------------------------------------------------
function BodePlotter(handles)

%Get the constituent terms and the system itself.
Terms=handles.Terms;
sys=handles.Sys;

%Call function to get a system with only included poles and zeros.
BodePlotSys(handles);
handles=guidata(handles.AsymBodePlot);  %Reload handles after function call.

%Get systems with included poles and zeros.
sysInc=handles.sysInc;

%Find min and max freq.
MinF=realmax;
MaxF=-realmax;
for i=2:length(Terms),
    if Terms(i).value~=0,
        MinF=min(MinF,abs(Terms(i).value));
        MaxF=max(MaxF,abs(Terms(i).value));
    end
end

%If there is exclusively a pole or zero at origin, MinF and MaxF will
% not have changed.  So set them arbitrarily to be near unity.
if MaxF==-realmax, 
    MinF=0.9;
    MaxF=1.1;
end

%MinFreq is a bit more than an order of magnitude below lowest break.
MinFreq=10^(floor(log10(MinF)-1.01));
%MaxFreq is a bit more than an order of magnitude above highest break.
MaxFreq=10^(ceil(log10(MaxF)+1.01));
%Calculate 500 frequency points for plotting.
w=logspace(log10(MinFreq),log10(MaxFreq),500);

%%%%%%%%%%%%%%%%%%%% Start Magnitude Plot %%%%%%%%%%
axes(handles.MagPlot);
cla;

%Plot line at 0 dB for reference.
semilogx([MinFreq MaxFreq],[0 0],...
    'Color',handles.zrefColor,...
    'LineWidth',1.5);

hold on;

%For each term, plot the magnitude accordingly.
for i=1:length(Terms),
    if Terms(i).display,       
        switch Terms(i).type,
            case 'Constant',
                %A constant term is unchanging from beginning to end.
                f=[MinFreq MaxFreq];
                m=20*log10(abs([Terms(i).value Terms(i).value]));
                semilogx(f,m,...
                    'LineWidth',handles.LnWdth,...
                    'LineStyle',GetLineStyle(i,handles),...
                    'Color',GetLineColor(i,handles));
            case 'RealPole',
                %A real pole has a single break frequency and then
                %decreases at 20 dB per decade (Or more if pole is multiple).
                wo=-Terms(i).value;
                f=[MinFreq wo MaxFreq];
                m=-20*log10([1 1 MaxFreq/wo])*Terms(i).multiplicity;
                semilogx(f,m,...
                    'LineWidth',handles.LnWdth,...
                    'LineStyle',GetLineStyle(i,handles),...
                    'Color',GetLineColor(i,handles));
            case 'RealZero',
                %Similar to real pole, but increases instead of decreasing.
                wo=abs(Terms(i).value);
                f=[MinFreq wo MaxFreq];
                m=20*log10([1 1 MaxFreq/wo])*Terms(i).multiplicity;
                semilogx(f,m,...
                    'LineWidth',handles.LnWdth,...
                    'LineStyle',GetLineStyle(i,handles),...
                    'Color',GetLineColor(i,handles));
            case 'ComplexPole',
                %A complex pole has a single break frequency and then
                %decreases at 40 dB per decade (Or more if pole is multiple).
                %There is also a peak value whose height and location are
                %determined by the natural frequency and damping coefficient.
                %We will plot a circle ('o') at the location of the peak.
                wn=abs(Terms(i).value);
                theta=atan(abs(imag(Terms(i).value)/real(Terms(i).value)));
                zeta=cos(theta);
                if (zeta < (1/sqrt(2))),  %Peaking occurs if zeta<0.707
                    wo=wn*sqrt(1-2*zeta*zeta);
                    peak=2*zeta*sqrt(1-zeta*zeta);
                    f=[MinFreq wo wo wo MaxFreq];
                    m=-20*log10([1 1 peak 1 (MaxFreq/wo)^2])*Terms(i).multiplicity;
                    semilogx(wo,-20*log10(peak),'o','Color',GetLineColor(i,handles));
                else
                    f=[MinFreq wn MaxFreq];
                    m=-20*log10([1 1 (MaxFreq/wn)^2])*Terms(i).multiplicity;
                end
                semilogx(f,m,...
                    'LineWidth',handles.LnWdth,...
                    'LineStyle',GetLineStyle(i,handles),...
                    'Color',GetLineColor(i,handles));
            case 'ComplexZero',
                %Similar to complex pole, but increases instead of decreasing.
                wn=abs(Terms(i).value);
                theta=atan(abs(imag(Terms(i).value)/real(Terms(i).value)));
                zeta=cos(theta);
                if (zeta < (1/sqrt(2))),  %Peaking occurs if zeta<0.707
                    wo=wn*sqrt(1-2*zeta*zeta);
                    peak=2*zeta*sqrt(1-zeta*zeta);
                    f=[MinFreq wo wo wo MaxFreq];
                    m=20*log10([1 1 peak 1 (MaxFreq/wo)^2])*Terms(i).multiplicity;
                    semilogx(wo,20*log10(peak),'o','Color',GetLineColor(i,handles));
                else
                    f=[MinFreq wn MaxFreq];
                    m=20*log10([1 1 (MaxFreq/wn)^2])*Terms(i).multiplicity;
                end
                semilogx(f,m,...
                    'LineWidth',handles.LnWdth,...
                    'LineStyle',GetLineStyle(i,handles),...
                    'Color',GetLineColor(i,handles));
            case 'OriginPole',
                %A pole at the origin is a monotonically decreasing straigh line.
                f=[MinFreq MaxFreq];
                m=-20*log10([MinFreq MaxFreq])*Terms(i).multiplicity;
                semilogx(f,m,...
                    'LineWidth',handles.LnWdth,...
                    'LineStyle',GetLineStyle(i,handles),...
                    'Color',GetLineColor(i,handles));
            case 'OriginZero',
                %Similar to pole at origin, but increases instead of decreasing.
                f=[MinFreq MaxFreq];
                m=20*log10([MinFreq MaxFreq])*Terms(i).multiplicity;
                semilogx(f,m,...
                    'LineWidth',handles.LnWdth,...
                    'LineStyle',GetLineStyle(i,handles),...
                    'Color',GetLineColor(i,handles));
        end
    end
end

%Set the x-axis limits to the minimum and maximum frequency.
set(gca,'XLim',[MinFreq MaxFreq]);

[mg,ph,w]=bode(sysInc,w);   %Calculate the exact bode plot.
semilogx(w,20*log10(mg(:)),...
    'Color',handles.exactColor,...
    'LineWidth',handles.LnWdth);  %Plot it.

if handles.FirstPlot,
    %If this is the first time, let Matlab do autoscaling, but save
    %the y-axis limits so that they will be unchanged as the plot changes.
    ylims=get(gca,'YLim')/20;
    ylims(1)=min(-20,ceil(ylims(1))*20);
    ylims(2)=max(20,floor(ylims(2))*20);
    handles.MagLims=ylims;
else
    %If this is not the first time, retrieve the old y-axis limits.
    ylims=handles.MagLims;
end
set(gca,'YLim',ylims);
set(gca,'YTick',ylims(1):20:ylims(2));  %Make ticks every 20 dB. 

ylabel('Magnitude - dB');
xlabel('Frequency - \omega, rad-sec^{-1}')
title('Magnitude Plot','color','b','FontWeight','bold');
if get(handles.GridCheckBox,'Value')==1,
    grid on   
end
hold off;
%%%%%%%%%%%%%%%%%%%% End Magnitude Plot %%%%%%%%%%



%%%%%%%%%%%%%%%%%%%% Start Phase Plot %%%%%%%%%%
%Much of this section mirrors the previous section and is not commented.
axes(handles.PhasePlot);
cla;

%Plot line at 0 degrees for reference.
semilogx([MinFreq MaxFreq],[0 0],...
    'Color',handles.zrefColor,...
    'LineWidth',1.5);
hold on;

for i=1:length(Terms),
    if Terms(i).display,
        switch Terms(i).type,
            case 'Constant',
                f=[MinFreq MaxFreq];
                if Terms(i).value>0,
                    p=[0 0];
                else
                    p=[-180 -180];
                end
                if get(handles.RadianCheckBox,'Value')==1,
                    p=p/180;
                end
                semilogx(f,p,...
                    'LineWidth',handles.LnWdth,...
                    'LineStyle',GetLineStyle(i,handles),...
                    'Color',GetLineColor(i,handles));
            case 'RealPole',
                wo=-Terms(i).value;
                f=[MinFreq wo/10 wo*10 MaxFreq];
                p=[0 0 -90 -90]*Terms(i).multiplicity;
                if get(handles.RadianCheckBox,'Value')==1,
                    p=p/180;
                end
                semilogx(f,p,...
                    'LineWidth',handles.LnWdth,...
                    'LineStyle',GetLineStyle(i,handles),...
                    'Color',GetLineColor(i,handles));
            case 'RealZero',
                if Terms(i).value>0,  
                    %Non-minimum phase
                    wo=Terms(i).value;
                    %Uncomment the next section to get agreement with Matlab plots.
                    %if Terms(1).value>0,  %Choose 0 or 360 to agree with MatLab plots
                    %    p=[0 0 0 0];      % (based on sign of constant term).
                    % else
                    %    p=[360 360 360 360];
                    %end
                    p=[0 0 -90 -90]*Terms(i).multiplicity;
                else
                    %Minimum phase
                    wo=-Terms(i).value;
                    p=[0 0 90 90]*Terms(i).multiplicity;
                end
                f=[MinFreq wo/10 wo*10 MaxFreq];
                if get(handles.RadianCheckBox,'Value')==1,
                    p=p/180;
                end
                semilogx(f,p,...
                    'LineWidth',handles.LnWdth,...
                    'LineStyle',GetLineStyle(i,handles),...
                    'Color',GetLineColor(i,handles));
            case 'ComplexPole',
                wo=abs(Terms(i).value);
                %good for zeta>0.05;
                bf=min(0.5*log10(2/zeta),1);
                f=[MinFreq wo*bf wo/bf MaxFreq];
                p=[0 0 -180 -180]*Terms(i).multiplicity;
                if get(handles.RadianCheckBox,'Value')==1,
                    p=p/180;
                end
                semilogx(f,p,...
                    'LineWidth',handles.LnWdth,...
                    'LineStyle',GetLineStyle(i,handles),...
                    'Color',GetLineColor(i,handles));
            case 'ComplexZero',
                wo=abs(Terms(i).value);
                bf=min(0.5*log10(2/zeta),1);
                f=[MinFreq wo*bf wo/bf MaxFreq];
                if real(Terms(i).value)>0,
                    p=[0 0 -180 -180]*Terms(i).multiplicity;
                else
                    p=[0 0 180 180]*Terms(i).multiplicity;
                end
                if get(handles.RadianCheckBox,'Value')==1,
                    p=p/180;
                end
                semilogx(f,p,...
                    'LineWidth',handles.LnWdth,...
                    'LineStyle',GetLineStyle(i,handles),...
                    'Color',GetLineColor(i,handles));
            case 'OriginPole',
                f=[MinFreq MaxFreq];
                p=[-90 -90]*Terms(i).multiplicity;
                if get(handles.RadianCheckBox,'Value')==1,
                    p=p/180;
                end
                semilogx(f,p,...
                    'LineWidth',handles.LnWdth,...
                    'LineStyle',GetLineStyle(i,handles),...
                    'Color',GetLineColor(i,handles));
            case 'OriginZero',
                f=[MinFreq MaxFreq];
                p=[90 90]*Terms(i).multiplicity;
                if get(handles.RadianCheckBox,'Value')==1,
                    p=p/180;
                end
                semilogx(f,p,...
                    'LineWidth',handles.LnWdth,...
                    'LineStyle',GetLineStyle(i,handles),...
                    'Color',GetLineColor(i,handles));
        end
    end
end

if get(handles.RadianCheckBox,'Value')==1,
    ph=ph/180;
end
semilogx(w,ph(:),...
    'Color',handles.exactColor,...
    'LineWidth',handles.LnWdth);  %Plot it.

set(gca,'XLim',[MinFreq MaxFreq]);
if handles.FirstPlot,
    ylims=get(gca,'YLim')/45;
    ylims(1)=ceil(ylims(1)-1)*45;
    ylims(2)=floor(ylims(2)+1)*45;
    handles.DPhaseLims=ylims;     %Find phase limits in degrees
    handles.RPhaseLims=ylims/180; %Find phase limits in radians/pi
else
    if get(handles.RadianCheckBox,'Value')==1,
        ylims=handles.RPhaseLims;
    else
        ylims=handles.DPhaseLims;
    end  
end

if get(handles.RadianCheckBox,'Value')==1,
    set(gca,'YLim',ylims);
    set(gca,'YTick',ylims(1):0.25:ylims(2))
    ylabel('Phase - radians/\pi');
else
    set(gca,'YLim',ylims);
    set(gca,'YTick',ylims(1):45:ylims(2))
    ylabel('Phase - degrees');
end  


xlabel('Frequency - \omega, rad-sec^{-1}');
title('Phase Plot','color','b','FontWeight','bold');
if get(handles.GridCheckBox,'Value')==1,
    grid on   
end
hold off;
%%%%%%%%%%%%%%%%%%%% End Phase Plot %%%%%%%%%%

BodePlotDispTF(handles);    %Display the transfer function
BodePlotLegend(handles);    %Display the legend.
handles=guidata(handles.AsymBodePlot);  %Reload handles after function call.

%Set first plot to zero (so Matlab won't autoscale on subsequent calls).
handles.FirstPlot=0;                               

guidata(handles.AsymBodePlot, handles);  %save changes to handles.
% ----------------- End of function BodePlotter ----------------------


% --------------------------------------------------------------------
function BodePlotSys(handles)
%This function makes up a transfer function of all the terms that are not in
%the "Excluded Elements" box in the GUI.

Terms=handles.Terms;    %Get all terms from original transfer function.
p=[];                   %Start with no poles, or zeros, and a constant of 1
z=[];
k=1;

for i=1:length(Terms),      %For each term.
    %If the term is not in "Excluded Elements". then we want to display it.
    if Terms(i).display,    
        switch Terms(i).type,
            case 'Constant',
                k=Terms(i).value;               %This is the constant.
            case 'RealPole',
                for j=1:Terms(i).multiplicity,
                    p=[p Terms(i).value];       %Add poles.
                end
            case 'RealZero',
                for j=1:Terms(i).multiplicity,
                    z=[z Terms(i).value];       %Add zeros.
                end
            case 'ComplexPole',
                for j=1:Terms(i).multiplicity,
                    p=[p Terms(i).value];       %Add poles.
                    p=[p conj(Terms(i).value)];
                end
            case 'ComplexZero',
                for j=1:Terms(i).multiplicity,
                    z=[z Terms(i).value];       %Add zeros.
                    z=[z conj(Terms(i).value)];
                end
            case 'OriginPole',
                for j=1:Terms(i).multiplicity,
                    p=[p 0];                    %Add poles.
                end
            case 'OriginZero',
                for j=1:Terms(i).multiplicity,
                    z=[z 0];                    %Add zeros.
                end
        end
    end
end

%Determine multiplicative constant in standard Bode Plot form.
for i=1:length(p),
    if p(i)~=0
        k=-k*p(i);
    end
end
for i=1:length(z),
    if z(i)~=0
        k=-k/z(i);
    end
end
%If poles and/or zeros were complex conjugate pairs, there may be
%some residual imaginary part due to finite precision.  Remove it.
k=real(k);

handles.sysInc=zpk(z,p,k);
guidata(handles.AsymBodePlot, handles);  %save changes to handles.
% ------------------End of function BodePlotSys ----------------------


% --------------------------------------------------------------------
function BodePlotDispTF(handles)
% This function displays a tranfer function that is a helper function for the 
% BodePlotGui routine.  It takes the transfer function of the numerator and 
% splits it into three lines so that it can be displayed nicely.  For example:
% "            s + 1"
% "H(s) = ---------------"
% "        s^2 + 2 s + 1"
%
% The numerator string is in the variable nStr,
% the second line is in divStr,
% and the denominator string is in dStr.

% Get numerator and denominator.
[n,d]=tfdata(handles.sysInc,'v');

% Get string representations of numerator and denominator
nStr=poly2str(n,'s');
dStr=poly2str(d,'s');

% Find length of strings.
LnStr=length(nStr);
LdStr=length(dStr);

if LnStr>LdStr,
    %the numerator is longer than denominator string, so pad denominator.
    n=LnStr;              %n is the length of the longer string.
    nStr=['     ' nStr];   %add spaces for characters at beginning of divStr.
    dStr=['     ' blanks(floor((LnStr-LdStr)/2)) dStr];  %pad denominator.
else
    %the demoninator is longer than numerator, pad numerator.
    n=LdStr;              
    nStr=['     ' blanks(floor((LdStr-LnStr)/2)) nStr];
    dStr=['     ' dStr];
end

divStr=[];
for i=1:n,
    divStr=[divStr '-'];
end
divStr=['H(s) = ' divStr];

set(handles.TransferFunctionText,'String',strvcat(nStr,divStr,dStr));

%Change type font and size.
set(handles.TransferFunctionText,'FontName','Courier New')
%set(handles.TransferFunctionText,'FontSize',10)

guidata(handles.AsymBodePlot, handles);  %save changes to handles.
% ------------------End of function BodePlotDispTF -------------------


% --------------------------------------------------------------------
function BodePlotLegend(handles)
%This function creates the legends for the Bode plot being displayed.
%It also makes four changes to the "handles" structure.
%   1)  It updates the array "IncElem" that holds the indices that determine
%       which elements are included in the Bode plot.
%   2)  It updates the sring array "IncStr" that hold the description of
%       each included elements.
%   3)  Updates ExcElem that holds indices of excluded elements.
%   4)  Updates ExcStr that hold descriptions of excluded elements.

%Load the terms and the plotting strings into local variables for convenience.
Terms=handles.Terms;

axes(handles.LegendPlot);   %Set axes to the legend widow, 
cla;                        %   and clear it.
Xleg=[0 0.2];               %Xleg holds start and end of line segment for legend.
XlegText=0.25;              %XlegText is location of text.
FntSz=8;                    %Font Size of text.

y=1-1/(length(Terms)+5);                           %Vertical location of first text item
plot(Xleg,[y y],...
    'Color',handles.exactColor,...
    'LineWidth',handles.LnWdth);   %Plot line for legend.
text(XlegText,y,'Exact Bode Plot','FontSize',FntSz);               %Place text
hold on;


y=1-2/(length(Terms)+5);           %Vertical location of second item.
plot(Xleg,[y y],...                %Line.
    'Color',handles.zrefColor,...
    'LineWidth',2);   
text(XlegText,y,'Zero Value (for reference only)','FontSize',FntSz); %Text.

IncElem=[]; %The indices of elements to be included in plot.
ExcElem=[]; %The indices of elements to be excluded from plot.
IncStr='';  %An array of strings describing included elements.
ExcStr='';  %An array of strings describing excluded elements.

%These variables are used as local counters later.  Here they are initialized.
i1=1;
i2=1;

for i=1:length(Terms),          %For each term,
    
    %Tv is a local variable representing the pole location.  It is used solely
    %   for convenience.
    Tv=Terms(i).value;
    %Tm is a local variable representing the pole multiplicity.  It is used solely
    %   for convenience.
    Tm=Terms(i).multiplicity;
    %S2 is a blank string to be added to later in the loop.
    S2='';
    
    %The next section of code ("switch" statement) plus a few lines, creates
    %a string that describes the pole or zero, its location, muliplicity...
    %The variable "DescStr" hold a Descriptive String for the pole or zero. The
    %string "S2" is a Second String that holds additional information (if needed)
    switch Terms(i).type,
        case 'Constant',
            %If the term is a consant, print its value in a string.
            DescStr=sprintf('Constant = %0.2g (%0.2g dB)',Tv,20*log10(Tv));
        case 'RealPole',
            %If the term is a real pole, print its value in string.
            DescStr=sprintf('Real Pole at %0.2g',Tv);
        case 'RealZero',
            %If the term is a real zero, print its value in string.
            DescStr=sprintf('Real Zero at %0.2g',Tv);
            if real(Tv)>0,
                DescStr=[DescStr ' RHP (Non-min phase)'];
            end;
        case 'ComplexPole',
            %If the term is a complex pole, print its value in string.
            %However, do this in terms of natural frequency and damping, as
            %well as the actual location of the pole (in S2).
            wn=abs(Tv);
            theta=atan(abs(imag(Tv)/real(Tv)));
            zeta=cos(theta);
            DescStr=sprintf('Complex Pole at wn=%0.2g, zeta=%0.2g',wn,zeta);
            if (zeta < (1/sqrt(2))),  %peaking only if zeta<0.707
                S2=sprintf('(%0.2g +/- %0.2gj)  Circle shows peak height.',real(Tv),imag(Tv));
            else
                S2=sprintf('(%0.2g +/- %0.2gj)  (no peaking, zeta<0.707)',real(Tv),imag(Tv));
            end
        case 'ComplexZero',
            %If the term is a complex zero, print its value in string.
            %However, do this in terms of natural frequency and damping, as
            %well as the actual location of the zero (in S2).
            %Also note if it is a non-minimum phase zero.
            wn=abs(Tv);
            theta=atan(abs(imag(Tv)/real(Tv)));
            zeta=cos(theta);
            DescStr=sprintf('Complex Zero at wn=%0.2g, zeta=%0.2g',wn,zeta);
            if real(Tv)>0,
                DescStr=[DescStr ' (RHP, Non-min phase)'];
            end;
            if (zeta < (1/sqrt(2))),  %peaking only if zeta<0.707
                S2=sprintf('(%0.2g +/- %0.2gj)  Circle shows peak height.',real(Tv),imag(Tv));
            else
                S2=sprintf('(%0.2g +/- %0.2gj)  (no peaking, zeta<0.707)',real(Tv),imag(Tv));
            end
        case 'OriginPole',
            %If pole is at origin, not this.
            DescStr=sprintf('Pole at origin');
        case 'OriginZero',
            %If zero is at origin, not this.
            DescStr=sprintf('Zero at origin');
    end
    %If multiplicity is greater than one, not this as well.
    if Tm>1,
        DescStr=[DescStr sprintf(', mult=%d',Tm)];
    end
    
    %At this point we have a string (in "DescStr" and "S2").
    if Terms(i).display,    %If the term is to be included in plot....
        IncStr=strvcat(IncStr,DescStr); %Add the Desriptive String to IncStr
        IncElem(i1)=i;  %Add the appropriate index to the Included Elements list.
        i1=i1+1;        %Increment the index counter
        y=1-(i1+1)/(length(Terms)+5);   %Calculate the vertical position.
        plot(Xleg,[y y],...             %Plot the line.
            'LineWidth',handles.LnWdth,...
            'LineStyle',GetLineStyle(i,handles),...
            'Color',GetLineColor(i,handles));
        text(XlegText,y,strvcat(DescStr,S2),'FontSize',FntSz);  %Add the text.
    else    %The term is *not* to be included in plot, so...
        ExcStr=strvcat(ExcStr,DescStr); %Add its Desriptive String to IncStr
        ExcElem(i2)=i;  %Add the appropriate index to the Excluded Elements list.
        i2=i2+1;        %Increment the index counter.
    end 
end
hold off;
%Get rid of ticks around plot.
axis([0 1 0 1]);    
set(gca,'Xtick',[]);
set(gca,'Ytick',[]);

%At this point the legend is completed.  Next we will make up the strings
%for the boxes that separately list included and excluded elements.

IncStr=strvcat(IncStr,' ');         %Add a blank line to IncStr.
IncStr=strvcat(IncStr,'-------');   %Add a series of dashes.
%If there are any included elements, we can click on box to exclude it.
if i1~=1
    IncStr=strvcat(IncStr,'Select element to exclude from plot');
end

ExcStr=strvcat(ExcStr,' ');         %Add a blank line to ExcStr
ExcStr=strvcat(ExcStr,'-------');   %Add a series of dashes.
%If there are any excluded elements, we can click on box to include it.
if i2~=1
    ExcStr=strvcat(ExcStr,'Select element to include in plot');
end

%Set the strings for included and excluded elements.
set(handles.IncludedElements,'String',IncStr);
set(handles.ExcludedElements,'String',ExcStr);

%Change the arrays holding included and excluded elements in the handles array.
handles.IncElem=IncElem;
handles.ExcElem=ExcElem;

guidata(handles.AsymBodePlot, handles);  %save changes to handles.
% ------------------End of function BodePlotLegend --------


% --------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function LineWidth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LineWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
% ------------------End of function BodePlotLegend --------


% --------------------------------------------------------------------
% Set the width of the lines used in plots.
function LineWidth_Callback(hObject, eventdata, handles)
% hObject    handle to LineWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.LnWdth=str2num(get(handles.LineWidth,'String'));
guidata(handles.AsymBodePlot, handles);  %save changes to handles.
BodePlotter(handles);                    %Plot the Transfer function.
handles=guidata(handles.AsymBodePlot);   %Reload handles after function call.
% ------------------End of function BodePlotLegend --------


% --------------------------------------------------------------------
% Determines the line color of the ith plot.
function linecolor=GetLineColor(i,handles);
numColors=size(handles.colors,1);
%Cycle through colors by using mod operator.
linecolor=handles.colors(mod(i-1,numColors)+1,:);
% ------------------End of function GetLineColor --------


% --------------------------------------------------------------------
% Determines the line style of the ith plot.
function linestyle=GetLineStyle(i,handles);
numColors=size(handles.colors,1);
numLnStl=size(handles.linestyle,2);
%Cycle through line styles, incrementing after all colors are used.
linestyle=handles.linestyle{mod(ceil(i/numColors)-1,numLnStl)+1};
% ------------------End of function GetLineStyle --------


% --------------------------------------------------------------------
% --- Executes on button press in GrayCheckBox.
% This function sets the sequence of colors used in plotting to gray scales.
function GrayCheckBox_Callback(hObject, eventdata, handles)
if get(handles.GrayCheckBox,'Value')==1,  %If button is not set,
    handles.colors=handles.Gray;             %and set colors to gray scale
    handles.zrefColor=handles.GrayZero;
else                                      
    handles.colors=handles.Color;            %and set colors to RGB
    handles.zrefColor=handles.ColorZero;
end
guidata(handles.AsymBodePlot, handles);   %save changes to handles.
BodePlotter(handles);                     %Plot the Transfer function.
handles=guidata(handles.AsymBodePlot);    %Reload handles after function call.
% ------------------End of function BodePlotLegend --------


% --- Executes on button press in GridCheckBox.
function GridCheckBox_Callback(hObject, eventdata, handles)
BodePlotter(handles);                     %Plot the Transfer function.


% --- Executes on button press in RadianCheckBox.
function RadianCheckBox_Callback(hObject, eventdata, handles)
BodePlotter(handles);                     %Plot the Transfer function.


% --- Executes on button press in WebButton.
function WebButton_Callback(hObject, eventdata, handles)
% hObject    handle to WebButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
web('http://www.swarthmore.edu/NatSci/echeeve1/Ref/Bode/Bode.html','-browser')


