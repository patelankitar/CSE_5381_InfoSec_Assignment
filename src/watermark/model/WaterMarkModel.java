package watermark.model;

public class WaterMarkModel {
	
	private String originalImgPath;
	private String waterMarkedImgPath;
	private String textToWatermark;
	private String errorMessage;
	private String timeTaken;
	private String imageUploadMessage; 
	
	public String getTimeTaken() {
		return timeTaken;
	}

	public void setTimeTaken(String timeTaken) {
		this.timeTaken = timeTaken;
	}

	public String getErrorMessage() {
		return errorMessage;
	}

	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}

	public String getWaterMarkedImgPath() {
		return waterMarkedImgPath;
	}

	public void setWaterMarkedImgPath(String waterMarkedImgPath) {
		this.waterMarkedImgPath = waterMarkedImgPath;
	}
	
	public String getTextToWatermark() {
		return textToWatermark;
	}

	public void setTextToWatermark(String textToWatermark) {
		this.textToWatermark = textToWatermark;
	}

	public String getOriginalImgPath() {
		return originalImgPath;
	}

	public void setOriginalImgPath(String originalImgPath) {
		this.originalImgPath = originalImgPath;
	}

	public String getImageUploadMessage() {
		return imageUploadMessage;
	}

	public void setImageUploadMessage(String imageUploadMessage) {
		this.imageUploadMessage = imageUploadMessage;
	}

	
}
