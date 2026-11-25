[![Abcdspec-compliant](https://img.shields.io/badge/ABCD_Spec-v1.1-green.svg)](https://github.com/brain-life/abcd-spec)
[![Run on Brainlife.io](https://img.shields.io/badge/Brainlife-brainlife.app.461-blue.svg)](https://doi.org/10.25663/brainlife.app.461)

# Generate images of cortex mapped data

<!-- brainlife-app:begin (generated from the App manifest; edit the manifest, not this block) -->

**Projects tract endpoint density ROIs onto the FreeSurfer white surface and renders JPEG images of each on the cortical surface with PySurfer, for visual quality control.**

Maps every volume in the ROIs datatype to the left and/or right white surface with mri_vol2surf (hemisphere inferred from the file name), then draws each map on the chosen surface with PySurfer using the chosen colormap and percentile range, saving several views as JPEGs. Use it to inspect where tracts terminate on the cortex. ROIs must be in the FreeSurfer subject's space (header registration is assumed). Visualisation only.

Run it on brainlife.io: [https://doi.org/10.25663/brainlife.app.555](https://doi.org/10.25663/brainlife.app.555)

| Input | Datatype | Required | Description |
|---|---|---|---|
| `freesurfer` | `neuro/freesurfer` | yes | Path to the freesurfer dataset. Needed for image generation, even when surface = midthickness |
| `rois` | `neuro/rois` (tractEndpointDensity) | yes | Tract endpoint density volumes, one NIfTI per tract end; files whose names contain left/lh or right/rh are mapped to that hemisphere only. Must be aligned to the FreeSurfer subject (mri_vol2surf --regheader). |

| Output | Datatype | Description |
|---|---|---|
| `images` | `generic/images` | File containing multiple images of different views of each tract endpoint |

| Parameter | Type | Default | Description |
|---|---|---|---|
| `surface` | enum | `inflated` | Surface to use in the image. Pial, white, and inflated come from freesurfer's standard segmentation. Midthickness comes from Cortex Mapping datatype Options: `pial`, `white`, `inflated`. |
| `min_percentile` | number | `4` | Minimum percentile to map to colorbar |
| `max_percentile` | number | `96` | Maximum percentile to map to colorbar |
| `threshold` | number | `1e-09` | Threshold value to use for computing minimum, median, and maximum values to map colormap to. Will update to plot only data above threshold once functionality is available. |
| `colormap` | enum | `hot` | Matplotlib colormap to use for representing data mapped to cortical surface. 'Videen_style' is based on Connectome Workbench's and nilearn's colormap scheme. Default: videen_style Options: `videen_style`, `viridis`, `plasma`, `inferno`, `magma`, `cividis`, `Greys`, `Purples`, `Blues`, `Greens`, `Reds`, `YlOrBr`, `YlOrRd`, `OrRd`, `PuRd`, `RdPu`, `BuPu`, `GnBu`, `PuBu`, `YlGnBu`, `PuBuGn`, `BuGn`, `YlGn`, `binary`, `gist_yarg`, `gist_gray`, `gray`, `bone`, `pink`, `spring`, `summer`, `autumn`, `winter`, `cool`, `Wistia`, `hot`, `afmhot`, `gist_heat`, `copper`, `PiYG`, `PRGn`, `BrBG`, `PuOr`, `RdGy`, `RdBu`, `RdYlBu`, `RdYlGn`, `Spectral`, `coolwarm`, `bwr`, `seismic`, `twilight`, `twilight_shifted`, `hsv`, `flag`, `prism`, `ocean`, `gist_earth`, `terrain`, `gist_stern`, `gnuplot`, `gnuplot2`, `CMRmap`, `cubehelix`, `brg`, `gist_rainbow`, `rainbow`, `jet`, `turbo`, `nipy_spectral`, `gist_ncar`. |

Runtime: container `brainlife/freesurfer:6.0.0`; 4 CPUs; 1 h walltime; needs `FREESURFER_LICENSE`.

<!-- brainlife-app:end -->

This app will generate images (jpgs) of data mapped to the cortical surface using MNE-python's (https://mne.tools/stable/index.html) build of pysurfer (https://pysurfer.github.io/index.html). Images (jpgs) of lateral and medial views of data mapped to a given surface are outputted. The intent of these apps is to provide quick QA and to potentially generate figures for a paper figure.

### Authors 

- Brad Caron (bacaron@iu.edu) 

### Contributors 

- Soichi Hayashi (hayashis@iu.edu) 

### Funding 

[![NSF-BCS-1734853](https://img.shields.io/badge/NSF_BCS-1734853-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1734853)
[![NSF-BCS-1636893](https://img.shields.io/badge/NSF_BCS-1636893-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1636893)
[![NSF-ACI-1916518](https://img.shields.io/badge/NSF_ACI-1916518-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1916518)
[![NSF-IIS-1912270](https://img.shields.io/badge/NSF_IIS-1912270-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1912270)
[![NIH-NIBIB-R01EB029272](https://img.shields.io/badge/NIH_NIBIB-R01EB029272-green.svg)](https://grantome.com/grant/NIH/R01-EB029272-01)

### Citations 

Please cite the following articles when publishing papers that used data, code or other resources created by the brainlife.io community. 

1. Gramfort A, Luessi M, Larson E, Engemann DA, Strohmeier D, Brodbeck C, Goj R, Jas M, Brooks T, Parkkonen L, Hämäläinen M. MEG and EEG data analysis with MNE-Python. Front Neurosci. 2013 Dec 26;7:267. doi: 10.3389/fnins.2013.00267. PMID: 24431986; PMCID: PMC3872725.

## Running the App 

### On Brainlife.io 

You can submit this App online at [https://doi.org/10.25663/brainlife.app.461](https://doi.org/10.25663/brainlife.app.461) via the 'Execute' tab. 

### Running Locally (on your machine) 

1. git clone this repo 

2. Inside the cloned directory, create `config.json` with something like the following content with paths to your input files. 

```json 
{
   "freesurfer":    "testdata/freesurfer/output",
   "cortexmap":    "testdata/cortexmap/",
   "surface": "midthickness",
   "min_percentile": 4,
   "max_percentile": 96,
   "threshold": 0.00000001,
   "colormap": "videen_style"
} 
``` 

### Sample Datasets 

You can download sample datasets from Brainlife using [Brainlife CLI](https://github.com/brain-life/cli). 

```
npm install -g brainlife 
bl login 
mkdir input 
bl dataset download 
``` 

3. Launch the App by executing 'main' 

```bash 
./main 
``` 

## Output 

The main output of this App is contain a folder containing jpg images of lateral and medial views of cortex mapped data.

#### Product.json 

The secondary output of this app is `product.json`. This file allows web interfaces, DB and API calls on the results of the processing. 

### Dependencies 

This App requires the following libraries when run locally. 

- jsonlab: https://github.com/fangq/jsonlab
- singularity: https://singularity.lbl.gov/quickstart
