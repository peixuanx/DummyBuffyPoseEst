%% Environment
close all;
clear;
clc;
startup;


%% Prediction

t = datetime('now');
buffydir = './../buffy_s5e2_original/';
episodenr = 2;
out = DummyBuffyPoseEstimationPipeline(buffydir,episodenr);
filename = ['../', datestr(t),'_result.mat'];
filename = 'a.mat';
save(filename, 'out');

%% Evaluation

gt2 = ReadStickmenAnnotationTxt('../data/buffy_s5e2_sticks.txt','episode','2'); 
GTALL = [gt2(:)]'; 
load(filename); 
[detRate PCP] = BatchEval(@detBBFromStickmanBuffy,@EvalStickmen,out,GTALL);