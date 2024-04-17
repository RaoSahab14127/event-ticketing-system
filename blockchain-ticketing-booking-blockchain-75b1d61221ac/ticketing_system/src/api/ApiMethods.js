import { AppConstants } from "../../helpers/AppConstants";

export const UploadFileApi = (selectedFile, fileId) => {
    const formData = new FormData();
    formData.append('file', selectedFile);

    const requestOptions = {
        method: 'POST',
        body: formData
    };
    
    return fetch(`${AppConstants.baseURL + AppConstants.uploadImage}${fileId}`, requestOptions)
        .then(response => response.json())
}

export const getFileApi = async (fileId) => {
    const requestOptions = {
        method: 'GET',
    };

    return fetch(`${AppConstants.baseURL + AppConstants.getImage}${fileId}`, requestOptions)
        .then(response => response.json())
}