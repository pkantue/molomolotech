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
basketAxes = axes(mainFig,'Position',[0.4, 0.0, 0.13, 0.13],...
    'YTickLabel','',...
    'XTickLabel','');
basketImgObj = imshow(basketImgData,'Parent',basketAxes);
basketImgObj.AlphaData = basket_alphachannel;

giftAxes = axes(mainFig,'Position',[0.4, 0.7, 0.08, 0.08],...
    'YTickLabel','',...
    'XTickLabel','');
giftImgObj = imshow(giftImgData,'Parent',giftAxes);
giftImgObj.AlphaData = gift_alphachannel;

%% Buttons used for left and right movement
% leftBtn = uibutton(mainFig,...
%     'Text','LEFT',...
%     'Position',[10 10 50 30],...
%     'ButtonPushedFcn',{@updateBasketPos,basketAxes,-1});
% 
% rightBtn = uibutton(mainFig,...
%     'Text','RIGHT',...
%     'Position',[65 10 50 30],...
%     'ButtonPushedFcn',{@updateBasketPos,basketAxes,1});

%% Score object
scoreObj = uilabel(mainFig);
scoreObj.Text = "Press Start";
scoreObj.FontSize = 20;
scoreObj.Position = [10, 350, 150, 50];
addprop(scoreObj,'score');
addprop(scoreObj,'fallSpeed');
scoreObj.score = 0;
scoreObj.fallSpeed = 0;

timerObj = timer('StartDelay', 4, 'Period', 0.2,...
          'ExecutionMode', 'fixedRate');
timerObj.StartFcn = @(~,~)disp('Simulation has started');
timerObj.TimerFcn = {@updateSim,giftAxes,basketAxes,scoreObj};
timerObj.StopFcn = @(~,~)disp('Simulation has stopped');
% timerObj.StartFcn = {@updateSim,giftAxes,basketAxes};

set(mainFig,'KeyPressFcn',@myfun);

function myfun(src,event)
xpos = src.Children(4).Position(1);

switch event.Key
    case 'rightarrow'
        xpos = xpos + 0.05;
    case 'leftarrow'
        xpos = xpos - 0.05;
end

src.Children(6).Position(1) = xpos;

end

startBtn = uibutton(mainFig,...
    'Text','START',...
    'Position',[10 200 50 30],...
    'ButtonPushedFcn',{@startSim,giftAxes,basketAxes,timerObj,scoreObj});

%% functions
function startSim(src,event,giftAxes,basketAxes,timerObj,scoreObj)

% initialize the simulation
if scoreObj.score == 0
    scoreObj.fallSpeed = 0.03;
    basketAxes.Position(1) = 0.4;
    % start simulation
    start(timerObj);
end

giftAxes.Position(2) = 0.7;

% setup random position of the gift
leftpos = 0.2;
rightpos = 0.7;
randpos = leftpos + (rightpos - leftpos)*rand();

giftAxes.Position(1) = randpos;

scoreObj.Text = ['Score = ' num2str(scoreObj.score) 'pts'];

end

function updateSim(src,event,giftAxes,basketAxes,scoreObj)

% update position of gift
giftAxes.Position(2) = giftAxes.Position(2) - scoreObj.fallSpeed;

% check limit before 
checklim = giftAxes.Position(2);

if checklim < 0.05
    % if gift and basket are aligned game point is increased
    % and increase drop speed 
    if abs(giftAxes.Position(1) - basketAxes.Position(1)) < 0.085
        scoreObj.score = scoreObj.score + 10;
<<<<<<< HEAD
        scoreObj.fallSpeed = scoreObj.fallSpeed + 0.01;
=======
        scoreObj.fallSpeed = scoreObj.fallSpeed + 0.03;
>>>>>>> 6e1bc3348e44887c3504af62fab808c7246cc19e
        scoreObj.Text = ['Score = ' num2str(scoreObj.score) 'pts'];
        startSim('','',giftAxes,basketAxes,src,scoreObj)
    else
        % game has ended
<<<<<<< HEAD
        scoreObj.Text = ['Score = ' num2str(scoreObj.score) 'pts'];
=======
        scoreObj.Text = 'Game Over!';
>>>>>>> 6e1bc3348e44887c3504af62fab808c7246cc19e
        scoreObj.score = 0;
        stop(src); % stop timer
        % startSim('','',giftAxes,basketAxes,src,scoreObj);
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