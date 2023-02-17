## Loading IDC Images into the DICOM Store and Connecting MONAILabel to the DICOM Store

## Enable the Healthcare API and grant storage permissions to the Service Agent
1. In the Cloud Admin Console Menu, select **API and Services** then **Enable APIs**
2. Find the API using a search for the string "healthcare"
3. Enable the Healthcare API
4. In the Cloud Admin Console Menu, select **IAM & Admin**, then **IAM**
5. On the right side, Check the box "Include Google-provided Role Grants"
6. In the service account list, find the Healthcare service account: gcp-sa-healthcare.iam.gserviceaccount.com
7. Click the **Edit button** next to the healthcare service account name
8. Use the add another role button and add the following roles
**BigQuery Data Editor**
**BigQuery Job User**
**Storage Object Admin**
9. Click **Save**

## Download a Cohort of Image from a IDC collection
1. In the Jupyter window, select the Folder icon and navigate to the top level, then "medical-imaging-labs/notebooks"
2. Double click to open the **build_collection_cohort.ipynb** notebook.
3. Execute the cells of the notebook one at a time to build a cohort and download the associated dcm files to a GCS bucket.

## Upload Cohort files from GCS bucket into a DICOM store
1. In the Jupyter window, select the Folder icon and navigate to the top level, then "medical-imaging-labs/notebooks"
2. Double click to open the **load_dicom_dataset.ipynb** notebook.
3. Execute the cells of the notebook one at a time to load the files into the DICOM store just created

## Start a new MONAILabel Server that uses the IDC images in DICOM Datastore
1. In the Jupyter window, open another terminal
2. Make a directory for the new server, install the radiology app
<ql-code-block language="bash" >
mkdir ~/server2
cd ~/server2
echo #### download radiology app and sample dataset ####
monailabel apps --download --name radiology --output apps
</ql-code-block>

3. Now start a MONAILabel server configured to use the DICOM store. We use the "start_monai_server.sh" script, you can browse that script to learn how to pass the address of the GCP DICOM store. Note that the script starts a server on port 8082
<ql-code-block language="bash" >
echo #### start the MONAILabel Server using the DICOM store created above
../medical-imaging-labs/scripts/start_monai_server.sh
</ql-code-block>

## Use the OHIF Viewer embedded in MONAILabel to inspect the DICOM images
1. Switch to the desktop tab named **noVNC**
2. At the lower bar open the Chrome browser (Earth icon)
3. Navigate to:
https://localhost:8082/ohif
4. Select an image and notice that is has no segmentations yet. You are now using the embedded OHIF Viewer in the MONAILabel server. You can now view the images that were uploaded to the DICOM store. In the next task we will export the image metada from the DICOM store to BigQuery.
