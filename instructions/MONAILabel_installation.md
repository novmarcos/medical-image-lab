## Install and verify the MONAILabel server
You should continue with these steps in the JupyterLab Terminal tab. You can execute these commands inside the desktop but you will not be able to copy and paste the commands so it will be a lot harder.

1. Chjange back to the jupyter user's home directory.
<ql-code-block language="bash" >
cd /home/jupyter
</ql-code-block>

2. Install the MONAILabel layer:
<ql-code-block language="bash" >
echo ### Install latest PIP version of MONAILabel
pip install --user monailabel
export PATH=/home/jupyter/.local/bin:$PATH
printf "export PATH=$PATH" >> /home/jupyter/.bashrc

</ql-code-block>

The MONAILabel installation can be verified by starting the MONAILabel server. 

Make a new directory, cd into it and follow the steps below to install a MONAI application download a local dataset and run the server:

2. Starting a MONAILabel server using local storage (Spleen Dataset from annotation Decatholon)

<ql-code-block language="bash" >
mkdir ~/server1
cd ~/server1
echo #### download radiology app and sample dataset ####
monailabel apps --download --name radiology --output apps
monailabel datasets --download --name Task09_Spleen --output datasets
echo #### start server using radiology app with deepedit model enabled ####
monailabel start_server --app apps/radiology --studies datasets/Task09_Spleen/imagesTr --conf models deepedit
</ql-code-block>

## Task 9. Installing and Using the MONAILabel Plugin for 3DSlicer
1. Switch to the desktop tab, labeled **noVNC**
2. Start a new instance of the 3DSlicer app. Open a terminal and execute the Slicer command:
<ql-code-block language="bash" >
~/Slicer/Slicer
</ql-code-block>
3. In the Welcome window, select "Install Extensions"
4. In the Extensions dialog, select the "Install Extensions" tab
5. In the list at the left, select **Active Learning**
6. Select the extension **MONAILabel**
7. Click "Install" and restart the 3DSlicer instance
8. In the new 3DSlicer instance, go to **Modules** > **Active Learnine** > **MONAILabel**
8. Maximize the window to see all fields of the MONAILabel plugin
10. In the MONAILabel plugin bar at the left, select the server field and enter
http://localhost:8000
11. In the "Active Learning" section, Click on the **Next Sample** button
12. In the "Auto Segmentation" section, Click on the **Run** button
13. To visualize the segmentations in 3D, expand the "Segment Editor" section and Click on **Show 3D**
14. Sometimes you have to zoom out to see the 3D visualization. Double click the 2nd quadrant (blue with the 3D cube) to maximize it.
15. Zoom out the 3D visualization by using two fingers on the mousepad with a stretch motion (moving the fingers apart)
16. Zoom in the 3D visualization by using two fingers on the mousepad with a contract motion (moving the fingers toward each other)
17. Rotate the 3D visualization using a Click and Drag motion
18. Drag the 3D visualization using the Shift key and a Click and Drag motion
19. Double click on the 3DVisualization window to return it to its regular size. You can optionally edit the segmentations using the Segment Editor tools.
20. When done editing submit the annotation by clicking on the **Submit Label**. This will save the edited label to the local storage database.
