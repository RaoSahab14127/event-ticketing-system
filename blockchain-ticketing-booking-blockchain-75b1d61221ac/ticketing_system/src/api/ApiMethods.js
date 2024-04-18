import { AppConstants } from "../../helpers/AppConstants";

export const UploadFileApi = async (x) => {
    
 const requestOptions = {
        method: 'POST',
        body: new URLSearchParams({
            'event_id':x.event_id,    
            'des':x.des,
            'title':x.title,    
            'image_url': x.image_url,
 
        })
    };
    
    const response = await fetch(`http://localhost:8000/api/uploads`, requestOptions);
    return await response.json("done");
    
}