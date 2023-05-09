#!/bin/bash

# config inputs
freesurfer=`jq -r '.freesurfer' config.json`
cortexmap=`jq -r '.cortexmap' config.json`
fsaverage=`jq -r '.fsaverage' config.json`
hemisphere="lh rh"

set -x

# make copies of freesurfer and cortexmap directories
if [[ ${fsaverage} != 'subject' ]]; then
	cp -R ./templates/${fsaverage} ./output
else
	cp -R ${freesurfer} ./output/ && chmod -R +rw ./output/
fi

cp -R ${cortexmap} ./cortexmap/ && chmod -R +rw ./cortexmap/

# convert midthickness surfaces for pysurfer
for hemi in $hemisphere
do
	mris_convert ./cortexmap/surf/${hemi}.midthickness.very_inflated.*.surf.gii ./output/surf/${hemi}.midthickness.very_inflated
done

# check
if [ ! -f ./output/surf/lh.midthickness.very_inflated ] || [ ! -f ./output/surf/rh.midthickness.very_inflated ]; then
	echo "midthickness surface conversion failed. please check derivatives and logs"
	exit 1
else
	echo "midthickness surface converted"
fi
