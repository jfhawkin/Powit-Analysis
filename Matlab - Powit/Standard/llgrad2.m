% Calculate logit probability for chosen alternatives for each person
%    with multiple choice situations for each person and multiple people,
%    using globals for all inputs except coefficients.
% Written by Kenneth Train, first version on July 14, 2006..
%    lastest edits on Sept 24, 2006.
%
% Simulated Mixed Logit Probability and gradient
% Powit probability is Prod_t { 1/(1+SUM_j[(V_jt).^-alpha]) }
%    where * denotes chosen alternative, j is alternative, t is choice situation.
% 
% Input f contains the fixed coefficients, and has dimension NFX1.
% Input c contains the random coefficients for each person, and has dimensions NV x NP.
% Either input can be an empty matrix. 
% Output p contains the logit probabilities, which is a row vector of dimension 1xNP.
% Output g contains the gradients of log(p), which is a matrix (NF+NV+NV+NA) x NP
% Code assumes that all GLOBALS already exist.

function [p, g]=llgrad2(f,b,w,a); 

global NV NF NA NP NDRAWS NALTMAX NCSMAX NMEM NTAKES
global X XC S SC XF XFC XA XAC DR 
global MDR

p=zeros(1,NP);
g=zeros(NF+NV+NV+NA,NP);

for r=1:NTAKES   %NTAKES is the number of draws that are are read into memory at one time                              %NTAKE=NDRAWS./NMEM. These must be divisable as an integer. 

if NTAKES>1
   DR=MDR.Data(1).drs((r-1).*NMEM+1:r.*NMEM,:,:); %Dimensions: NMEM x NP x NV
   DR=permute(DR,[3,2,1]); %To make NV x NP x NMEM
end

c=trans(b,w,DR);   %Transforms draws into random coefficients c is NV x NP x NMEM
v=zeros(NMEM,NALTMAX-1,NCSMAX,NP);
if NF > 0
   ffc=reshape(f,1,1,NF,1);
   ffc=repmat(ffc,[1,NCSMAX,1,NP]);
   ff=reshape(f,1,1,NF,1);
   ff=repmat(ff,[NALTMAX-1,NCSMAX,1,NP]);
   vfc=reshape(sum(XFC.*ffc,3),1,NCSMAX,NP);  %vfc is 1 x NCSMAX x NP
   vf=reshape(sum(XF.*ff,3),NALTMAX-1,NCSMAX,NP);  %vf is (NALTMAX-1) x NCSMAX x NP
else
   vfc=zeros(1,NCSMAX,NP);
   vf=zeros(NALTMAX-1,NCSMAX,NP);
end
vfc=repmat(vfc,[1,1,1,NMEM]);
vf=repmat(vf,[1,1,1,NMEM]);

if NV >0
   cc1=reshape(c,1,1,NV,NP,NMEM);
   cc2=reshape(c,1,1,NV,NP,NMEM);
   cc1=repmat(cc1,[1,NCSMAX,1,1,1]);
   cc2=repmat(cc2,[NALTMAX-1,NCSMAX,1,1,1]);
   vc=(repmat(XC,[1,1,1,1,NMEM]).*cc1); %v is 1 x NCSMAX x NV x NP x NMEM
   v=(repmat(X,[1,1,1,1,NMEM]).*cc2); %v is (NALTMAX-1) x NCSMAX x NV x NP x NMEM
   v=reshape(sum(v,3),NALTMAX-1,NCSMAX,NP,NMEM);             %v is (NALTMAX-1) x NCSMAX x NP x NMEM
   
   vc=vc+vfc;
   v=v+vf;
else
   vc=vfc;
   v=vf;
end

v=v.^-a;
vc=vc.^-a;
v(isinf(v))=10.^20;  %As precaution when exp(v) is too large for machine
v=v.*repmat(S,[1,1,1,NMEM]);
vc=vc.*repmat(SC,[1,1,1,NMEM]);
pp=vc./(vc+sum(v,1)); %pp is 1 x NCSMAX x NP x NMEM

%Calculate gradient
  vc=vc.*repmat(S,[1,1,1,NMEM]);
  gg=[v;vc].*repmat(pp,[NALTMAX,1,1,1]);   %Probs for unchosen alts NALTMAX x NCSMAX x NP x NMEM 
  gg=reshape(gg,NALTMAX,NCSMAX,1,NP,NMEM);
  if NF>0
      grf=-repmat(gg,[1,1,NF,1,1]).*repmat([XF],[1,1,1,1,NMEM]);
      grf=reshape(sum(sum(grf,1),2),NF,NP,NMEM);   %NFxNPxNMEM
  else
      grf=[];
  end
  
  gra=-repmat(gg,[1,1,NA,1,1]).*repmat([XA],[1,1,1,1,NMEM]);
  gra=reshape(sum(sum(gra,1),2),NA,NP,NMEM);   %NAxNPxNMEM
  
  if NV>0
      gg=-repmat(gg,[1,1,NV,1,1]).*repmat(X,[1,1,1,1,NMEM]);
      [grb grw]=der(b,w,DR);
      grb=reshape(grb,1,1,NV,NP,NMEM);
      grw=reshape(grw,1,1,NV,NP,NMEM);
      grb=gg.*repmat(grb,[NALTMAX-1,NCSMAX,1,1,1]);
      grw=gg.*repmat(grw,[NALTMAX-1,NCSMAX,1,1,1]);
      grb=reshape(sum(sum(grb,1),2),NV,NP,NMEM);   %NVxNPxNMEM 
      grw=reshape(sum(sum(grw,1),2),NV,NP,NMEM);   %NVxNPxNMEM
  else
      grb=[];
      grw=[];
  end
  

%Back to prob
pp=reshape(pp,NCSMAX,NP,NMEM);     %pp is now NCSMAX x NP x NMEM
pp=prod(pp,1);      %pp is 1xNPxNMEM
gr=[grf;grb;grw;gra];
%Gradient
   gr=gr.*repmat(pp,[NF+NV+NV+NA,1,1]);
   g=g+sum(gr,3);  %gr is (NF+NV+NV+NA) x NP

%Back to prob
pp=sum(pp,3);       %pp is 1xNP

p=p+pp;

end

p=p./NDRAWS;
p(1,isnan(p))=1; %Change missing values to 1, as a precaution. 
%Gradient
   g=g./NDRAWS;
   g=g./repmat(p,NF+NV+NV+NA,1);