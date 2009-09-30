init_shogun

addpath('tools');
label_train=load_matrix('../data/label_train_twoclass.dat');
fm_train=load_matrix('../data/fm_train_real.dat');
fm_test=load_matrix('../data/fm_test_real.dat');

% libsvm based support vector regression
if exist('SVRLight')
	disp('SVRLight')

	feats_train=RealFeatures(fm_train);
	feats_test=RealFeatures(fm_test);
	width=2.1;
	kernel=GaussianKernel(feats_train, feats_train, width);

	C=0.017;
	epsilon=1e-5;
	tube_epsilon=1e-2;
	num_threads=3;
	labels=Labels(label_train);

	svr=SVRLight(C, epsilon, kernel, labels);
	svr.set_tube_epsilon(tube_epsilon);
	svr.parallel.set_num_threads(num_threads);
	svr.train();

	kernel.init(feats_train, feats_test);
	svr.classify().get_labels();
else
	disp('No support for SVRLight available.')
end
