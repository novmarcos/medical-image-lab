## Installing and Configuring the 3DSlicer Jupyter Kernel Configuration
After running the installation scripts you should now have a Desktop icon in your Jupyter Launcher window and confirmed that you can access the VM desktop. You can now start the 3DSlicer application and and install the Jupyter extensions that enable 3DSlicer to work in a Jupyter environment as described here: https://github.com/Slicer/SlicerJupyter

### 1. Launch 3DSlicer and install extensions

1. Click the **Desktop icon**.

2. You will see a dailog saying **Welcome to the first start of the panel**.

3. Click **Use default config**.

4. Double click **File System** icon on the LXCE Desktop to open the File Manager.

5. Under Places click **jupyter** and then click **Slicer** or navigate to `/home/jupyter/Slicer`. 

6. Double-click the **Slicer** icon in `/home/jupyter/Slicer` to start 3DSlicer. 

7. In the initial **Thank you for using Slicer** dialog, select **Don't show this message again and always OK**.

8. Click **OK**.

9. Click **Install Extensions**.

If you cannot see the **Install Extensions** button click the dropdown list next to **Modules** and select the **Welcome to Slicer** module. 

10. Wait for the **Extensions Manager** to launch. 

11. Search for, select, and then install each of the following extensions, you'll need to restart Slicer after each installation:
* DCMQI
* DICOMwebBrowser
* PETDICOMExtension
* QuantitativeReporting
* SlicerDevelopmenttoolbox
* SlicerJupyter
* SlicerRT


12. Click **Restart** to close 3DSlicer and restart to complete module installation. 

Note if you accidentally close and restart Slicer before finishing the installation you may need to select the **Welcome to Slicer** module again in order to locate the **Install Extensions** button. 

13. In the initial **Are you sure you want to restart?** dialog, select **Don't show this message again and always OK**.

14. Click **OK**.

### 2. Generate and install the 3DSlicer Jupyter Kernel 
After the installation of the SlicerJupyter extension, the 3DSlicer Jupyter Kernel needs to be generated and installed. 

1. In the 3DSlicer application click the drop down list next to the **Modules** search icon that starts with **Welcome to Slicer**.

2. Select the **JupyterKernel** option  under the **Developer tools** folder.
![Slicer Developer tools jupyterkernel menu](img/slicer-jupyterkernel.png)

3. Select **Jupyter server in an external Python environment**.
This will generate a kernel file and the installation command as shown below:

![3Dslicer Medical Imaging plugins list](img/3dslicer-plugins.png)

4. Run the following command block to install the Slicer 3D Jupyter Kernel
Switch to the Jupyer Notebook view and open a terminal window. 

    <ql-code-block language="bash" >
    cd ~/Slicer/NA-MIC/Extensions-31126/SlicerJupyter/share/Slicer-5.1/qt-loadable-modules/JupyterKernel/Slicer-5.1
    mv Slicer-32x32.png logo-32x32.png
    mv Slicer-64x64.png logo-64x64.png
    cd ..
    jupyter-kernelspec install Slicer-5.1 --replace --user
    </ql-code-block>
    
### 3. Running 3DSlicer Notebooks
1. In the Jupyter window, select the Foldeer icon to go to the top directory
In the Jupyer Menu, select **Git** then "Clone Repository" and enter the URL below:
https://github.com/Slicer/SlicerNotebooks.git
2. CD to the **SlicerNotebooks"** directory
3. Open the notebooks entitled ** 01_Data_Loading_and_Display**
4. In the Kernel selection dialog, click on "Slicer 5.1"
5. Execute the first cell of the notebook
6. There is a problem that causes the kernel to die, you will get a warning that it is restartig, click "OK"
7. Now go back to the first cell and execute it again
8. You can now proceed with the notebook and learn how the notebok interacts with 3DSlicer 
9. Verify that the notebook has generated and manages a Slicer instance. Switch to the desktop tab in the browser entitled **noVNC**. Find the 3DSlicer tab in the desktop, selecting that tab will display the Slicer instance that is managed by the notebook. You should see that in the bottom of the Slicer window it is noted: "This application is managed by Jupyter". You should not exit this instance while the notebook is running. When you are done running the notebook, you can terminate the Slicer kernel selecting the stop button in the left bar and in the Kernels list you can click on the "X" icon to kil the Slicer Kernel. This will in turn exit the instance that is running on the desktop.
