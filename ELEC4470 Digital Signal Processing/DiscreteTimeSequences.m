classdef DiscreteTimeSequences
    methods(Static)
        function [y,n] = timeshift(x, m, l)
            % implements y(n) = x(n-l)
            % -------------------------
            %
            n = m+l;
            y = x;
        end

        function [y,n] = add_seq(x1, n1, x2, n2)
            % % implements addition of x1(n) and x2(n) to produce y(n)
            %n1, n2, are the durations for x1(n) and x2(n), respectively

            %to determine the duration of y(n)
            n = min(min(n1),min(n2)):max(max(n1),max(n2)); 

            % that should start from the min.
            % index of both to the max. index of both 
            y1 = zeros(1,length(n));y2 = zeros(1,length(n));

            % x1 with duration of y
            y1(find((n>=min(n1))&(n<=max(n1))==1))=x1;
            
            % x2 with duration of y
            y2(find((n>=min(n2))&(n<=max(n2))==1))=x2;
            
            y = y1+y2;
        end

        function [y,n] = mult_seq(x1,n1,x2,n2)
            % implements multiplication of x1(n) by x2(n) to produce y(n)
            % n1, n2, are the durations for x1(n) and x2(n), respectively
            % to determine the duration of y(n)
            n = min(min(n1),min(n2)):max(max(n1),max(n2));

            % that should start from the min. index of both to the max. index of both
            y1 = zeros(1,length(n));y2 = zeros(1,length(n));

             % x1 with duration of y
            y1(find((n>=min(n1))&(n<=max(n1))==1))=x1;

            % x2 with duration of y
            y2(find((n>=min(n2))&(n<=max(n2))==1))=x2;
            
            % final result
            y = y1 .* y2;
        end

        function [ny, y] = conv_lab_1(nx1, x1, nx2, x2)
            % convolution with time duration
            % --------------------------------------------------
            % x1, nx1, 1st seq. with its time index
            % x2, nx2, 1st seq. with its time index
            %
            ny_min = nx1(1) + nx2(1);
            ny_max = nx1(length(x1)) + nx2(length(x2));
            
            ny = [ny_min:ny_max];
            y = conv(x1, x2);
        end

        function [x, n] = dt_unit_imp(n0, n1, n2)
        % Generates x(n) = Delta(n-n0); n1 <= n <= n2
            n = [n1:n2];
            x = [(n-n0) == 0];
        end
        
        function [x, n] = dt_unitstep(n0, n1, n2)
        % Generates x(n) = u(n-n0); n1 <= n <= n2 
            n = [n1:n2];
            x = [(n-n0) >= 0];
        end
        
        function [x, n]  = rv_exp_seq(a, n1, n2)
            n = [n1:n2];
            x = [a.^n];
        end
        
        function [x, n]  = cv_exp_seq(rho, omega, n1, n2)
            n = [n1:n2];
            x = [exp((rho + omega*j) * n)];
        end
        
        function [x, n]  = sin_seq(n1, n2)
            n = [n1:n2];
            x = 2*cos(0.2*pi*n+2*pi/3) + 1.5*sin(0.6*pi*n);
        end
    end
end