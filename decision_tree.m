
% Now, create and view a regression tree.
load carsmall % load the sample data, contains Horsepower, Weight, MPG
list ={'Horsepower', 'Weight' ,'Acceleration', 'MPG', 'Displacement'};
X = [Horsepower Weight Acceleration MPG Displacement];

d1=[32,22,215,13.6,4500];

   d2=[25,32,245,12.4,3600];
    
    d3=[24,45,260,11.5,3258];
    
values =[]
tree=''
max =0;
temp2 =0;
[rows,cols] = size(X);


for v = 1:5
    a = entropy(X(:,v));
    
    X(rows+1,v)=a;
end
X = X';
[Y] = sortrows(X,101);
X=Y';
discrete_dim=6;
%disp('hello')
%X
for v = 1:5
    
    
    X(rows+2,v)=6-v;
end
dim =10;
X = X';
[Y] = sortrows(X,102);
X=Y';
X =X(1:end-2,:);
X
D =[135,28,100,17.1,32];
rtree =use_tree(X,dim,discrete_dim,Origin,list);
tree = prune(rtree,'level',1);
view(rtree)
view(tree)

%cross validation
%Label = predict(rtree,D)
%label1 =predict(tree,d1)
%label2=predict(tree,d2)
%label3 =predict(tree,d3)

figure;
h=histogram(X);
h


function [rtree] = use_tree(X,dim,discrete_dim,Origin,list)
%Classify recursively using a tree
targets = zeros(1, size(X,2));
if (dim == 0)
    %Reached the end of the tree
    targets(indices) = tree.child;
    return
end
%This is not the last level of the tree, so:
%First, find the dimension we are to work on
dim = dim;
dims= 1:size(X,1);
%And classify according to it
if (discrete_dim == 0),
    %Continuous pattern
    in				= indices(find(X(dim, indices) <= tree.split_loc));
    in				= indices(find(X(dim, indices) >  tree.split_loc));
    
else
    %Discrete pattern
    Uf				= unique(X(:,1));
    tree ='';
    for i = 1:length(Uf),
        if any(Uf(i) == tree) %Has this sort of data appeared before? If not, do nothing
            in   	= indices(find(X(dim, indices) == Uf(i)));
           
        end
     
    end
    
end
rtree = classregtree(X,Origin,'names',list,'categorical',1,'prune','on');
end


   
% create classification tree

 % graphic description

