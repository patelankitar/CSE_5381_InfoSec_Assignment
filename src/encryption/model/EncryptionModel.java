package encryption.model;

public class EncryptionModel {
	
	private String errorMessage; 
	private String inputPlainText; 
	private String inputCipherText;
	private String generatedPlainText; 
	private String generatedCipherText;
	private String key; 
	
	public String getErrorMessage() {
		return errorMessage;
	}
	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}
	public String getInputPlainText() {
		return inputPlainText;
	}
	public void setInputPlainText(String inputPlainText) {
		this.inputPlainText = inputPlainText;
	}
	public String getInputCipherText() {
		return inputCipherText;
	}
	public void setInputCipherText(String inputCipherText) {
		this.inputCipherText = inputCipherText;
	}
	public String getGeneratedPlainText() {
		return generatedPlainText;
	}
	public void setGeneratedPlainText(String generatedPlainText) {
		this.generatedPlainText = generatedPlainText;
	}
	public String getGeneratedCipherText() {
		return generatedCipherText;
	}
	public void setGeneratedCipherText(String generatedCipherText) {
		this.generatedCipherText = generatedCipherText;
	}
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	
}
