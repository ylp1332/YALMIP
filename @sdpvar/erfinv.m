function varargout = erfinv(varargin)

switch class(varargin{1})

    case 'sdpvar'
        varargout{1} = InstantiateElementWise(mfilename,varargin{:});

    case 'char'
                            
        operator = CreateBasicOperator('increasing','callback');
        operator.convexity = @convexity;        
        operator.domain = [-1 1];
        operator.inverse = @(x)(erf(x));
        operator.derivative = @(x)(1./(exp(-((erfinv(x))).^2)*2/sqrt(pi)));
        
        varargout{1} = [];
        varargout{2} = operator;
        varargout{3} = varargin{3};

    otherwise
        error(['SDPVAR/' upper(mfilename) ' called with weird argument']);
end

function vexity = convexity(xL,xU)
if xL >= 0  
    vexity = 'convex';
elseif xU <= 0
   vexity = 'concave';
else
    vexity = 'none';
end


