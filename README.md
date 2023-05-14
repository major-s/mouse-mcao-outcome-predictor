# mouse-mcao-outcome-predictor

## Description

This repository contains models to predict outcome after stroke due to middle cerebral artery occlusion in mice as published in following preprint: 

[Prediction of Stroke Outcome in Mice Based on Non-Invasive MRI and Behavioral Testing](https://doi.org/10.1101/2022.05.13.491869)

The full dataset can be found on [Zenodo](https://doi.org/10.5281/zenodo.6534690)

Each model consists of 50 independently trained random forest ensembles. All models were trained using Matlab 2021a. A simple prediction function which returns predictions by single models by default is present. The median of outcomes predicted by individual models can also be calculated.

## Usage

Clone this repository with git

In Matlab open “Mousemcaooutcomepredictor.prj” in the project root directory to add project paths to current Matlab path

For usage example open the live script “example_usage.mlx” and run sections of interest.

To predict outcome from your own data, you must provide a Matlab table with variables in columns and animals in rows. 
* For segmented MRI (Magnetic Resonance Imaging), the brain regions specified in the Allen Brain Atlas have to be present. Column headings need to contain IDs as used in the Allen Mouse Brain Common Coordinate Framework (CCFv3, https://doi.org/10.1016/j.cell.2020.04.007), white matter structures are additionally labeled with a minus sign followed by the CCFv3 ID.
* For prediction based on total lesion volume, a column labeled “lesionVolume” has to be present. If not specify column name with SinglePredictorColumn option.
* For prediction based on early performance, a column labeled “Day2_6” containing relative performance has to be present. If not specify column name with SinglePredictorColumn option.

`predict_outcome(data, 'Model', 'initial_performance', 'SinglePredictorColumn', 'my_initial_performance')`

## Authors
Copyright owners are the authors of the beforementioned manuscript:

Felix Knab (1,2), Stefan Paul Koch (1-3), Sebastian Major (1,2), Tracy D. Farr (1-4) , Susanne Mueller (1-3), 
Philipp Euskirchen (1), Moritz Eggers (1,2) , Melanie T.C. Kuffner (1,2) , Josefine Walter (1,2,5), Jens P. Dreier (1,2,6,7), 
Matthias Endres (1,2,6-10), Ulrich Dirnagl (1,2,5-10), Nikolaus Wenger (1,2,6,11), 
Christian J. Hoffmann (1,2,11), Philipp Boehm-Sturm(1-3), Christoph Harms (1,2,6,8,9)

1. Charité Universitätsmedizin Berlin, corporate member of Freie Universität Berlin and Humboldt-Universität zu Berlin, Klinik und Hochschulambulanz für Neurologie, Department of Experimental Neurology, Berlin, Germany
2. Charité Universitätsmedizin Berlin, corporate member of Freie Universität Berlin and Humboldt-Universität zu Berlin, Center for Stroke Research Berlin, Berlin, Germany
3. Charité Universitätsmedizin Berlin, corporate member of Freie Universität Berlin and Humboldt-Universität zu Berlin, NeuroCure Cluster of Excellence and Charité Core Facility 7T Experimental MRIs, Berlin, Germany
4. School of Life Sciences, University of Nottingham, UK, NG7 2UH16
5. Berlin Institute of Health at Charité – Universitätsmedizin Berlin, QUEST Center for Transforming Biomedical Research, Berlin, Germany
6. Einstein Center for Neuroscience, Berlin, Germany
7. Bernstein Center for Computational Neuroscience
8. German Center for Cardiovascular Research (DZHK), partner site Berlin
9. NeuroCure Clinical Research Center, Charité-Universitätsmedizin Berlin, Berlin, Germany
10. German Center for Neurodegenerative Diseases (DZNE)
11. Berlin Institute of Health (BIH), Berlin, Germany

## License
The code is licensed under the [GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.html) or later. For license text included in the repository see [CODE_LICENSE](CODE_LICENSE)

The models and any included data are licensed under ![CC BY-NC-SA 4.0](https://i.creativecommons.org/l/by-nc-sa/4.0/80x15.png) [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-nc-sa/4.0/). For license text included in the repositery see [DATA_LICENSE](DATA_LICENSE)
