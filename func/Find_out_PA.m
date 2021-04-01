function out_PA = Find_out_PA(in_PA)
    in_PA = reshape(in_PA, length(in_PA),1);
    alpha = [0.102974078888942 - 0.0242531514717656i, 556.793893042275 - 18.3137792997594i,...
            -120312.406545669 + 15219.5681985834i, 14894006.4105878 + 406627.685820018i, ...
            69183.7482281949 + 1888.61768262952i];
    
    in_PA_vector = [ones(size(in_PA)), in_PA, in_PA .* (abs(in_PA).^2), in_PA .* (abs(in_PA).^4), in_PA .* (abs(in_PA).^6)];
    out_PA = in_PA_vector * alpha';
end 