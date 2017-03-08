# This file has automatically been generated
# biogeme 2.5 [Wed, Jul 27, 2016 1:52:51 PM]
# <a href='http://people.epfl.ch/michel.bierlaire'>Michel Bierlaire</a>, <a href='http://transp-or.epfl.ch'>Transport and Mobility Laboratory</a>, <a href='http://www.epfl.ch'>Ecole Polytechnique F&eacute;d&eacute;rale de Lausanne (EPFL)</a>
# 11/23/16 10:35:49</p>
#
ASC_TRAIN = Beta('ASC_TRAIN',-0.701187,-10,10,0,'Train cte.' )

B_TIME = Beta('B_TIME',-1.27786,-10,10,0,'Travel time' )

B_COST = Beta('B_COST',-1.08379,-10,10,0,'Travel cost' )

ASC_CAR = Beta('ASC_CAR',-0.154633,-10,10,0,'Car cte.' )

ASC_SM = Beta('ASC_SM',0,-10,10,1,'Swissmetro cte.' )


## Code for the sensitivity analysis
names = ['ASC_CAR','ASC_TRAIN','B_COST','B_TIME']
values = [[0.00338298,0.00390132,2.864e-005,-0.00482422],[0.00390132,0.00681649,-0.000830567,-0.00760232],[2.864e-005,-0.000830567,0.00465465,0.002198],[-0.00482422,-0.00760232,0.002198,0.010869]]
vc = bioMatrix(4,names,values)
BIOGEME_OBJECT.VARCOVAR = vc
