<h1 align="center">Generate images of cortex-mapped data</h1>

<p align="center">
  JPEG images of surface-mapped measures or tract endpoints drawn on the cortical surface, for quick quality control and figures.
</p>

<p align="center">
  <a href="https://github.com/brainlife/abcd-spec"><img src="https://img.shields.io/badge/ABCD_Spec-v1.1-green.svg" alt="ABCD Spec v1.1"></a>
  <a href="https://doi.org/10.25663/brainlife.app.555"><img src="https://img.shields.io/badge/Brainlife-brainlife.app.555-blue.svg" alt="Run on brainlife.io"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-lightgrey.svg" alt="MIT license"></a>
</p>

## At a glance

<!-- brainlife-app:begin (generated from the App manifest; edit the manifest, not this block) -->

> **Projects tract endpoint density ROIs onto the FreeSurfer white surface and renders JPEG images of each on the cortical surface with PySurfer, for visual quality control.**

Maps every volume in the ROIs datatype to the left and/or right white surface with mri_vol2surf (hemisphere inferred from the file name), then draws each map on the chosen surface with PySurfer using the chosen colormap and percentile range, saving several views as JPEGs. Use it to inspect where tracts terminate on the cortex. ROIs must be in the FreeSurfer subject's space (header registration is assumed). Visualisation only.

