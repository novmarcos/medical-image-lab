conda install -y -c conda-forge nodejs
npm install --global yarn
pip uninstall --yes jupyterlab_widgets
#verify: jupyter labextension list
pip install --user ipycanvas
#verify: jupyter labextension list
NODE_OPTIONS=--max-old-space-size=8192 jupyter labextension update --all
pip install --user --no-deps ipyevents
#verify pip show ipywidgets

