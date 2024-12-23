% This is the GUI for the Gigt Grabber game!
% Author: Paulin Kantue  

clc; 
close all;
clear all;

mainFig = uifigure;
mainFig.Color = [1 1 1];

%% OBJECTS - read images into variables
[basketImgData, ~, basket_alphachannel] = imread('classic-basket.png');
[giftImgData, ~, gift_alphachannel] = imread('christmas-present.png');

%% allocate axes parents to each image
basketAxes = axes(mainFig,'Position',[0.4, 0.0, 0.25, 0.25],...
    'YTickLabel','',...
    'XTickLabel','');
basketImgObj = imshow(basketImgData,'Parent',basketAxes);
basketImgObj.AlphaData = basket_alphachannel;

giftAxes = axes(mainFig,'Position',[0.4, 0.7, 0.15, 0.15],...
    'YTickLabel','',...
    'XTickLabel','');
giftImgObj = imshow(giftImgData,'Parent',giftAxes);
giftImgObj.AlphaData = gift_alphachannel;

%% Buttons used for left and right movement
leftBtn = uibutton(mainFig,...
    'Text','LEFT',...
    'Position',[10 10 50 30],...
    'ButtonPushedFcn',{@updateBasketPos,basketAxes,-1});

rightBtn = uibutton(mainFig,...
    'Text','RIGHT',...
    'Position',[65 10 50 30],...
    'ButtonPushedFcn',{@updateBasketPos,basketAxes,1});

scoreObj = uilabel(mainFig);
scoreObj.Text = "Game Start";
scoreObj.FontSize = 14;
scoreObj.Position = [0.8, 0.8, 100, 50];

timerObj = timer('StartDelay', 4, 'Period', 0.5,...
          'ExecutionMode', 'fixedRate');
timerObj.StartFcn = @(~,~)disp('Simulation has started');
timerObj.TimerFcn = {@updateSim,giftAxes,basketAxes};
timerObj.StopFcn = @(~,~)disp('Simulation has stopped');
% timerObj.StartFcn = {@updateSim,giftAxes,basketAxes};

startBtn = uibutton(mainFig,...
    'Text','START',...
    'Position',[10 200 50 30],...
    'ButtonPushedFcn',{@startSim,giftAxes,basketAxes,timerObj});
addprop(startBtn,'StartSim');


%% functions
function startSim(src,event,giftAxes,basketAxes,timerObj)

src.StartSim = 1;
start(timerObj);
giftAxes.Position(2) = 0.7;
basketAxes.Position(1) = 0.4;

% setup random position of the gift
leftpos = 0.2;
rightpos = 0.7;
randpos = leftpos + (rightpos - leftpos)*rand();

giftAxes.Position(1) = randpos;

end

function updateSim(src,event,giftAxes,basketAxes)
% update position of gift
giftAxes.Position(2) = giftAxes.Position(2) - 0.025;

% check limit before 
checklim = giftAxes.Position(2);

if checklim < 0.05
    stop(src); % stop timer
    
    % if gift and basket are aligned game point is increased
    % and increase drop speed 
    if abs(giftAxes.Position(2) - basketAxes.Position(2)) < 0.06

    else
        % game has ended
    end
end

end

function updateBasketPos(src,event,basketAxes,direction)

posx = basketAxes.Position(1) + 0.05*(direction);

if posx >= 0.7
    posx = 0.7;
elseif posx < 0.2
    posx = 0.2;
end

basketAxes.Position(1) = posx;
end