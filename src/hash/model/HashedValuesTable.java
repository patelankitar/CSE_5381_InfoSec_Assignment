package hash.model;

public class HashedValuesTable {
	
	private String inputText; 
	private String hashedValue;
	private String timeTaken;
	
	public String getTimeTaken() {
		return timeTaken;
	}
	public void setTimeTaken(String timeTaken) {
		this.timeTaken = timeTaken;
	}
	public String getInputText() {
		return inputText;
	}
	public void setInputText(String inputText) {
		this.inputText = inputText;
	}
	
	public String getHashedValue() {
		return hashedValue;
	}
	public void setHashedValue(String hashedValue) {
		this.hashedValue = hashedValue;
	} 
	

}
