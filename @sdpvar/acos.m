function varargout = acos(varargin)

switch class(varargin{1})
    
    case 'sdpvar'
        varargout{1} = InstantiateElementWise(mfilename,varargin{:});
        
    case 'char'
        
        operator = CreateBasicOperator('decreasing','callback');
        operator.convexity = @convexity;              
        operator.derivative = @(x)real(-((1 - x.^2).^-0.5));
        operator.inverse = @(x)cos(x);
        operator.range = [0 pi];
        operator.domain = [-1 1];
        
        varargout{1} = [];
        varargout{2} = operator;
        varargout{3} = varargin{3};
        
    otherwise
        error(['SDPVAR/' upper(mfilename) ' called with weird argument']);
end

function vexity = convexity(xL,xU)
if xL >= 0  
    vexity = 'concave';
elseif xU <= 0
    vexity = 'convex';
else
    vexity = 'none';
end