| | |
|---|---|
| **Inputs** | `neuro/freesurfer` · `neuro/rois` |
| **Outputs** | `generic/images` |
| **Container** | `brainlife/freesurfer:6.0.0` |
| **Resources** | 4 CPUs · 1 h walltime |
| **Requires** | `FREESURFER_LICENSE` |
| **Run it** | [doi.org/10.25663/brainlife.app.555](https://doi.org/10.25663/brainlife.app.555) |

#### Inputs

| Input | Datatype | Required | Description |
|---|---|---|---|
| `freesurfer` | `neuro/freesurfer` | yes | Path to the freesurfer dataset. Needed for image generation, even when surface = midthickness |
| `rois` | `neuro/rois` (tractEndpointDensity) | yes | Tract endpoint density volumes, one NIfTI per tract end; files whose names contain left/lh or right/rh are mapped to that hemisphere only. Must be aligned to the FreeSurfer subject (mri_vol2surf --regheader). |

#### Outputs

| Output | Datatype | Description |
|---|---|---|
| `images` | `generic/images` | File containing multiple images of different views of each tract endpoint |

<details>
<summary><b>Parameters</b> (5)</summary>

| Parameter | Type | Default | Description |
|---|---|---|---|
| `surface` | enum | `inflated` | Surface to use in the image. Pial, white, and inflated come from freesurfer's standard segmentation. Midthickness comes from Cortex Mapping datatype Options: `pial`, `white`, `inflated`. |
| `min_percentile` | number | `4` | Minimum percentile to map to colorbar |
| `max_percentile` | number | `96` | Maximum percentile to map to colorbar |
| `threshold` | number | `1e-09` | Threshold value to use for computing minimum, median, and maximum values to map colormap to. Will update to plot only data above threshold once functionality is available. |
| `colormap` | enum | `hot` | Matplotlib colormap to use for representing data mapped to cortical surface. 'Videen_style' is based on Connectome Workbench's and nilearn's colormap scheme. Default: videen_style Options: `videen_style`, `viridis`, `plasma`, `inferno`, `magma`, `cividis`, `Greys`, `Purples`, `Blues`, `Greens`, `Reds`, `YlOrBr`, `YlOrRd`, `OrRd`, `PuRd`, `RdPu`, `BuPu`, `GnBu`, `PuBu`, `YlGnBu`, `PuBuGn`, `BuGn`, `YlGn`, `binary`, `gist_yarg`, `gist_gray`, `gray`, `bone`, `pink`, `spring`, `summer`, `autumn`, `winter`, `cool`, `Wistia`, `hot`, `afmhot`, `gist_heat`, `copper`, `PiYG`, `PRGn`, `BrBG`, `PuOr`, `RdGy`, `RdBu`, `RdYlBu`, `RdYlGn`, `Spectral`, `coolwarm`, `bwr`, `seismic`, `twilight`, `twilight_shifted`, `hsv`, `flag`, `prism`, `ocean`, `gist_earth`, `terrain`, `gist_stern`, `gnuplot`, `gnuplot2`, `CMRmap`, `cubehelix`, `brg`, `gist_rainbow`, `rainbow`, `jet`, `turbo`, `nipy_spectral`, `gist_ncar`. |

</details>

<!-- brainlife-app:end -->

## Versions on brainlife.io

This repository hosts two Apps, each built from its own branch. Both render images with [MNE-Python](https://mne.tools/stable/index.html)'s build of [PySurfer](https://pysurfer.github.io/) and do not change the data.

| App | Draws | Branch | Run it | Status |
|---|---|---|---|---|
| Generate images of tract endpoints on cortical surface | tract endpoint density ROIs (`neuro/rois`) | [`tract-endpoints-v1.0`](https://github.com/brainlife/app-cortex-mapping-images/tree/tract-endpoints-v1.0) | [doi:10.25663/brainlife.app.555](https://doi.org/10.25663/brainlife.app.555) | current |
| Generate images of data mapped to cortical surface | surface-mapped measures (`neuro/cortexmap`) | [`v1.0`](https://github.com/brainlife/app-cortex-mapping-images/tree/v1.0) | [doi:10.25663/brainlife.app.461](https://doi.org/10.25663/brainlife.app.461) | current |

## Running the App

### On brainlife.io

Both Apps need the subject's FreeSurfer output (`neuro/freesurfer`), even when another surface is drawn.

- **Cortex-mapped data** ([doi.org/10.25663/brainlife.app.461](https://doi.org/10.25663/brainlife.app.461)): also choose a `neuro/cortexmap` dataset. Pick the `surface` to draw on (`midthickness`, the default, comes from the cortexmap; `pial`, `white` and `inflated` come from FreeSurfer). With `midthickness`, the advanced option `fsaverage` can replace the subject's surfaces with a bundled fsaverage template (`fsaverage`, `fsaverage3`–`fsaverage6`, `fsaverage_sym`). Lateral and medial views are saved for each measure and hemisphere.
- **Tract endpoints** ([doi.org/10.25663/brainlife.app.555](https://doi.org/10.25663/brainlife.app.555)): also choose a `neuro/rois` dataset tagged `tractEndpointDensity`, aligned to the FreeSurfer subject. Each volume is projected onto the white surface with `mri_vol2surf`, then drawn on the chosen surface (`inflated` by default, or `pial` or `white`). Lateral, medial, rostral, caudal, ventral and dorsal views are saved for each ROI.

Advanced options common to both: `colormap` (any Matplotlib colormap, or `videen_style`, based on the Connectome Workbench and nilearn scheme; defaults are `videen_style` for cortex maps and `hot` for endpoints), `min_percentile` and `max_percentile` (default 4 and 96) of the values above `threshold` that set the colour range.

The images are archived to your project as a `generic/images` dataset.

### Locally

You need [Singularity/Apptainer](https://apptainer.org/), [`jq`](https://jqlang.github.io/jq/) and a [FreeSurfer license](https://surfer.nmr.mgh.harvard.edu/registration.html). FreeSurfer (`brainlife/freesurfer-mini:6.0.1` or `brainlife/freesurfer:6.0.0`) and PySurfer (`brainlife/pysurfer:0.10.0`) are pulled as containers.

1. Clone this repository and check out the App branch (`git checkout v1.0` or `git checkout tract-endpoints-v1.0`).
2. Create `config.json` with the paths to your inputs and the options you want. For cortex-mapped data:

   ```json
   {
       "freesurfer": "testdata/freesurfer/output",
       "cortexmap": "testdata/cortexmap/",
       "surface": "midthickness",
       "fsaverage": "subject",
       "min_percentile": 4,
       "max_percentile": 96,
       "threshold": 0.00000001,
       "colormap": "videen_style"
   }
   ```

   For tract endpoints, replace `cortexmap` and `fsaverage` with `"rois": "testdata/rois/"` and choose `pial`, `white` or `inflated` as `surface`.

3. Export your license and run the App:

   ```bash
   export FREESURFER_LICENSE="$(cat ~/freesurfer/license.txt)"
   ./main
   ```

### Sample data

Download sample datasets from brainlife.io with the [brainlife CLI](https://github.com/brainlife/cli):

```bash
npm install -g brainlife
bl login
mkdir input
bl dataset download <dataset id>
```

## Outputs

```text
images/
├── cortexmap_<hemi>_<measure>_<view>.jpg   cortex-mapped data (views: lat, med)
└── <roi>_<view>.jpg                        tract endpoints (views: lateral, medial, rostral, caudal, ventral, dorsal)
```

For tract endpoints, files whose names contain `left`/`lh` or `right`/`rh` are drawn on that hemisphere only; other ROIs are drawn on both.

## Troubleshooting

- **`Please set FREESURFER_LICENSE in .bashrc`**: provide a FreeSurfer license in the `FREESURFER_LICENSE` environment variable.
- **`midthickness surface conversion failed. please check derivatives and logs`**: the cortexmap does not contain `surf/lh.midthickness.very_inflated.native.surf.gii` and its right-hemisphere pair. Check the cortexmap dataset, or draw on a FreeSurfer surface instead.
- **Tract endpoints land in the wrong place**: the ROIs are projected with `mri_vol2surf --regheader`, which assumes they are already aligned to the FreeSurfer subject.

## Citing

> [!TIP]
> If you use this App in your work, please cite the App, the software it builds on and brainlife.io (below). GitHub's **Cite this repository** button gives the App citation in APA and BibTeX.

- Gramfort A, Luessi M, Larson E, Engemann DA, Strohmeier D, Brodbeck C, Goj R, Jas M, Brooks T, Parkkonen L, Hämäläinen M. MEG and EEG data analysis with MNE-Python. *Frontiers in Neuroscience* 7:267 (2013). [doi:10.3389/fnins.2013.00267](https://doi.org/10.3389/fnins.2013.00267)
- Generate images of tract endpoints on cortical surface. brainlife.io App. [doi:10.25663/brainlife.app.555](https://doi.org/10.25663/brainlife.app.555)
- Fischl. FreeSurfer. *NeuroImage* 62:774-781 (2012). [doi:10.1016/j.neuroimage.2012.01.021](https://doi.org/10.1016/j.neuroimage.2012.01.021)
- Hayashi S, Caron BA, Heinsfeld AS, et al. brainlife.io: a decentralized and open-source cloud platform to support neuroscience research. *Nature Methods* 21:809–813 (2024). [doi:10.1038/s41592-024-02237-2](https://doi.org/10.1038/s41592-024-02237-2)
- Avesani P, McPherson B, Hayashi S, et al. The open diffusion data derivatives, brain data upcycling via integrated publishing of derivatives and reproducible open cloud services. *Scientific Data* 6:69 (2019). [doi:10.1038/s41597-019-0073-y](https://doi.org/10.1038/s41597-019-0073-y)

## Authors

- Brad Caron

**Contributors:** Soichi Hayashi

**Project director:** Franco Pestilli

## Funding

[![Wellcome-226486/Z/22/Z](https://img.shields.io/badge/Wellcome-226486%2FZ%2F22%2FZ-purple.svg)](https://wellcome.org/)
[![NIH-NINDS-U24NS140384](https://img.shields.io/badge/NIH_NINDS-U24NS140384-green.svg)](https://reporter.nih.gov/project-details/11261037)
[![NIH-NINDS-UM1NS132207](https://img.shields.io/badge/NIH_NINDS-UM1NS132207-green.svg)](https://reporter.nih.gov/project-details/11411328)
[![NIH-NIBIB-R01EB029272](https://img.shields.io/badge/NIH_NIBIB-R01EB029272-green.svg)](https://reporter.nih.gov/project-details/10262925)
[![NIH-NIBIB-R01EB030896](https://img.shields.io/badge/NIH_NIBIB-R01EB030896-green.svg)](https://reporter.nih.gov/project-details/10428625)
[![NIH-NIMH-R01MH126699](https://img.shields.io/badge/NIH_NIMH-R01MH126699-green.svg)](https://reporter.nih.gov/project-details/10460628)
[![NIH-NIDCD-R01DC020088](https://img.shields.io/badge/NIH_NIDCD-R01DC020088-green.svg)](https://reporter.nih.gov/project-details/11140284)
[![NSF-BCS-1734853](https://img.shields.io/badge/NSF_BCS-1734853-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1734853)
[![NSF-BCS-2203524](https://img.shields.io/badge/NSF_BCS-2203524-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2203524)
[![NSF-IIS-1636893](https://img.shields.io/badge/NSF_IIS-1636893-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1636893)
[![NSF-OAC-2148729](https://img.shields.io/badge/NSF_OAC-2148729-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2148729)
[![NSF-IIS-1912270](https://img.shields.io/badge/NSF_IIS-1912270-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1912270)
[![NSF-IIS-2148700](https://img.shields.io/badge/NSF_IIS-2148700-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2148700)
[![NSF-OAC-1916518](https://img.shields.io/badge/NSF_OAC-1916518-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1916518)

<sub>brainlife.io is publicly funded, and acknowledging that support helps keep it running. This App was developed with support from Wellcome, the U.S. National Institutes of Health (including the BRAIN Initiative BRAIN CONNECTS program: The Axonal Projectome EXchange, U24NS140384, and the Center for Mesoscale Connectomics, UM1NS132207) and the U.S. National Science Foundation.</sub>

## License

[MIT](LICENSE). FreeSurfer is distributed under its own [license](https://surfer.nmr.mgh.harvard.edu/fswiki/FreeSurferSoftwareLicense).
