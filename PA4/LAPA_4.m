%PA4 winter 2022 - 5 feb 2022
%Alina Jacobson

%Laplace equation by iteration
%2D laplace solver using iteration

set(0,'DefaultFigureWindowStyle','docked')
close all;

nx=50;              %matrix V 50 columns
ny=50;              %matrix V 50 rows
maxItr = 1000;      %max number of iteration 1000
%maxItr = 2500;     %max number of iteration 2500
mV=zeros(nx,ny);    %matrix v is all zeros at initization
Ex = zeros(nx,ny);          %e-field x axis
Ey = zeros(nx,ny);          %e-field y axis


%set BC variables
matrixSides =0;


% Loop through the iterations getting a new solution and resetting the BC’s 
for z = 1:maxItr    %loop start at first interation until reach max    
    
    
    for l=1:nx
    
        for r=1:ny
         mV(1,:) = 0;     %set bottom matrix to zero (not working correctly)   
         mV(ny,:) = 0;    %set top matrix to zero (not working correctlly)
            
            
            %set BC for right/left
            if(r==1)
                mV(l,r)=1;     %set left to 1
                     
            elseif(r==ny)  
                mV(l,r)=1;     %set right to 0  or set to 1 (has saddle shape result)
                              
            
            %check the top/bottom nodes          
            elseif(l==1)
                
                
                %then calc for bottom 3 nodes  that are around the particles in the equation
                mV(l,r) = (mV(l+1,r)+mV(l,r+1)+mV(l,r-1))/3; 
             
            elseif(l==nx)      
                 
              
                %then calc the top 3 nodes that are around  
                mV(l,r) = (mV(l-1,r)+mV(l,r-1)+mV(l,r+1))/3;
            else 
                
                
               %calc the 4 nodes internally    
                mV(l,r) = ((mV(l+1,r)+mV(l-1,r)+mV(l,r+1)+mV(l,r-1))/(4));
            end 
         end
     end
       
         %plot the rsults of the iteration using surf()
         if mod(z,50)==0 
            figure(1) 
            surf(mV)  
            xlabel('x position')
            ylabel('y position')
            zlabel('Voltage (V)')
            
            pause(0.5)          
         end           
end   
                   
   
       
%plot E-fields after iterations
[Ex, Ey] = gradient(mV);
figure(2)
quiver(-Ey',-Ex',1)                %to see the vector field
%quiver(-Ey',-Ex',10)
xlabel('E-fields -- x position')
ylabel('y position')

figure(3)
I=imboxfilt(mV,5);
surf(I) 
xlabel('vector fields  imboxfilt() -- x position')
