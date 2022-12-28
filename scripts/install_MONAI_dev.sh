#Install Dev Version of MONAILabel
git clone https://github.com/Project-MONAI/MONAILabel
pip install --user -r MONAILabel/requirements.txt
PATH=`pwd`/MONAILabel/monailabel/scripts:$PATH
printf "export PATH=$PATH" >> /home/jupyter/.bashrc

