function [model] = mysvm(X,Y,C,tol,kernel)

m=size(X,1);
n=size(X,2);
Y(find(Y==0))=-1;
alpha=zeros(m,1);
w=zeros(n,1);
b=0;
max_ite=20;
ite=1;
k=1;

if strcmp(func2str(kernel), 'LinearKernel')
    K = X*X';
elseif strfind(func2str(kernel), 'GaussianKernel')
    X2 = sum(X.^2, 2);
    K = bsxfun(@plus, X2, bsxfun(@plus, X2', - 2 * (X * X')));
    K = kernel(1, 0) .^ K;
else
    K = zeros(m);
    for i = 1:m
        for j = i:m
            K(i,j) = kernel(X(i,:)', X(j,:)');
            K(j,i) = K(i,j); 
        end
    end
end

while ite<=max_ite
    
    for i=1:m
        ui=sum(Y.*alpha.*K(:,i))-b;
        Ei=ui-Y(i);
        alpha_change=0;
        if (Ei*Y(i)>0&&alpha(i)>0)||(Ei*Y(i)<0&&alpha(i)<C)
        
            j=ceil(m*rand());
            while i==j
                j=ceil(m*rand());
            end
            
            if Y(i)*Y(j)==-1
                L=max(0,alpha(j)-alpha(i));
                H=min(C,C+alpha(j)-alpha(i));
            else
                L=max(0,alpha(i)+alpha(j)-C);
                H=min(C,alpha(i)+alpha(j));
            end
            
            uj=sum(Y.*alpha.*K(:,j))-b;
            Ej=uj-Y(j);
            Yita=K(i,i)+K(j,j)-2*K(i,j);
            if Yita<=0
                continue;
            end
            j_unclip=alpha(j)+Y(j)*(Ei-Ej)/Yita;
            
            if j_unclip>H
                j_new=H;
            elseif j_unclip<L
                j_new=L;
            else
                j_new=j_unclip;
            end
            
            if abs(j_new-alpha(j))<=tol
                continue
            end
            
            i_new=alpha(i)+Y(i)*Y(j)*(alpha(j)-j_new);
            b1=Ei+Y(i)*(i_new-alpha(i))*K(i,i)+Y(j)*(j_new-alpha(j))...
                *K(i,j)+b;
            b2=Ej+Y(i)*(i_new-alpha(i))*K(i,j)+Y(j)*(j_new-alpha(j))...
                *K(j,j)+b;
            
            if i_new>0&&i_new<C
                b=b1;
            elseif j_new>0&&j_new<C
                b=b2;
            else
                b=(b1+b2)/2;
            end
            
            alpha(i)=i_new;
            alpha(j)=j_new;
            alpha_change=alpha_change+1;
        end  
    end
    
    if alpha_change==0
        ite=ite+1;
    else
        ite=1;
    end
   
end
model.w=((alpha.*Y)'*X)';
model.b=-b;
model.alpha=alpha;
model.kernel_fun=kernel;
model.X=X;
model.y=Y;
end

