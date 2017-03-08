# This file has automatically been generated
# biogeme 2.5 [Wed, Jul 27, 2016 1:52:51 PM]
# <a href='http://people.epfl.ch/michel.bierlaire'>Michel Bierlaire</a>, <a href='http://transp-or.epfl.ch'>Transport and Mobility Laboratory</a>, <a href='http://www.epfl.ch'>Ecole Polytechnique F&eacute;d&eacute;rale de Lausanne (EPFL)</a>
# 11/16/16 16:22:05</p>
#
ASC_TRAIN = Beta('ASC_TRAIN',-0.401825,-10,10,0,'ASC_TRAIN' )

B_TIME = Beta('B_TIME',-2.25983,-10,10,0,'B_TIME' )

B_TIME_S = Beta('B_TIME_S',-1.65769,-10,10,0,'B_TIME_S' )

B_COST = Beta('B_COST',-1.28537,-10,10,0,'B_COST' )

ASC_SM = Beta('ASC_SM',0,-10,10,1,'ASC_SM' )

ASC_CAR = Beta('ASC_CAR',0.1371,-10,10,0,'ASC_CAR' )


## Code for the sensitivity analysis
names = ['ASC_CAR','ASC_TRAIN','B_COST','B_TIME','B_TIME_S']
values = [[0.00267724,0.00223062,0.000130305,-0.00386512,-0.00284532],[0.00223062,0.00433562,-0.000302373,-0.00469986,-0.00145731],[0.000130305,-0.000302373,0.00744528,0.00372023,0.00320218],[-0.00386512,-0.00469986,0.00372023,0.013727,0.0114532],[-0.00284532,-0.00145731,0.00320218,0.0114532,0.0174027]]
vc = bioMatrix(5,names,values)
BIOGEME_OBJECT.VARCOVAR = vc
