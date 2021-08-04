#!/usr/bin/env python3.7

def generateMeasureOverlayImage(subjectID,surf,rois,measure_file,colormap,min_percentile,max_percentile,threshold,outdir,savename):

	import os,sys
	# import vtk
	os.environ['ETS_TOOLKIT'] = 'qt4'
	os.environ['QT_API'] = 'pyqt5'
	import pyvista
	from pyvista.utilities import xvfb
	pyvista.OFF_SCREEN=True
	xvfb.start_xvfb()
	from mne.viz import set_3d_backend
	set_3d_backend('pyvista')
	import mne
	import nibabel as nib
	import numpy as np
	from matplotlib.colors import LinearSegmentedColormap
	import matplotlib.pyplot as plt

	os.environ['SUBJECTS_DIR'] = './'
	os.environ['XDG_RUNTIME_DIR'] = './'
	os.environ['QT_AUTO_SCREEN_SCALE_FACTOR']='0'

	# set up videen_style from connectome workbench (positive range)
	if colormap == 'videen_style':
		colormap = ['#000000','#660033', '#33334c','#4c4c7f', '#7f7fcc', '#00ff00', '#10b010','#ffff00', '#ff9900', '#ff6900', '#ff0000']
		colormap = LinearSegmentedColormap.from_list('modified_videen',colormap,N=100)

	# load measure file gifti
	measure_file_data = nib.load(os.path.join(rois+'/'+measure_file))
	measure_file_data = measure_file_data.darrays[0].data

	if np.max(measure_file_data) > 0:
		if np.mean(measure_file_data) > 0:
			if len(measure_file_data[measure_file_data>0]) >= len(measure_file_data)*0.0001:
				
				# another failsafe to make sure vertices match
				hemi=measure_file.split('_')[0]

				# generate brain image of surface
				for figviews in ['lateral','medial','rostral','caudal','ventral','dorsal']:
					brain = mne.viz.Brain(subjectID,hemi,surf,offscreen=True,show=False,views=figviews)
					
					measure_file_data = nib.load(os.path.join(rois+'/'+measure_file))
					measure_file_data = measure_file_data.darrays[0].data

					threshold_verts = [ f for f in range(len(measure_file_data)) if measure_file_data[f] > threshold ]

					measure_file_data[measure_file_data <= threshold] = np.nan

					# compute min, median, and max percentiles
					min_percentile_value = np.float(np.percentile(measure_file_data[threshold_verts],min_percentile))
					max_percentile_value = np.float(np.percentile(measure_file_data[threshold_verts],max_percentile))
					median_percentile_value = np.float(np.mean([min_percentile_value,max_percentile_value]))

					# add measure file overlay. super hacky, but this was the only way i could get the colorbar to update properly
					# ,clim=dict(kind='kind',lims=([min_percentile_value,median_percentile_value,max_percentile_value])),colorbar_kwargs=dict(label_font_size=8)
					brain.add_data(measure_file_data,colormap=colormap,fmin=min_percentile_value,fmax=max_percentile_value,fmid=median_percentile_value,colorbar=False,clim=dict(kind='kind',lims=([min_percentile_value,median_percentile_value,max_percentile_value])))
					brain.update_lut()
					brain.add_data(measure_file_data,colormap=colormap,fmin=min_percentile_value,fmax=max_percentile_value,fmid=median_percentile_value,clim=dict(kind='kind',lims=([min_percentile_value,median_percentile_value,max_percentile_value])),colorbar_kwargs=dict(label_font_size=8))

					# save image
					# brain.save_image(outdir+'/'+savename+'_'+hemi+'_'+measure_file+'_'+figviews+'.png')
					brain.save_image(outdir+'/'+savename+'_'+measure_file.split('.gii')[0]+'_'+figviews+'.jpg')


					# close image
					brain.close()

def main():

	import os,sys
	import glob
	import json
	import numpy as np
	import matplotlib
	matplotlib.use('Agg')
	import os
	import json
	import numpy as np
	import nibabel as nib

		# grab config
	with open('config.json','r') as config_f:
		config = json.load(config_f)

	# set up paths and variables
	freesurfer='./freesurfer'
	rois='./rois'
	measureFiles=[ f.split(rois+'/')[1] for f in glob.glob(rois+'/*.gii') ]
	colormap = config['colormap']
	min_percentile = config['min_percentile']
	max_percentile = config['max_percentile']
	threshold = np.float(config['threshold'])
	surface = config['surface']

	#### set up other inputs ####
	# set outdir
	outdir = 'images'
	
	# generate output directory if not already there
	if os.path.isdir(outdir):
		print("directory exits")
	else:
		print("making output directory")
		os.mkdir(outdir)

	for i in measureFiles:
		generateMeasureOverlayImage(freesurfer,surface,rois,i,colormap,min_percentile,max_percentile,threshold,outdir,'endpoints')

if __name__ == '__main__':
	main()
