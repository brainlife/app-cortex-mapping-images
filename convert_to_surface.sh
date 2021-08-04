#!/bin/bash

# inputs
freesurfer=`jq -r '.freesurfer' config.json`
rois=`jq -r '.rois' config.json`

# top vars
hemi="lh rh"

[ ! -d ./freesurfer ] && cp -R ${freesurfer} ./freesurfer && freesurfer="./freesurfer" && chmod -R +rw ${freesurfer}
[ ! -d ./rois ] && cp -R ${rois} ./rois && rois="./rois" && chmod -R +rw ${rois}

roiFiles=`ls ${rois}`
export SUBJECTS_DIR=./
for i in ${roiFiles}
do
	measureName=${i//.nii.gz/}
	if [[ "${measureName}" == *"left"* ]] || [[ "${measureName}" == *"lh"* ]] || [[ "${measureName}" == *"LH"* ]] || [[ "${measureName}" == *"Left"* ]] || [[ "${measureName}" == *"LEFT"* ]]; then
		h="lh"
		[ ! -f "${rois}/${h}_${measureName}.gii" ] && mri_vol2surf --src ${rois}/${i} --hemi ${h} --surf white --regheader freesurfer --out "${rois}/${h}_${measureName}.gii" --projdist-max 0 4 .1
	elif [[ "${measureName}" == *"right"* ]] || [[ "${measureName}" == *"rh"* ]] || [[ "${measureName}" == *"RH"* ]] || [[ "${measureName}" == *"Right"* ]] || [[ "${measureName}" == *"RIGHT"* ]]; then
		h="rh"
		[ ! -f "${rois}/${h}_${measureName}.gii" ] && mri_vol2surf --src ${rois}/${i} --hemi ${h} --surf white --regheader freesurfer --out "${rois}/${h}_${measureName}.gii" --projdist-max 0 4 .1
	else
		for h in ${hemi}
		do
			[ ! -f "${rois}/${h}_${measureName}.gii" ] && mri_vol2surf --src ${rois}/${i} --hemi ${h} --surf white --regheader freesurfer --out "${rois}/${h}_${measureName}.gii" --projdist-max 0 4 .1
		done
	fi
done
