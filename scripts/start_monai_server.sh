# start MONAILabel Server pointing at specific datastore
PROJ=$(gcloud config list --format 'value(core.project)' 2>/dev/null)
echo "Using project $PROJ"
echo "Starting MONAILabel with DICOM endpoint: https://healthcare.googleapis.com/v1/projects/$PROJ/locations/us-central1/datasets/radiology/dicomStores/LCTSC/dicomWeb" 
monailabel start_server --app apps/radiology --studies https://healthcare.googleapis.com/v1/projects/$PROJ/locations/us-central1/datasets/radiology/dicomStores/LCTSC/dicomWeb --port 8002 --conf models deepedit