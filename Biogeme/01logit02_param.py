# This file has automatically been generated
# biogeme 2.5 [Wed, Jul 27, 2016 1:52:51 PM]
# <a href='http://people.epfl.ch/michel.bierlaire'>Michel Bierlaire</a>, <a href='http://transp-or.epfl.ch'>Transport and Mobility Laboratory</a>, <a href='http://www.epfl.ch'>Ecole Polytechnique F&eacute;d&eacute;rale de Lausanne (EPFL)</a>
# 11/16/16 20:11:04</p>
#
ASC_TRAIN = Beta('ASC_TRAIN',0.627914,-10,10,0,'Train cte.' )

B_TIME_TRAIN = Beta('B_TIME_TRAIN',-1.79127,-10,10,0,'Travel time' )

B_COST = Beta('B_COST',-1.07045,-10,10,0,'Travel cost' )

B_HE = Beta('B_HE',-0.484498,-10,10,0,'Vehicle Headway' )

ASC_SM = Beta('ASC_SM',0,-10,10,1,'Swissmetro cte.' )

B_TIME_SM = Beta('B_TIME_SM',-1.11311,-10,10,0,'Travel time' )

ASC_CAR = Beta('ASC_CAR',-0.212645,-10,10,0,'Car cte.' )

B_TIME_CAR = Beta('B_TIME_CAR',-1.16356,-10,10,0,'Travel time' )


## Code for the sensitivity analysis
names = ['ASC_CAR','ASC_TRAIN','B_COST','B_HE','B_TIME_CAR','B_TIME_SM','B_TIME_TRAIN']
values = [[0.0156891,0.00512989,-0.000979528,0.00218045,-0.00403271,0.0104954,0.00196069],[0.00512989,0.0169989,-0.000218532,-0.00434087,-0.000656967,0.00551082,-0.00673107],[-0.000979528,-0.000218532,0.00458634,-1.65134e-005,0.00232203,0.00127454,0.00129959],[0.00218045,-0.00434087,-1.65134e-005,0.00968484,-4.93189e-005,0.000107994,0.000149116],[-0.00403271,-0.000656967,0.00232203,-4.93189e-005,0.0123363,0.0143269,0.00806348],[0.0104954,0.00551082,0.00127454,0.000107994,0.0143269,0.0347964,0.0147844],[0.00196069,-0.00673107,0.00129959,0.000149116,0.00806348,0.0147844,0.0127728]]
vc = bioMatrix(7,names,values)
BIOGEME_OBJECT.VARCOVAR = vc
