# Google Cloud Medical Imaging Lab Installation and Configuration

The following directions will install the required JupyterLab extensions, guide you through configuring the additional components and also loading public medical image datasets to your Cloud project. These directions should be followed in sequence:

1. ![installation.md](/installation.md) : directions on running the installation script that extends Jupyterlab and installs the JupyterDesktop feature and the 3DSlicer Application.
2. ![3DSlicer_kernel_config.md](/3DSlicer_kernel_config.md) : directions on how to configure the 3DSlicer Jupyter kernel and run 3DSlicer notebooks as described in this project: https://github.com/Slicer/SlicerNotebooks
3. ![MONAILabel_installation.md](/MONAILabel_installation.md) : directions on how to install the MONAILabel server and the MONAILabel plugin for 3DSlicer
4. ![Working_with_IDC_Datasets.md](/Working_with_IDC_Datasets.md) : directions on how to download images from the Image Data Commons (IDC) (https://portal.imaging.datacommons.cancer.gov/) and how to build a dashboard in Looker Studio
5. ![Load_Images_to_DICOM_store.md](/Load_Images_to_DICOM_store.md) : directions on how to retrieve a cohort of images from the IDC, load them into your project's DICOM store using the Google Cloud Healthcare API, and then using the DICOM store as a backend database for MONAILabel.
6. ![Managing_Segmentations.md](/Managing_Segmentations.md) : directions on how to configure the streaming export of DICOM metadata into Big Query and how to build a custom dashboard in Looker Studio to inspect segmentations as they are produced by MONAILabel.

