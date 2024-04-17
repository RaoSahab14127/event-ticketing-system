from fastapi import FastAPI, File, UploadFile
from fastapi.responses import JSONResponse
from fastapi.responses import FileResponse
from PIL import Image
from fastapi.middleware.cors import CORSMiddleware
from io import BytesIO
import shutil
from pathlib import Path

app = FastAPI()

origins = ["*"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


UPLOAD_FOLDER = Path("uploads")

@app.post("/upload/{file_id}")
async def create_upload_file(file_id: int, file: UploadFile = File(...)):
    file_extension = Path(file.filename).suffix.lower()

    # Convert to PNG if the uploaded file is not already in PNG format
    if file_extension != ".png":
        image = Image.open(BytesIO(await file.read()))
        png_filename = f"{file_id}.png"
        png_file_path = UPLOAD_FOLDER / png_filename
        image.save(png_file_path, "PNG")
    else:
        png_filename = f"{file_id}.png"
        png_file_path = UPLOAD_FOLDER / png_filename

        with png_file_path.open("wb") as buffer:
            shutil.copyfileobj(file.file, buffer)

    return JSONResponse(content={"filename": png_filename, "message": "File uploaded successfully"})


@app.get("/get_image/{file_id}")
async def get_image(file_id: int):
    filename = f"{file_id}.png" 
    file_path = f"{UPLOAD_FOLDER}/{filename}"

    return JSONResponse(content={"image_path": file_path}, status_code=200) 

    # if file_path.is_file():
    #     return JSONResponse(content={"image_path": file_path}, status_code=200) 
    # else:
        # return JSONResponse(content={"message": "File not found"}, status_code=404)