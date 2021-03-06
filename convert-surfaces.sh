#!/bin/bash

# config inputs
freesurfer=`jq -r '.freesurfer' config.json`
cortexmap=`jq -r '.cortexmap' config.json`
hemisphere="lh rh"

set -x

# make copies of freesurfer and cortexmap directories
cp -R ${freesurfer} ./output/ && chmod -R +rw ./output/
cp -R ${cortexmap} ./cortexmap/ && chmod -R +rw ./cortexmap/

# convert midthickness surfaces for pysurfer
for hemi in $hemisphere
do
	mris_convert ./cortexmap/surf/${hemi}.midthickness.very_inflated.native.surf.gii ./output/surf/${hemi}.midthickness.very_inflated
done

# check
if [ ! -f ./output/surf/lh.midthickness.very_inflated ] || [ ! -f ./output/surf/rh.midthickness.very_inflated ]; then
	echo "midthickness surface conversion failed. please check derivatives and logs"
	exit 1
else
	echo "midthickness surface converted"
fi
