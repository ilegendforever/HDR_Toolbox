function imgOut = WardImageAlignment(img1, img2, bRotation)
%
%
%       imgOut = WardImageAlignment(img1, img2, bRotation)
%
%       This function shifts pixels on the right with wrapping of the moved
%       pixels. This can be used as rotation on the Y-axis for environment
%       map encoded as longituted-latitude encoding.
%
%       input:
%           -img1: reference image
%           -img2: image to be aligned to img1
%           -bRotation: flag to enable (1) or disable (0) rotational
%           alignment
%
%       output:
%           -imgOut: img2 aligned to img1 using a homography
%
%
%     Copyright (C) 2015  Francesco Banterle
% 
%     This program is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
% 
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with this program.  If not, see <http://www.gnu.org/licenses/>.
%

if(~exist('bRotation', 'var'))
    bRotation = 1;
end
         
shift_ret = WardGetExpShift(img1, img2);
imgOut = imshift(img2, shift_ret);
        
if(bRotation)
    [rot_ret, bCheck] = WardSimpleRot(img1, imgOut);
        
    if(bCheck)
        imgOut = imrotate(imgOut, rot_ret, 'bilinear', 'crop');

        %final shift
        shift_ret = WardGetExpShift(img1, imgOut);
        imgOut = imshift(imgOut, shift_ret);            
    end
end

end