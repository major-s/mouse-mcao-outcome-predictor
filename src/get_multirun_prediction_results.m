function multirun_prediction_tab = get_multirun_prediction_results(result_struct, options)
%GET_MULTIRUN_PREDICTION_RESULT   Collect prediction results from struct into a table
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
        result_struct struct
        options.Type char = 'all'
    end

    % join results from single models into one table
    fnames = fieldnames(result_struct);
    fname = fnames{1};
    multirun_prediction_tab = result_struct.(fname).result_tab;
    for i = 2:length(fnames)
        fname = fnames{i};
        multirun_prediction_tab = join(multirun_prediction_tab, result_struct.(fname).result_tab, 'LeftKeys', 'Row', 'RightKeys', 'Row');
    end
    multirun_prediction_tab.Properties.VariableNames = fnames;
    
    % return only median prediction if set
    if strcmp(options.Type, 'median')
        median_prediction = median(multirun_prediction_tab.Variables, 2);
        row_names = multirun_prediction_tab.Properties.RowNames;
        multirun_prediction_tab = array2table(median_prediction, 'RowNames', row_names);
    end
end