function result_struct = get_result_struct(model_struct, data_table)
%GET_RESULT_STRUCT   Prediction using multiple models on single data set
%
%
% Copyright (C) 2023: The Authors (see AUTHORS)
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <https://www.gnu.org/licenses/>.

    arguments
        model_struct struct
        data_table table
    end

    fnames = fieldnames(model_struct);
    
    for i = 1:length(fnames)
        group = fnames{i};
        trained_model = model_struct.(group).trained_model;
        predicted_performance = trained_model.predictFcn(data_table);
        result_tab = array2table(predicted_performance, 'RowNames', data_table.Properties.RowNames);
        result_struct.(group).result_tab = result_tab;
    end
end