function outcome_table = predict_outcome(data_table, options)
%PREDICT_OUTCOME   Predict functional outcome after stroke in mice.
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
       data_table table
       options.Model char = 'segmented_mri'
       options.Type char = 'all'
       options.SinglePredictorColumn char = ''
    end

    % we need to supress these warnings while working with exported models
    warnings = {'MATLAB:load:classNotFound', 'MATLAB:dispatcher:UnresolvedFunctionHandle'};
    % store previous warning state in cell array and deactivate.
    wstates = {};
    for widx = 1:length(warnings)
        w = warning('query', warnings{widx});
        wstates{widx} = w.state; %#ok<AGROW>
        warning('off', warnings{widx});
    end

    
    
    if strcmp(options.Model, 'initial_deficit')
        options.Model = 'initial_performance';
    end
    data_table_mod = data_table;
    if ~strcmp(options.SinglePredictorColumn,'')
        if strcmp(options.Model, 'initial_performance')
            if sum(ismember(data_table_mod.Properties.VariableNames, 'Day2_6')) > 0
                error('Your table has already a "Day2_6" column. Run without SinglePredictorColumn')
            end    
            data_table_mod = renamevars(data_table, [options.SinglePredictorColumn], ['Day2_6']);
        elseif strcmp(options.Model, 'lesion_volume')
            if sum(ismember(data_table_mod.Properties.VariableNames, 'lesionVolume')) > 0
                error('Your table has already a "lesion_volume" column. Run without SinglePredictorColumn')
            end
            data_table_mod = renamevars(data_table, [options.SinglePredictorColumn], ['lesion_volume']);
        end 
    end
    available_models = {'segmented_mri'; 'initial_performance'; 'lesion_volume'};
    if not(ismember(options.Model, available_models))
        error([options.Model, ' is not a valid model for this function. Please use any of: ', strjoin(available_models, ', ')])
    end
    model_name = [char(options.Model), '_models'];
    mat_file = [model_name, '.mat'];
    mat_file_path = fullfile('models', mat_file);
    tmp_struct = load(mat_file_path);
    model_struct = tmp_struct.(model_name);
    result_struct = get_result_struct(model_struct, data_table_mod);
    outcome_table = get_multirun_prediction_results(result_struct, 'Type', options.Type);
    
    % restore warnings
    for widx = 1:length(warnings)
        warning(wstates{widx}, warnings{widx});
    end
end